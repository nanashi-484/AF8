module af8_decoder (
    input  logic [7:0] in_data,

    output logic       sign,
    output logic [3:0] exp,
    output logic [2:0] man
);

    logic [6:0] magnitude;

    always_comb begin
        sign = in_data[7];
        magnitude = sign ? ~in_data[6:0] : in_data[6:0];
        exp = magnitude[6:3];
        man = magnitude[2:0];
    end
endmodule

module af8_multiplier (
    input  logic       sign_a,
    input  logic [3:0] exp_a,
    input  logic [2:0] man_a,

    input  logic       sign_w,
    input  logic [3:0] exp_w,
    input  logic [2:0] man_w,

    output logic               sign_prod,
    output logic signed  [5:0] exp_prod_base4,
    output logic         [5:0] man_prod
);

    always_comb begin
        sign_prod = sign_a ^ sign_w;
        man_prod = man_a * man_w;
        exp_prod_base4 = signed'({2'b00, exp_a}) + signed'({2'b00, exp_w}) - 6'sd14;
    end

endmodule

module af8_to_fp32_aligner (
    input  logic signed [5:0]  exp_prod_base4,
    input  logic        [5:0]  man_prod,

    input  logic signed [9:0]  exp_acc,
    input  logic        [23:0] man_acc,

    output logic signed [9:0]  exp_common,
    output logic        [26:0] aligned_man_prod,
    output logic        [26:0] aligned_man_acc
);

    logic signed [9:0] exp_prod_base2;
    logic signed [9:0] exp_diff;
	    logic signed [9:0] neg_diff;
    logic        [4:0] shift_amount;
    logic              prod_is_smaller;

    logic        [26:0] padded_man_prod;
    logic        [26:0] padded_man_acc;

    always_comb begin
        //(Base-4 to Base-2)
        exp_prod_base2 = 10'(exp_prod_base4) <<< 1;

        exp_diff = exp_acc - exp_prod_base2;
        prod_is_smaller = (exp_diff > 0);
        exp_common = prod_is_smaller ? exp_acc : exp_prod_base2;

        neg_diff = -exp_diff;
        shift_amount = prod_is_smaller ? exp_diff[4:0] : neg_diff[4:0];

        padded_man_prod = {man_prod, 21'b0};
        padded_man_acc  = {3'b0, man_acc};

        //Barrel Shifter
        if (prod_is_smaller) begin
            aligned_man_prod = padded_man_prod >> shift_amount;
            aligned_man_acc  = padded_man_acc;
        end else begin
            aligned_man_prod = padded_man_prod;
            aligned_man_acc  = padded_man_acc >> shift_amount;
        end
    end
endmodule

module af8_adder (
    input  logic               sign_a,
    input  logic               sign_b,
    input  logic [26:0]        mant_a,
    input  logic [26:0]        mant_b,
    input  logic signed [9:0]  exp_common,
    output logic               sign_out,
    output logic [27:0]        mant_out,
    output logic signed [9:0]  exp_out
);

    logic                 signs_differ;
    logic                 a_ge_b;
    logic [26:0]          smaller_mant;
    logic [26:0]          larger_mant;

    assign signs_differ = sign_a ^ sign_b;
    assign a_ge_b = mant_a >= mant_b;
    assign larger_mant  = a_ge_b ? mant_a : mant_b;
    assign smaller_mant = a_ge_b ? mant_b : mant_a;

    always_comb begin
        if (signs_differ) begin
            mant_out  = {1'b0, larger_mant} - {1'b0, smaller_mant};
            sign_out  = a_ge_b ? sign_a : sign_b;
        end else begin
            mant_out  = {1'b0, mant_a} + {1'b0, mant_b};
            sign_out  = sign_a;
        end
    end

    assign exp_out = exp_common;

endmodule

module af8_normalizer (
    input  logic               sign_in,
    input  logic [27:0]        mant_in,
    input  logic signed [9:0]  exp_in,
    // AF8 output (sign-magnitude encoding)
    output logic [7:0]         af8_out,
    // Accumulator feedback (24-bit mantissa, 10-bit signed exp)
    output logic               acc_sign,
    output logic signed [9:0]  acc_exp,
    output logic [23:0]        acc_mant
);

    // ── Stage 1: Carry adjustment ──
    logic [26:0]          mant_carry;
    logic signed [9:0]    exp_carry;

    always_comb begin
        if (mant_in[27]) begin
            mant_carry = mant_in[27:1];
            exp_carry  = exp_in + 10'sd1;
        end else begin
            mant_carry = mant_in[26:0];
            exp_carry  = exp_in;
        end
    end

    // ── Zero detection ──
    logic is_zero;
    assign is_zero = (mant_carry == '0);

    // ── Stage 2: MSB detection + normalization to 24-bit acc ──
    logic [4:0]  msb_pos;
    logic        found;

    always_comb begin
        msb_pos = 5'd0;
        found   = 1'b0;
        for (int i = 26; i >= 0; i--) begin
            if (mant_carry[i] && !found) begin
                msb_pos = 5'(i);
                found   = 1'b1;
            end
        end
    end

    logic signed [9:0]   shift;     // msb_pos - 23, range [-23, 3]
    logic [49:0]         mant_wide;
    logic [49:0]         mant_shifted;

    assign shift = $signed({5'b0, msb_pos}) - 10'sd23;

    always_comb begin
        if (is_zero) begin
            acc_mant = '0;
            acc_exp  = 10'sd0;
        end else if (shift >= 0) begin
            // MSB at or above bit 23: right-shift to put MSB at bit 23
            acc_mant = mant_carry >> shift;
            acc_exp  = exp_carry + shift;
        end else begin
            // MSB below bit 23: left-shift to put MSB at bit 23
            mant_wide    = {mant_carry, 23'b0};
            mant_shifted = mant_wide << (5'd26 - msb_pos);
            acc_mant     = mant_shifted[49:26];
            acc_exp      = exp_carry + shift;
        end
    end

    assign acc_sign = sign_in;

    // ── Stage 3: AF8 output rounding ──
    // AF8: 1 sign + 4 exp (base-4, bias=7) + 3 explicit mantissa
    // Value = M × 4^(E-7), M ∈ [0,7], E ∈ [0,14]
    // Internal value = acc_mant × 2^(acc_exp - 21)

    logic [3:0]  E_out;
    logic [2:0]  M_out;
    // Local variables for Stage 3
    logic signed [9:0] E_cand;
    logic        [5:0] right_shift;
    logic [3:0]        M_raw;
    logic              G, R, S, round_up;
    logic signed [9:0] rshift_s;
    logic [23:0]       threshold;

    always_comb begin
        if (is_zero || acc_mant == '0) begin
            // Zero
            M_out = 3'd0;
            E_out = 4'd0;
        end else begin
            // ── Normal path: find base-4 exponent ──

            E_cand = (acc_exp + 10'sd14) >>> 1;

            if (E_cand <= 10'sd0) begin
                // ── Subnormal path (E=0, M=0 or M=1) ──
                // Threshold: V >= 2^(-15) for M=1 (halfway to 4^(-7)=2^(-14))
                // V = acc_mant * 2^(acc_exp - 21) >= 2^(-15)
                // => acc_mant >= 2^(6 - acc_exp)
                // If 6-acc_exp >= 24: threshold > max acc_mant, so M=0
                if (acc_exp >= 10'sd6) begin
                    M_out = 3'd1;
                end else if ((10'sd6 - acc_exp) >= 10'sd24) begin
                    M_out = 3'd0;
                end else begin
                    threshold = 24'd1 << (6 - acc_exp);
                    M_out = (acc_mant >= threshold) ? 3'd1 : 3'd0;
                end
                E_out = 4'd0;

            end else begin
                // ── Normal path ──
                // right_shift = 2*E_cand + 7 - acc_exp, always 20-23 initially
                rshift_s = ($signed(E_cand) <<< 1) + 10'sd7 - acc_exp;

                if (rshift_s >= 10'sd24) begin
                    M_out = 3'd0;
                    E_out = 4'd0;
                end else begin
                    right_shift = rshift_s[5:0];

                    M_raw = acc_mant >> right_shift;
                    G     = (right_shift >= 1) ? acc_mant[right_shift-1] : 1'b0;
                    R     = (right_shift >= 2) ? acc_mant[right_shift-2] : 1'b0;
                    S     = (right_shift >= 3) ? (|(acc_mant & ((24'd1 << (right_shift - 2)) - 24'd1))) : 1'b0;

                    // If M_raw > 7, E is too small: increase E by 1
                    if (M_raw > 4'd7) begin
                        E_cand = E_cand + 10'sd1;
                        right_shift = right_shift + 6'd2;
                        M_raw = acc_mant >> right_shift;
                        G     = (right_shift >= 1) ? acc_mant[right_shift-1] : 1'b0;
                        R     = (right_shift >= 2) ? acc_mant[right_shift-2] : 1'b0;
                        S     = (right_shift >= 3) ? (|(acc_mant & ((24'd1 << (right_shift - 2)) - 24'd1))) : 1'b0;
                    end

                    // RNE rounding
                    round_up = G & (R | S | M_raw[0]);

                    if (round_up) begin
                        if (M_raw == 4'd7) begin
                            // Rounding overflow: M goes from 7 to 8, adjust E
                            M_out = 3'd0;
                            E_cand = E_cand + 10'sd1;
                        end else begin
                            M_out = M_raw[2:0] + 3'd1;
                        end
                    end else begin
                        M_out = M_raw[2:0];
                    end

                    // Overflow / NaN check
                    if (E_cand >= 10'sd15) begin
                        M_out = 3'b100;
                        E_out = 4'd15;
                    end else if (E_cand <= 10'sd0) begin
                        // After adjustment, E <= 0: subnormal
                        M_out = (M_out != 3'd0) ? 3'd1 : 3'd0;
                        E_out = 4'd0;
                    end else begin
                        E_out = E_cand[3:0];
                    end
                end
            end
        end
    end

    // ── AF8 sign-magnitude encoding ──
    // NaN: always positive NaN = 8'h7C
    // Others: {sign, sign ? ~{E,M} : {E,M}}
    always_comb begin
        if (E_out == 4'd15) begin
            af8_out = 8'h7C;
        end else begin
            af8_out = sign_in ? {1'b1, ~{E_out, M_out}} : {1'b0, E_out, M_out};
        end
    end

endmodule

module af8_acc_register (
    input  logic               clk,
    input  logic               rst_n,
    input  logic               acc_sign_in,
    input  logic signed [9:0]  acc_exp_in,
    input  logic [23:0]        acc_mant_in,
    output logic               acc_sign_out,
    output logic signed [9:0]  acc_exp_out,
    output logic [23:0]        acc_mant_out
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_sign_out <= 1'b0;
            acc_exp_out  <= 10'sd0;
            acc_mant_out <= '0;
        end else begin
            acc_sign_out <= acc_sign_in;
            acc_exp_out  <= acc_exp_in;
            acc_mant_out <= acc_mant_in;
        end
    end

endmodule

module AF8_MAC (
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
    logic [2:0] man_a, man_b;

    // ── NaN / Zero detection (from decoded fields) ──
    logic is_nan_a, is_nan_b;
    assign is_nan_a = (exp_a == 4'b1111);
    assign is_nan_b = (exp_b == 4'b1111);

    // ── Multiplier outputs ──
    logic               sign_prod;
    logic signed [5:0]  exp_prod_base4;
    logic [5:0]         man_prod;

    // ── Accumulator register feedback ──
    logic                       acc_sign;
    logic signed [9:0]          acc_exp;
    logic [23:0]                acc_mant;

    // ── After acc_clear mux (to Aligner) ──
    logic                       acc_sign_mux;
    logic signed [9:0]          acc_exp_mux;
    logic [23:0]                acc_mant_mux;

    // ── Aligner outputs ──
    logic signed [9:0]          exp_common;
    logic [26:0]                aligned_man_prod;
    logic [26:0]                aligned_man_acc;

    // ── Adder outputs ──
    logic                       adder_sign;
    logic [27:0]                adder_mant;
    logic signed [9:0]          adder_exp;

    // ── Normalizer outputs ──
    logic                       norm_sign;
    logic signed [9:0]          norm_exp;
    logic [23:0]                norm_mant;
    logic [7:0]                 af8_result;

    // ── Control ──
    logic is_nan_input;
    assign is_nan_input = is_nan_a | is_nan_b;

    // ── Decoder ×2 ──
    af8_decoder u_decoder_a (
        .in_data (in_a),
        .sign    (sign_a),
        .exp     (exp_a),
        .man     (man_a)
    );

    af8_decoder u_decoder_b (
        .in_data (in_b),
        .sign    (sign_b),
        .exp     (exp_b),
        .man     (man_b)
    );

    // ── Multiplier ──
    af8_multiplier u_multiplier (
        .sign_a         (sign_a),
        .exp_a          (exp_a),
        .man_a          (man_a),
        .sign_w         (sign_b),
        .exp_w          (exp_b),
        .man_w          (man_b),
        .sign_prod      (sign_prod),
        .exp_prod_base4 (exp_prod_base4),
        .man_prod       (man_prod)
    );

    // ── acc_clear mux: clear → accumulator term = 0 ──
    assign acc_sign_mux = acc_clear ? 1'b0 : acc_sign;
    assign acc_exp_mux  = acc_clear ? 10'sd0 : acc_exp;
    assign acc_mant_mux = acc_clear ? '0    : acc_mant;

    // ── Aligner ──
    af8_to_fp32_aligner u_aligner (
        .exp_prod_base4  (exp_prod_base4),
        .man_prod        (man_prod),
        .exp_acc         (acc_exp_mux),
        .man_acc         (acc_mant_mux),
        .exp_common      (exp_common),
        .aligned_man_prod(aligned_man_prod),
        .aligned_man_acc (aligned_man_acc)
    );

    // ── Adder ──
    af8_adder u_adder (
        .sign_a    (sign_prod),
        .sign_b    (acc_sign_mux),
        .mant_a    (aligned_man_prod),
        .mant_b    (aligned_man_acc),
        .exp_common(exp_common),
        .sign_out  (adder_sign),
        .mant_out  (adder_mant),
        .exp_out   (adder_exp)
    );

    // ── Normalizer ──
    af8_normalizer u_normalizer (
        .sign_in  (adder_sign),
        .mant_in  (adder_mant),
        .exp_in   (adder_exp),
        .af8_out  (af8_result),
        .acc_sign (norm_sign),
        .acc_exp  (norm_exp),
        .acc_mant (norm_mant)
    );

    // ── Accumulator Register (NaN → force clear) ──
    af8_acc_register u_acc_register (
        .clk          (clk),
        .rst_n        (rst_n),
        .acc_sign_in  (is_nan_input ? 1'b0 : norm_sign),
        .acc_exp_in   (is_nan_input ? 10'sd0 : norm_exp),
        .acc_mant_in  (is_nan_input ? '0    : norm_mant),
        .acc_sign_out (acc_sign),
        .acc_exp_out  (acc_exp),
        .acc_mant_out (acc_mant)
    );

    // ── Output: NaN propagation ──
    assign out_result = is_nan_input ? 8'h7C : af8_result;

endmodule


module AF8_MAC_DATAPATH (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        acc_clear,

    // 從 Decoder 來的純訊號
    input  logic        sign_a,
    input  logic [3:0]  exp_a,
    input  logic [2:0]  man_a,
    input  logic        sign_b,
    input  logic [3:0]  exp_b,
    input  logic [2:0]  man_b,

    // 從 Normalizer 來的正規化反饋 (維持浮點數累加的正確性)
    input  logic        norm_sign,
    input  logic signed [9:0] norm_exp,
    input  logic [23:0] norm_mant,
    input  logic        is_nan_input, // NaN強制歸零用

    // 給 Normalizer 的加法結果
    output logic        adder_sign,
    output logic [27:0] adder_mant,
    output logic signed [9:0] adder_exp
);
    logic               sign_prod;
    logic signed [5:0]  exp_prod_base4;
    logic [5:0]         man_prod;
    logic               acc_sign, acc_sign_mux;
    logic signed [9:0]  acc_exp, acc_exp_mux;
    logic [23:0]        acc_mant, acc_mant_mux;
    logic signed [9:0]  exp_common;
    logic [26:0]        aligned_man_prod, aligned_man_acc;

    af8_multiplier u_multiplier (
        .sign_a(sign_a), .exp_a(exp_a), .man_a(man_a),
        .sign_w(sign_b), .exp_w(exp_b), .man_w(man_b),
        .sign_prod(sign_prod), .exp_prod_base4(exp_prod_base4), .man_prod(man_prod)
    );

    assign acc_sign_mux = acc_clear ? 1'b0 : acc_sign;
    assign acc_exp_mux  = acc_clear ? 10'sd0 : acc_exp;
    assign acc_mant_mux = acc_clear ? '0    : acc_mant;

    af8_to_fp32_aligner u_aligner (
        .exp_prod_base4(exp_prod_base4), .man_prod(man_prod),
        .exp_acc(acc_exp_mux), .man_acc(acc_mant_mux),
        .exp_common(exp_common), .aligned_man_prod(aligned_man_prod), .aligned_man_acc(aligned_man_acc)
    );

    af8_adder u_adder (
        .sign_a(sign_prod), .sign_b(acc_sign_mux), .mant_a(aligned_man_prod), .mant_b(aligned_man_acc),
        .exp_common(exp_common), .sign_out(adder_sign), .mant_out(adder_mant), .exp_out(adder_exp)
    );

    af8_acc_register u_acc_register (
        .clk(clk), .rst_n(rst_n),
        .acc_sign_in(is_nan_input ? 1'b0 : norm_sign),
        .acc_exp_in(is_nan_input ? 10'sd0 : norm_exp),
        .acc_mant_in(is_nan_input ? '0 : norm_mant),
        .acc_sign_out(acc_sign), .acc_exp_out(acc_exp), .acc_mant_out(acc_mant)
    );
endmodule