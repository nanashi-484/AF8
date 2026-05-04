
module fp8_decoder(
    input logic [7:0] in_data,

    output logic       sign,
    output logic [3:0] exp,
    output logic [3:0] man_with_hidden,

    output logic       is_zero,
    output logic       is_nan_inf
);

    logic [3:0] exp_field;
    logic [2:0] man_field;

    always_comb begin
        sign     = in_data[7];
        exp_field = in_data[6:3];
        man_field = in_data[2:0];

        is_zero   = (exp_field == 4'b0000) && (man_field == 3'b000);
        is_nan_inf = (exp_field == 4'b1111);

        // Subnormal (E=0): effective exponent = 1 to preserve correct bias in multiplier
        exp = (exp_field == 4'b0000) ? 4'd1 : exp_field;
        man_with_hidden = (exp_field == 4'b0000) ? {1'b0, man_field} : {1'b1, man_field};
    end

endmodule

module fp8_multiplier(
    input  logic       sign_a,
    input  logic [3:0] exp_a,
    input  logic [3:0] man_a, 
    
    input  logic       sign_w,
    input  logic [3:0] exp_w,
    input  logic [3:0] man_w,
    
    output logic               sign_prod,
    output logic signed  [5:0] exp_prod, 
    output logic         [7:0] man_prod
);
    
    always_comb begin
        sign_prod = sign_a ^ sign_w;
        man_prod = man_a * man_w;
        // Internal mantissa: {man_prod, 20'b0}, binary point at bit 20.
        // Internal value = man_int × 2^(exp - 14) must equal product value.
        // Product value = (man_prod/64) × 2^(E_a+E_w-14) = man_prod × 2^(E_a+E_w-20).
        // Therefore: exp - 14 = E_a + E_w - 20  →  exp = E_a + E_w - 6.
        exp_prod = signed'({2'b00, exp_a}) + signed'({2'b00, exp_w}) - 6'sd6;
    end

endmodule

