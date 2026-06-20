//===========================================================================
// PATTERN.sv — AF8 Reference Model Package
//===========================================================================
// Software golden model for AF8 MAC operations.
// Used by TESTBED.sv to verify the hardware AF8_MAC DUT.
//
// AF8 Format (Sign-Magnitude encoding, base-4 exponent):
//   [7] Sign  [6:3] Exponent (base-4)  [2:0] Explicit Mantissa
//   Encoding: magnitude = {exp, man}; if sign=1, raw_data = ~magnitude
//   Normal:    E in [1,14], M in [1,7], value = (-1)^S × M × 4^(E-7)
//   Subnormal: E = 0, M = 0 or M = 1, value = (-1)^S × M × 4^(-7)
//   NaN:       decoded exp = 15 (all magnitude exp bits = 1)
//   Zero:      magnitude = 0
//===========================================================================

package af8_pattern_pkg;

    //===========================================================================
    // AF8 Constants
    //===========================================================================
    localparam int       AF8_BIAS   = 7;
    localparam int       AF8_EXP_W  = 4;
    localparam int       AF8_MANT_W = 3;
    localparam logic [3:0] AF8_EXP_MAX = 4'd14;
    localparam logic [3:0] AF8_EXP_NAN = 4'd15;

    // Canonical NaN encoding (positive NaN in sign-magnitude)
    localparam logic [7:0] AF8_NAN = 8'h7C;  // {1'b0, 4'b1111, 3'b100}

    //===========================================================================
    // af8_is_nan — True if decoded exponent field == 15
    //===========================================================================
    function automatic logic af8_is_nan(input logic [7:0] af8);
        logic [6:0] magnitude;
        logic [3:0] exp_dec;
        magnitude = af8[7] ? ~af8[6:0] : af8[6:0];
        exp_dec   = magnitude[6:3];
        return (exp_dec == AF8_EXP_NAN);
    endfunction

    //===========================================================================
    // af8_is_zero — True if decoded magnitude == 0
    //===========================================================================
    function automatic logic af8_is_zero(input logic [7:0] af8);
        logic [6:0] magnitude;
        magnitude = af8[7] ? ~af8[6:0] : af8[6:0];
        return (magnitude == 7'd0);
    endfunction

    //===========================================================================
    // af8_to_real — AF8 → real (FP64)
    //===========================================================================
    function automatic real af8_to_real(input logic [7:0] af8);
        logic       sign;
        logic [6:0] magnitude;
        logic [3:0] exp_dec;
        logic [2:0] man_dec;
        real        value;

        sign      = af8[7];
        magnitude = sign ? ~af8[6:0] : af8[6:0];
        exp_dec   = magnitude[6:3];
        man_dec   = magnitude[2:0];

        // Value = M × 4^(E-7)
        value = real'(man_dec);
        if (exp_dec >= 4'd7) begin
            for (int i = 0; i < exp_dec - 4'd7; i++)
                value = value * 4.0;
        end else begin
            for (int i = 0; i < 4'd7 - exp_dec; i++)
                value = value / 4.0;
        end

        return sign ? -value : value;
    endfunction

    //===========================================================================
    // real_to_af8 — real → AF8 with RNE rounding
    //===========================================================================
    function automatic logic [7:0] real_to_af8(input real val);
        automatic logic       sign;
        automatic real        abs_val;
        automatic real        scaled;
        automatic int         E_base4;
        automatic int         M_raw;
        automatic real        frac;
        automatic logic [3:0] e_field;
        automatic logic [2:0] m_field;
        automatic logic [6:0] magnitude;

        sign    = (val < 0.0);
        abs_val = sign ? -val : val;

        // Zero check
        if (abs_val == 0.0)
            return sign ? 8'hFF : 8'h00;

        // ── Normalize abs_val into [1, 8) with base-4 steps ──
        E_base4 = 7;
        scaled  = abs_val;

        while (scaled >= 8.0 && E_base4 < 30) begin
            scaled = scaled / 4.0;
            E_base4 = E_base4 + 1;
        end
        while (scaled < 2.0 && E_base4 > -20) begin
            scaled = scaled * 4.0;
            E_base4 = E_base4 - 1;
        end

        // ── RNE rounding of scaled to integer M ──
        M_raw = int'(scaled);
        frac  = scaled - real'(M_raw);

        if (frac < 0.5)
            m_field = M_raw[2:0];
        else if (frac > 0.5) begin
            M_raw = M_raw + 1;
            m_field = M_raw[2:0];
        end else begin
            // Exact tie: round to even
            if (M_raw[0] == 1'b0)
                m_field = M_raw[2:0];
            else begin
                M_raw = M_raw + 1;
                m_field = M_raw[2:0];
            end
        end

        // ── Handle M overflow (M >= 8) → adjust E ──
        if (M_raw >= 8) begin
            M_raw = M_raw >> 2;
            E_base4 = E_base4 + 1;
            m_field = M_raw[2:0];
        end

        // ── Overflow → NaN ──
        if (E_base4 > 14)
            return AF8_NAN;

        // ── Normal range ──
        if (E_base4 >= 1) begin
            e_field = E_base4[3:0];
        end
        // ── Subnormal / Zero ──
        else begin
            e_field = 4'd0;
            // Simple threshold-based subnormal/zero decision
            if (abs_val < (1.0 / 32768.0))
                m_field = 3'd0;
            else if (abs_val < (5.0 / 32768.0))
                m_field = 3'd1;
            else begin
                e_field = 4'd1;
                m_field = 3'd1;
            end
        end

        // ── Sign-magnitude encoding ──
        if (e_field == AF8_EXP_NAN) begin
            return AF8_NAN;
        end else begin
            magnitude = {e_field, m_field};
            return sign ? {1'b1, ~magnitude} : {1'b0, magnitude};
        end
    endfunction

    //===========================================================================
    // check_match — Compare two AF8 values
    //===========================================================================
    function automatic logic check_match(
        input logic [7:0] dut_val,
        input logic [7:0] exp_val
    );
        // NaN matches any NaN
        if (af8_is_nan(dut_val) && af8_is_nan(exp_val))
            return 1'b1;
        // Zero matches Zero (ignore sign)
        if (af8_is_zero(dut_val) && af8_is_zero(exp_val))
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
    // af8_mac_ref — Reference MAC: acc = (acc_clear ? 0 : acc) + A × B
    //===========================================================================
    function automatic logic [7:0] af8_mac_ref(
        input  logic [7:0] a,
        input  logic [7:0] b,
        input  logic        acc_clear
    );
        automatic real  a_val, b_val;
        automatic logic prod_sign;

        prod_sign = a[7] ^ b[7];

        if (acc_clear)
            mac_acc_state = 0.0;

        // NaN input → NaN output (poisons accumulator)
        if (af8_is_nan(a) || af8_is_nan(b)) begin
            mac_acc_state = 0.0;
            return AF8_NAN;
        end

        // Zero operand: product is zero
        if (af8_is_zero(a) || af8_is_zero(b)) begin
            if (acc_clear) begin
                mac_acc_state = 0.0;
                return prod_sign ? 8'hFF : 8'h00;
            end
            return real_to_af8(mac_acc_state);
        end

        a_val = af8_to_real(a);
        b_val = af8_to_real(b);

        mac_acc_state = mac_acc_state + (a_val * b_val);

        if (mac_acc_state == 0.0) begin
            if (acc_clear)
                return prod_sign ? 8'hFF : 8'h00;
            else
                return 8'h00;
        end

        return real_to_af8(mac_acc_state);
    endfunction

endpackage
