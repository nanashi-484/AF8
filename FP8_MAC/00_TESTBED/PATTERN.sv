//===========================================================================
// PATTERN.sv — FP8 E4M3 Reference Model Package
//===========================================================================
// Software golden model for FP8 E4M3 MAC operations.
// Used by TESTBED.sv to verify the hardware FP8_MAC DUT.
//
// FP8 E4M3 Format (IEEE 754 style, bias=7):
//   [7] Sign  [6:3] Exponent  [2:0] Mantissa
//   Normal:    E in [1,14], hidden=1, value = (-1)^S × 1.M × 2^(E-7)
//   Subnormal: E = 0,     hidden=0, value = (-1)^S × 0.M × 2^(-6)
//   NaN:       E = 15 (all encodings)
//   Zero:      E = 0, M = 0
//===========================================================================

package fp8_pattern_pkg;

    //===========================================================================
    // FP8 E4M3 Constants
    //===========================================================================
    localparam int       FP8_BIAS   = 7;
    localparam int       FP8_EXP_W  = 4;
    localparam int       FP8_MANT_W = 3;
    localparam logic [3:0] FP8_EXP_MAX = 4'd14;
    localparam logic [3:0] FP8_EXP_NAN = 4'd15;

    // Canonical NaN encoding
    localparam logic [7:0] FP8_NAN = {1'b0, FP8_EXP_NAN, 3'b100};

    //===========================================================================
    // fp8_is_nan — True if exponent field == 15
    //===========================================================================
    function automatic logic fp8_is_nan(input logic [7:0] fp8);
        return (fp8[6:3] == FP8_EXP_NAN);
    endfunction

    //===========================================================================
    // fp8_is_zero — True if exponent=0 and mantissa=0
    //===========================================================================
    function automatic logic fp8_is_zero(input logic [7:0] fp8);
        return (fp8[6:0] == 7'd0);
    endfunction

    //===========================================================================
    // fp8_to_real — FP8 E4M3 → real (FP64)
    //===========================================================================
    function automatic real fp8_to_real(input logic [7:0] fp8);
        automatic logic        sign;
        automatic logic [3:0]  exp_field;
        automatic logic [2:0]  mant_field;
        automatic real         value;

        sign       = fp8[7];
        exp_field  = fp8[6:3];
        mant_field = fp8[2:0];

        if (exp_field == 4'd0) begin
            // Subnormal / Zero: 0.M × 2^(-6)
            value = real'(mant_field) / 8.0;
            // Multiply by 2^(-6) = 1/64
            value = value / 64.0;
        end else begin
            // Normal: 1.M × 2^(E-7)
            value = 1.0 + real'(mant_field) / 8.0;
            value = value * (2.0 ** (real'(exp_field) - 7.0));
        end

        return sign ? -value : value;
    endfunction

    //===========================================================================
    // real_to_fp8 — real → FP8 E4M3 with RNE rounding
    //===========================================================================
    function automatic logic [7:0] real_to_fp8(input real val);
        automatic logic        sign;
        automatic real         abs_val;
        automatic real         mant_norm;
        automatic int          exp_actual;
        automatic logic [3:0]  e_field;
        automatic logic [2:0]  m_field;
        automatic logic        round_up;
        automatic real         scaled;
        automatic int          int_part;
        automatic real         rem;

        sign    = (val < 0.0);
        abs_val = sign ? -val : val;

        // Zero check
        if (abs_val == 0.0)
            return {sign, 4'd0, 3'd0};

        // ---- Normalize abs_val into [1.0, 2.0) ----
        exp_actual = 0;
        mant_norm  = abs_val;
        while (mant_norm >= 2.0 && exp_actual < 30) begin
            mant_norm = mant_norm / 2.0;
            exp_actual = exp_actual + 1;
        end
        while (mant_norm < 1.0 && exp_actual > -30) begin
            mant_norm = mant_norm * 2.0;
            exp_actual = exp_actual - 1;
        end

        // ---- Overflow → NaN ----
        if (exp_actual > 7)
            return {sign, FP8_EXP_NAN, 3'b100};

        // ---- Underflow → Zero ----
        if (exp_actual < -9)
            return {sign, 4'd0, 3'd0};

        // ---- Normal: E = exp_actual + BIAS, E in [1, 14] ----
        if (exp_actual >= -6) begin
            e_field = exp_actual + FP8_BIAS;

            // Extract {M[2:0], G, R, S_partial} from normalized mantissa
            // mant_norm = 1.xxxxx;  mant_norm-1.0 = 0.xxxxx
            // Scale by 64 → 6-bit integer part
            scaled   = (mant_norm - 1.0) * 64.0;
            int_part = int'(scaled);
            rem      = scaled - real'(int_part);

            m_field   = int_part[5:3];
            // RNE: round_up = G & (R | S | LSB)
            round_up  = int_part[2] & (int_part[1] | (|int_part[0]) | (rem != 0.0) | m_field[0]);

            if (round_up) begin
                if (m_field == 3'd7) begin
                    m_field = 3'd0;
                    e_field = e_field + 4'd1;
                    if (e_field >= FP8_EXP_NAN)
                        return {sign, FP8_EXP_NAN, 3'b100};
                end else begin
                    m_field = m_field + 3'd1;
                end
            end

            return {sign, e_field, m_field};
        end

        // ---- Subnormal: exp_actual in [-9, -7], E = 0 ----
        else begin
            // value = mant_norm × 2^exp_actual
            // Subnormal: value ≈ M/8 × 2^(-6)
            //   M ≈ mant_norm × 2^(exp_actual + 9)
            scaled   = mant_norm * (2.0 ** (exp_actual + 9));
            int_part = int'(scaled);
            rem      = scaled - real'(int_part);

            // RNE rounding
            if (rem < 0.5)
                m_field = int_part[2:0];
            else if (rem > 0.5) begin
                int_part = int_part + 1;
                m_field = int_part[2:0];
            end else begin
                // Exact tie: round to even
                if (int_part[0] == 1'b0)
                    m_field = int_part[2:0];
                else begin
                    int_part = int_part + 1;
                    m_field = int_part[2:0];
                end
            end

            // After RNE rounding: handle boundary cases
            // NOTE: int_part now holds the correctly rounded integer value
            if (int_part >= 8)
                return {sign, 4'd1, 3'd0};  // subnormal rounded up to min normal
            else if (int_part == 0)
                return {sign, 4'd0, 3'd0};  // rounded to zero (underflow)
            else
                return {sign, 4'd0, int_part[2:0]};
        end
    endfunction

    //===========================================================================
    // check_match — Compare two FP8 values
    //   Returns 1 if they match (NaN==NaN, Zero==Zero, bitwise equal).
    //===========================================================================
    function automatic logic check_match(
        input logic [7:0] dut_val,
        input logic [7:0] exp_val
    );
        // NaN matches any NaN
        if (fp8_is_nan(dut_val) && fp8_is_nan(exp_val))
            return 1'b1;
        // Zero matches Zero (ignore sign)
        if (fp8_is_zero(dut_val) && fp8_is_zero(exp_val))
            return 1'b1;
        // Exact bit match
        return (dut_val == exp_val);
    endfunction

    //===========================================================================
    // Internal accumulator state (package-level, shared across calls)
    //===========================================================================
    real mac_acc_state = 0.0;

    //===========================================================================
    // mac_clear_acc — Explicitly reset the internal accumulator
    //===========================================================================
    function automatic void mac_clear_acc();
        mac_acc_state = 0.0;
    endfunction

    //===========================================================================
    // fp8_mac_ref — Reference MAC: acc = (acc_clear ? 0 : acc) + A × B
    //   Uses package-level mac_acc_state to maintain accumulator across calls.
    //   Returns FP8 E4M3 rounded result.
    //===========================================================================
    function automatic logic [7:0] fp8_mac_ref(
        input  logic [7:0] a,
        input  logic [7:0] b,
        input  logic        acc_clear
    );
        automatic real    a_val, b_val;
        automatic logic   prod_sign;

        prod_sign = a[7] ^ b[7];

        // Clear accumulator before computing
        if (acc_clear)
            mac_acc_state = 0.0;

        // NaN input → NaN output (poisons accumulator)
        if (fp8_is_nan(a) || fp8_is_nan(b)) begin
            mac_acc_state = 0.0;
            return FP8_NAN;
        end

        // Zero operand: product is zero, accumulator unchanged (or zeroed)
        if (fp8_is_zero(a) || fp8_is_zero(b)) begin
            if (acc_clear) begin
                // Fresh MAC: result is signed zero from product sign
                mac_acc_state = 0.0;
                return {prod_sign, 4'd0, 3'd0};
            end
            // Continue accumulation: zero product doesn't change accumulator
            return real_to_fp8(mac_acc_state);
        end

        a_val = fp8_to_real(a);
        b_val = fp8_to_real(b);

        // Accumulate product
        mac_acc_state = mac_acc_state + (a_val * b_val);

        // Handle exact zero result preserving sign
        if (mac_acc_state == 0.0) begin
            if (acc_clear)
                return {prod_sign, 4'd0, 3'd0};
            else
                return 8'h00;
        end

        return real_to_fp8(mac_acc_state);
    endfunction

endpackage