module fp8_to_fp32_aligner #(
    parameter int MANT_WIDTH = 28
) (
    // FP8 prod
    input  logic signed [5:0]            exp_prod,
    input  logic        [7:0]            man_prod,

    // acc
    input  logic signed [7:0]            exp_acc,
    input  logic        [MANT_WIDTH-1:0] man_acc,

    // 輸出到下一級
    output logic signed [7:0]            exp_common,
    output logic        [MANT_WIDTH-1:0] aligned_man_prod,
    output logic        [MANT_WIDTH-1:0] aligned_man_acc
);

    logic signed [7:0] exp_prod_fp32;
    logic signed [7:0] exp_diff;
    logic [4:0]        shift_amount;
    logic              prod_is_smaller;

    logic [MANT_WIDTH-1:0] padded_man_prod;
    logic [MANT_WIDTH-1:0] padded_man_acc;

    always_comb begin
        exp_prod_fp32 = 8'(exp_prod);

        prod_is_smaller = (exp_acc > exp_prod_fp32);
        exp_common = prod_is_smaller ? exp_acc : exp_prod_fp32;
        exp_diff = prod_is_smaller ? (exp_acc - exp_prod_fp32) : (exp_prod_fp32 - exp_acc);

        shift_amount = (exp_diff > 8'd31) ? 5'd31 : exp_diff[4:0];

        padded_man_prod = {man_prod, {(MANT_WIDTH - 8){1'b0}}};
        padded_man_acc  = man_acc;

        // Barrel Shifter
        if (prod_is_smaller) begin
            aligned_man_prod = padded_man_prod >> shift_amount;
            aligned_man_acc  = padded_man_acc;
        end else begin
            aligned_man_prod = padded_man_prod;
            aligned_man_acc  = padded_man_acc >> shift_amount;
        end
    end

endmodule


module fp8_adder #(
    parameter int MANT_WIDTH = 28    // FP32: 24-bit mantissa + 4 guard bits
) (
    input  logic                       sign_a,
    input  logic                       sign_b,
    input  logic [MANT_WIDTH-1:0]      mant_a,
    input  logic [MANT_WIDTH-1:0]      mant_b,
    input  logic signed [7:0]          exp_common,
    output logic                       sign_out,
    output logic [MANT_WIDTH:0]        mant_out,
    output logic signed [7:0]          exp_out
);

    logic                 signs_differ;
    logic                 a_ge_b;
    logic [MANT_WIDTH-1:0] smaller_mant;
    logic [MANT_WIDTH-1:0] larger_mant;

    assign signs_differ = sign_a ^ sign_b;

    // Compare magnitudes for subtraction case
    assign a_ge_b = mant_a >= mant_b;

    // Select larger/smaller mantissa when signs differ
    assign larger_mant  = a_ge_b ? mant_a : mant_b;
    assign smaller_mant = a_ge_b ? mant_b : mant_a;

    always_comb begin
        if (signs_differ) begin
            // Subtraction: larger - smaller
            mant_out  = {1'b0, larger_mant} - {1'b0, smaller_mant};
            sign_out  = a_ge_b ? sign_a : sign_b;
        end else begin
            // Addition: mant_a + mant_b (carry may set MSB)
            mant_out  = {1'b0, mant_a} + {1'b0, mant_b};
            sign_out  = sign_a;
        end
    end

    assign exp_out = exp_common;

endmodule


module fp8_normalizer #(
    parameter int MANT_WIDTH = 28
) (
    input  logic                       sign_in,
    input  logic [MANT_WIDTH:0]        mant_in,
    input  logic signed [7:0]          exp_in,
    // FP8 E4M3 output
    output logic [7:0]                 fp8_out,
    // Accumulator output (full precision, normalized)
    output logic                       acc_sign,
    output logic signed [7:0]          acc_exp,
    output logic [MANT_WIDTH-1:0]      acc_mant
);

    // ── Stage 1: Carry adjustment ──
    logic [MANT_WIDTH-1:0] mant_carry;
    logic signed [7:0]     exp_carry;

    always_comb begin
        if (mant_in[MANT_WIDTH]) begin
            mant_carry = mant_in[MANT_WIDTH:1];
            exp_carry  = exp_in + 8'sd1;
        end else begin
            mant_carry = mant_in[MANT_WIDTH-1:0];
            exp_carry  = exp_in;
        end
    end

    // ── Zero detection ──
    logic is_zero;
    assign is_zero = (mant_carry == '0);

    // ── Stage 2: LZD + normalization ──
    logic [4:0]              lzd_count;
    logic [MANT_WIDTH-1:0]   mant_norm;
    logic signed [7:0]       exp_norm;

    always_comb begin
        lzd_count = 5'd0;
        for (int i = 0; i < MANT_WIDTH; i++) begin
            if (!mant_carry[MANT_WIDTH-1-i] && (lzd_count == 5'(i)))
                lzd_count = lzd_count + 5'd1;
        end
    end

    always_comb begin
        if (is_zero) begin
            mant_norm = '0;
            exp_norm  = 8'sd0;
        end else if (exp_carry >= $signed({3'b0, lzd_count})) begin
            // Enough exponent budget for full normalization
            mant_norm = mant_carry << lzd_count;
            exp_norm  = exp_carry - $signed({3'b0, lzd_count});
        end else if (exp_carry > 0) begin
            // Partial: exp positive but less than lzd_count
            mant_norm = mant_carry << exp_carry;
            exp_norm  = 8'sd0;
        end else begin
            // exp_carry <= 0: keep mantissa as-is with negative exponent
            // The FP8 output path handles denormalization via sub_shift
            mant_norm = mant_carry;
            exp_norm  = exp_carry;
        end
    end

    // ── Accumulator output (may have negative exp) ──
    assign acc_sign = sign_in;
    assign acc_exp  = exp_norm;
    assign acc_mant = mant_norm;

    // ── Stage 3: FP8 E4M3 Rounding & Packing ──
    // FP8 E4M3: 1 sign + 4 exp + 3 mant | bias=7 | E=15 reserved for NaN
    localparam int DENORM_SHIFT = MANT_WIDTH - 3;  // = 25

    logic [2:0] m_out;
    logic [3:0] e_out;

    always_comb begin
        if (is_zero) begin
            m_out = 3'd0;
            e_out = 4'd0;

        end else if (exp_norm >= 8'sd1) begin
            // ── Normal path: mantissa is fully normalized (MSB = 1) ──
            logic [2:0] m_field_n;
            logic       g_n, r_n, s_n, round_n, overflow_n;
            logic [3:0] mant_rnd;
            logic signed [7:0] exp_rnd;

            m_field_n = mant_norm[MANT_WIDTH-2 -: 3];
            g_n       = mant_norm[MANT_WIDTH-5];
            r_n       = mant_norm[MANT_WIDTH-6];
            s_n       = |mant_norm[MANT_WIDTH-7 : 0];
            round_n   = g_n & (r_n | s_n | m_field_n[0]);

            // {1'b1, m_field_n} ∈ [8, 15]; overflow only when M=7 and round=1
            overflow_n = (m_field_n == 3'b111) && round_n;
            mant_rnd   = overflow_n ? 4'b1000 : ({1'b1, m_field_n} + {3'b0, round_n});
            exp_rnd    = overflow_n ? (exp_norm + 8'sd1) : exp_norm;

            if (exp_rnd >= 8'sd15) begin
                // Overflow → NaN
                m_out = 3'b100;
                e_out = 4'd15;
            end else begin
                m_out = mant_rnd[2:0];
                e_out = exp_rnd[3:0];
            end

        end else begin
            // ── Subnormal path (exp_norm <= 0) ──
            // Internal value = mant_norm × 2^(exp_norm - 7)
            // FP8 subnormal: value = M/8 × 2^(-6) = M × 2^(-9)
            // M = mant_norm × 2^(exp_norm + 2)
            logic signed [7:0] sub_shift;
            logic [3:0] m_sub_int;
            logic       g_sub, r_sub, s_sub, round_sub;
            logic [3:0] m_sub_rnd;

            sub_shift = DENORM_SHIFT - exp_norm;  // right-shift amount

            if (sub_shift >= MANT_WIDTH) begin
                // Value too small → underflow to zero
                m_out = 3'd0;
                e_out = 4'd0;
            end else begin
                m_sub_int = {1'b0, mant_norm >> sub_shift};
                g_sub     = mant_norm[sub_shift-1];
                r_sub     = (sub_shift >= 2) ? mant_norm[sub_shift-2] : 1'b0;
                s_sub = 1'b0;
                if (sub_shift >= 3)
                    for (int j = 0; j < sub_shift - 2; j++)
                        s_sub = s_sub | mant_norm[j];
                round_sub = g_sub & (r_sub | s_sub | m_sub_int[0]);

                m_sub_rnd = m_sub_int + {3'b0, round_sub};

                if (m_sub_rnd >= 4'd8) begin
                    // Rounding overflow → smallest normal
                    m_out = 3'd0;
                    e_out = 4'd1;
                end else begin
                    m_out = m_sub_rnd[2:0];
                    e_out = 4'd0;
                end
            end
        end
    end

    assign fp8_out = {sign_in, e_out, m_out};

endmodule


module fp8_acc_register #(
    parameter int MANT_WIDTH = 28
) (
    input  logic                       clk,
    input  logic                       rst_n,
    // From Normalizer
    input  logic                       acc_sign_in,
    input  logic signed [7:0]          acc_exp_in,
    input  logic [MANT_WIDTH-1:0]      acc_mant_in,
    // To Aligner
    output logic                       acc_sign_out,
    output logic signed [7:0]          acc_exp_out,
    output logic [MANT_WIDTH-1:0]      acc_mant_out
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_sign_out <= 1'b0;
            acc_exp_out  <= 8'sd0;
            acc_mant_out <= '0;
        end else begin
            acc_sign_out <= acc_sign_in;
            acc_exp_out  <= acc_exp_in;
            acc_mant_out <= acc_mant_in;
        end
    end

endmodule


module FP8_MAC #(
    parameter int MANT_WIDTH = 28
) (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  in_a,
    input  logic [7:0]  in_b,
    input  logic        acc_clear,
    output logic [7:0]  out_result
);

    // ── Decoder outputs ──
    logic       sign_a, sign_b;
    logic [3:0] exp_a, exp_b;
    logic [3:0] man_a, man_b;
    logic       is_zero_a, is_zero_b;
    logic       is_nan_a, is_nan_b;

    // ── Multiplier outputs ──
    logic               sign_prod;
    logic signed [5:0]  exp_prod;
    logic [7:0]         man_prod;

    // ── Accumulator register feedback ──
    logic                       acc_sign;
    logic signed [7:0]          acc_exp;
    logic [MANT_WIDTH-1:0]      acc_mant;

    // ── After acc_clear mux (to Aligner) ──
    logic                       acc_sign_mux;
    logic signed [7:0]          acc_exp_mux;
    logic [MANT_WIDTH-1:0]      acc_mant_mux;

    // ── Aligner outputs ──
    logic signed [7:0]          exp_common;
    logic [MANT_WIDTH-1:0]      aligned_man_prod;
    logic [MANT_WIDTH-1:0]      aligned_man_acc;

    // ── Adder outputs ──
    logic                       adder_sign;
    logic [MANT_WIDTH:0]        adder_mant;
    logic signed [7:0]          adder_exp;

    // ── Normalizer outputs ──
    logic                       norm_sign;
    logic signed [7:0]          norm_exp;
    logic [MANT_WIDTH-1:0]      norm_mant;
    logic [7:0]                 fp8_result;

    // ── Control flags ──
    logic is_nan_input;

    assign is_nan_input = is_nan_a | is_nan_b;

    // ── Decoder ×2 ──
    fp8_decoder u_decoder_a (
        .in_data     (in_a),
        .sign        (sign_a),
        .exp         (exp_a),
        .man_with_hidden (man_a),
        .is_zero     (is_zero_a),
        .is_nan_inf  (is_nan_a)
    );

    fp8_decoder u_decoder_b (
        .in_data     (in_b),
        .sign        (sign_b),
        .exp         (exp_b),
        .man_with_hidden (man_b),
        .is_zero     (is_zero_b),
        .is_nan_inf  (is_nan_b)
    );

    // ── Multiplier ──
    fp8_multiplier u_multiplier (
        .sign_a     (sign_a),
        .exp_a      (exp_a),
        .man_a      (man_a),
        .sign_w     (sign_b),
        .exp_w      (exp_b),
        .man_w      (man_b),
        .sign_prod  (sign_prod),
        .exp_prod   (exp_prod),
        .man_prod   (man_prod)
    );

    // ── acc_clear mux: clear → accumulator term = 0 ──
    assign acc_sign_mux = acc_clear ? 1'b0 : acc_sign;
    assign acc_exp_mux  = acc_clear ? 8'sd0 : acc_exp;
    assign acc_mant_mux = acc_clear ? '0    : acc_mant;

    // ── Aligner ──
    fp8_to_fp32_aligner #(
        .MANT_WIDTH (MANT_WIDTH)
    ) u_aligner (
        .exp_prod          (exp_prod),
        .man_prod          (man_prod),
        .exp_acc           (acc_exp_mux),
        .man_acc           (acc_mant_mux),
        .exp_common        (exp_common),
        .aligned_man_prod  (aligned_man_prod),
        .aligned_man_acc   (aligned_man_acc)
    );

    // ── Adder ──
    fp8_adder #(
        .MANT_WIDTH (MANT_WIDTH)
    ) u_adder (
        .sign_a     (sign_prod),
        .sign_b     (acc_sign_mux),
        .mant_a     (aligned_man_prod),
        .mant_b     (aligned_man_acc),
        .exp_common (exp_common),
        .sign_out   (adder_sign),
        .mant_out   (adder_mant),
        .exp_out    (adder_exp)
    );

    // ── Normalizer ──
    fp8_normalizer #(
        .MANT_WIDTH (MANT_WIDTH)
    ) u_normalizer (
        .sign_in   (adder_sign),
        .mant_in   (adder_mant),
        .exp_in    (adder_exp),
        .fp8_out   (fp8_result),
        .acc_sign  (norm_sign),
        .acc_exp   (norm_exp),
        .acc_mant  (norm_mant)
    );

    // ── Accumulator Register (NaN → force clear) ──
    fp8_acc_register #(
        .MANT_WIDTH (MANT_WIDTH)
    ) u_acc_register (
        .clk           (clk),
        .rst_n         (rst_n),
        .acc_sign_in   (is_nan_input ? 1'b0 : norm_sign),
        .acc_exp_in    (is_nan_input ? 8'sd0 : norm_exp),
        .acc_mant_in   (is_nan_input ? '0    : norm_mant),
        .acc_sign_out  (acc_sign),
        .acc_exp_out   (acc_exp),
        .acc_mant_out  (acc_mant)
    );

    // ── Output: NaN propagation ──
    assign out_result = is_nan_input ? {1'b0, 4'd15, 3'b100} : fp8_result;

endmodule
