
module fp8_decoder(
    input logic [7:0] in_data,

    output logic       sign,
    output logic [3:0] exp,
    output logic [3:0] man_with_hidden, 
    
    output logic       is_zero,
    output logic       is_nan_inf
);

    logic [2:0] man_without_hidden;

    always_comb begin
        sign = in_data[7];
        exp = in_data[6:3];
        man_without_hidden = in_data[2:0];

        is_zero = (exp == 4'b0000) && (man_without_hidden == 3'b000);
        is_nan_inf = (exp == 4'b1111);

        man_with_hidden = (exp == 4'b0000)? {1'b0 , man_without_hidden} : {1'b1 , man_without_hidden};

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
        exp_prod = signed'({2'b00, exp_a}) + signed'({2'b00, exp_w}) - 6'sd7;
    end

endmodule

module fp8_to_fp32_aligner #(
    parameter int MANT_WIDTH = 28 
) (
    // FP8 prod
    input  logic signed [5:0]            exp_prod,
    input  logic        [7:0]            man_prod,

    // acc prod
    input  logic        [9:0]            exp_acc,
    input  logic        [MANT_WIDTH-1:0] man_acc,

    // 輸出到下一級
    output logic        [9:0]            exp_common,
    output logic        [MANT_WIDTH-1:0] aligned_man_prod,
    output logic        [MANT_WIDTH-1:0] aligned_man_acc
);

    logic [9:0] exp_prod_fp32;
    logic [9:0] exp_diff;
    logic [4:0] shift_amount;
    logic       prod_is_smaller;

    logic [MANT_WIDTH-1:0] padded_man_prod;
    logic [MANT_WIDTH-1:0] padded_man_acc;

    always_comb begin
        // FP8 Bias to FP32 Bias ( - 7 + 127 = +120)
        //exp_prod_fp32 = 10'(exp_prod) + 10'd120;
        exp_prod_fp32 = 10'(exp_prod);

        prod_is_smaller = (exp_acc > exp_prod_fp32);
        exp_common = prod_is_smaller ? exp_acc : exp_prod_fp32;
        exp_diff = prod_is_smaller ? (exp_acc - exp_prod_fp32) : (exp_prod_fp32 - exp_acc);

        shift_amount = (exp_diff > 10'd31) ? 5'd31 : exp_diff[4:0];

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
    input  logic [7:0]                 exp_common,
    output logic                       sign_out,
    output logic [MANT_WIDTH:0]        mant_out,
    output logic [7:0]                 exp_out
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
    input  logic [7:0]                 exp_in,
    // FP8 E4M3 output
    output logic [7:0]                 fp8_out,
    // Accumulator output (full precision, normalized)
    output logic                       acc_sign,
    output logic [7:0]                 acc_exp,
    output logic [MANT_WIDTH-1:0]      acc_mant
);

    // ── Stage 1: Carry adjustment ──
    logic [MANT_WIDTH-1:0] mant_carry;
    logic [7:0]            exp_carry;

    always_comb begin
        if (mant_in[MANT_WIDTH]) begin
            mant_carry = mant_in[MANT_WIDTH:1];
            exp_carry  = exp_in + 8'd1;
        end else begin
            mant_carry = mant_in[MANT_WIDTH-1:0];
            exp_carry  = exp_in;
        end
    end

    // ── Zero detection ──
    logic is_zero;
    assign is_zero = (mant_carry == '0);

    // ── Stage 2: LZD + normalization ──
    logic [4:0] lzd_count;
    logic [MANT_WIDTH-1:0] mant_norm;
    logic [7:0]            exp_norm;

    always_comb begin
        lzd_count = 5'd0;
        for (int i = MANT_WIDTH-1; i >= 0; i--) begin
            if (mant_carry[i]) break;
            lzd_count = lzd_count + 5'd1;
        end
    end

    always_comb begin
        if (is_zero) begin
            mant_norm = '0;
            exp_norm  = 8'd0;
        end else if ({3'b0, lzd_count} <= exp_carry) begin
            // Fully normalized: hidden bit at [MANT_WIDTH-1]
            mant_norm = mant_carry << lzd_count;
            exp_norm  = exp_carry - {3'b0, lzd_count};
        end else begin
            // Partial normalization: exp too small, shift as much as possible
            mant_norm = mant_carry << exp_carry;
            exp_norm  = 8'd0;
        end
    end

    // ── Accumulator output ──
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

        end else if (exp_norm >= 8'd1) begin
            // ── Normal path: mantissa is fully normalized (MSB = 1) ──
            // Round fractional part to 3 bits using RNE
            logic [2:0] m_field_n;
            logic       g_n, r_n, s_n, round_n;
            logic [3:0] mant_rnd;
            logic [7:0] exp_rnd;

            m_field_n = mant_norm[MANT_WIDTH-2 -: 3];
            g_n       = mant_norm[MANT_WIDTH-5];
            r_n       = mant_norm[MANT_WIDTH-6];
            s_n       = |mant_norm[MANT_WIDTH-7 : 0];
            round_n   = g_n & (r_n | s_n | m_field_n[0]);

            mant_rnd = {1'b1, m_field_n} + {3'b0, round_n};
            exp_rnd  = mant_rnd[3] ? (exp_norm + 8'd1) : exp_norm;

            if (exp_rnd >= 8'd15) begin
                // Overflow → NaN
                m_out = 3'b100;
                e_out = 4'd15;
            end else begin
                m_out = mant_rnd[2:0];
                e_out = exp_rnd[3:0];
            end

        end else begin
            // ── Subnormal path (exp_norm == 0) ──
            // Direct denormalization from full mantissa, then round to 3 bits
            // M_sub = mant_norm / 2^(MANT_WIDTH-3) = mant_norm >> DENORM_SHIFT
            logic [3:0] m_sub_int;
            logic       g_sub, r_sub, s_sub, round_sub;
            logic [3:0] m_sub_rnd;

            m_sub_int = {1'b0, mant_norm >> DENORM_SHIFT};
            g_sub     = mant_norm[DENORM_SHIFT-1];
            r_sub     = mant_norm[DENORM_SHIFT-2];
            s_sub     = |mant_norm[DENORM_SHIFT-3 : 0];
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

    assign fp8_out = {sign_in, e_out, m_out};

endmodule


module fp8_acc_register #(
    parameter int MANT_WIDTH = 28
) (
    input  logic                       clk,
    input  logic                       rst_n,
    // From Normalizer
    input  logic                       acc_sign_in,
    input  logic [7:0]                 acc_exp_in,
    input  logic [MANT_WIDTH-1:0]      acc_mant_in,
    // To Aligner
    output logic                       acc_sign_out,
    output logic [7:0]                 acc_exp_out,
    output logic [MANT_WIDTH-1:0]      acc_mant_out
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_sign_out <= 1'b0;
            acc_exp_out  <= 8'd0;
            acc_mant_out <= '0;
        end else begin
            acc_sign_out <= acc_sign_in;
            acc_exp_out  <= acc_exp_in;
            acc_mant_out <= acc_mant_in;
        end
    end

endmodule



