//===========================================================================
// TESTBED.sv — AF8 MAC Unit Testbench
//===========================================================================
// Instantiates the AF8_MAC DUT and verifies against the software reference
// model in af8_pattern_pkg.
//
// DUT Interface (AF8_MAC):
//   clk, rst_n    — clock & async active-low reset
//   in_a, in_b    — AF8 operands (8-bit, sign-magnitude encoding)
//   acc_clear     — clear accumulator (start new dot product)
//   out_result    — AF8 accumulated result (registered: 1 cycle latency)
//
// AF8 Test Values (key encodings):
//   Zero:      0x00 (+0), 0xFF (-0)
//   1.0:       0x71 (M=1,E=7), 0x8E (-1.0)
//   2.0:       0x72 (M=2,E=7), 0x8D (-2.0)
//   4.0:       0x74 (M=4,E=7), 0x8B (-4.0)
//   0.5:       0x62 (M=2,E=6)
//   min_sub:   0x01 (M=1,E=0)
//   max:       0x77 (M=7,E=14)
//   NaN:       0x7C (canonical positive NaN)
//===========================================================================

`timescale 1ns / 1ps

module TESTBED;

    import af8_pattern_pkg::*;

    //===========================================================================
    // Parameters
    //===========================================================================
    localparam int CLK_PERIOD   = 10;     // 100 MHz
    localparam int LATENCY      = 1;      // registered accumulator output
    localparam int RST_CYCLES   = 10;
    localparam int RANDOM_COUNT = 5000;

    //===========================================================================
    // DUT Signals
    //===========================================================================
    logic        clk;
    logic        rst_n;
    logic [7:0]  in_a;
    logic [7:0]  in_b;
    logic        acc_clear;
    logic [7:0]  out_result;

    //===========================================================================
    // DUT Instantiation
    //===========================================================================
    AF8_MAC dut (
        .clk        (clk),
        .rst_n      (rst_n),
        .in_a       (in_a),
        .in_b       (in_b),
        .acc_clear  (acc_clear),
        .out_result (out_result)
    );

    //===========================================================================
    // Clock Generation
    //===========================================================================
    initial clk = 1'b0;
    always #(CLK_PERIOD / 2) clk = ~clk;

    //===========================================================================
    // Scoreboard
    //===========================================================================
    int pass_cnt;
    int fail_cnt;
    int test_cnt;

    //===========================================================================
    // Task: drive DUT inputs and wait one clock cycle
    //===========================================================================
    task automatic drive_cycle(
        input logic [7:0] a,
        input logic [7:0] b,
        input logic       clr
    );
        @(posedge clk);
        in_a      <= a;
        in_b      <= b;
        acc_clear <= clr;
        #1;  // let combinational logic settle
    endtask

    //===========================================================================
    // Task: check DUT output and update scoreboard
    //===========================================================================
    task automatic check(
        input logic [7:0] expected,
        input integer     id,
        input string      desc
    );
        logic       dut_sign, exp_sign;
        logic [3:0] dut_exp, exp_exp;
        logic [2:0] dut_man, exp_man;

        test_cnt = test_cnt + 1;
        if (check_match(out_result, expected)) begin
            pass_cnt = pass_cnt + 1;
            if ((test_cnt % 500) == 0)
                $display("[PASS] #%0d: %s", test_cnt, desc);
        end else begin
            fail_cnt = fail_cnt + 1;
            begin
                logic [6:0] mag;
                mag = out_result[7] ? ~out_result[6:0] : out_result[6:0];
                dut_sign = out_result[7]; dut_exp = mag[6:3]; dut_man = mag[2:0];
                mag = expected[7] ? ~expected[6:0] : expected[6:0];
                exp_sign = expected[7]; exp_exp = mag[6:3]; exp_man = mag[2:0];
            end
            $display("[FAIL] #%0d: %s", test_cnt, desc);
            $display("       DUT:      0x%02h (decoded: S=%b E=%d M=%d)",
                     out_result, dut_sign, dut_exp, dut_man);
            $display("       Expected: 0x%02h (decoded: S=%b E=%d M=%d)",
                     expected, exp_sign, exp_exp, exp_man);
        end
    endtask

    //===========================================================================
    // Main Test Sequence
    //===========================================================================
    initial begin
        logic [7:0] exp_val;

        // ---- Init ----
        pass_cnt  = 0;
        fail_cnt  = 0;
        test_cnt  = 0;
        in_a      = 8'h00;
        in_b      = 8'h00;
        acc_clear = 1'b0;

        // ---- Reset ----
        rst_n = 1'b0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1'b1;
        @(posedge clk);

        $display("============================================================");
        $display(" AF8 MAC Unit Testbench");
        $display(" Latency: %0d cycle(s)", LATENCY);
        $display("============================================================");

        //===================================================================
        // Phase 1: Directed Corner Cases (single MAC, acc_clear=1)
        //===================================================================
        $display("");
        $display("--- Phase 1: Directed Corner Cases ---");

        // -- Zero tests --
        // AF8: +0 = 0x00, -0 = 0xFF
        exp_val = af8_mac_ref(8'h00, 8'h00, 1'b1);
        drive_cycle(8'h00, 8'h00, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 1, "Zero: +0 * +0 = +0");

        exp_val = af8_mac_ref(8'hFF, 8'h00, 1'b1);
        drive_cycle(8'hFF, 8'h00, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 2, "Zero: -0 * +0 = -0");

        // 1.0 = 0x71, +0 = 0x00
        exp_val = af8_mac_ref(8'h39, 8'h00, 1'b1);
        drive_cycle(8'h39, 8'h00, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 3, "Zero: +1.0 * +0 = +0");

        exp_val = af8_mac_ref(8'h00, 8'h39, 1'b1);
        drive_cycle(8'h00, 8'h39, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 4, "Zero: +0 * +1.0 = +0");

        // -- Normal × Normal (basic) --
        // 1.0 * 1.0 = 1.0  (0x71 * 0x71)
        exp_val = af8_mac_ref(8'h39, 8'h39, 1'b1);
        drive_cycle(8'h39, 8'h39, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 5, "Normal: +1.0 * +1.0 = +1.0");

        // -1.0 * +1.0 = -1.0  (0x8E * 0x71)
        exp_val = af8_mac_ref(8'hc6, 8'h39, 1'b1);
        drive_cycle(8'hc6, 8'h39, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 6, "Normal: -1.0 * +1.0 = -1.0");

        // -1.0 * -1.0 = +1.0  (0x8E * 0x8E)
        exp_val = af8_mac_ref(8'hc6, 8'hc6, 1'b1);
        drive_cycle(8'hc6, 8'hc6, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 7, "Normal: -1.0 * -1.0 = +1.0");

        // 2.0 * 3.0 = 6.0  (0x72 * 0x73)
        exp_val = af8_mac_ref(8'h3a, 8'h3b, 1'b1);
        drive_cycle(8'h3a, 8'h3b, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 8, "Normal: +2.0 * +3.0 = +6.0");

        // -2.0 * -2.0 = +4.0  (0x8D * 0x8D)
        exp_val = af8_mac_ref(8'hc5, 8'hc5, 1'b1);
        drive_cycle(8'hc5, 8'hc5, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 9, "Normal: -2.0 * -2.0 = +4.0");

        // -- Near limits --
        // max * 1.0 = max  (0x77 * 0x71)
        exp_val = af8_mac_ref(8'h77, 8'h39, 1'b1);
        drive_cycle(8'h77, 8'h39, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 10, "Normal: max * +1.0 = max");

        // -- Overflow --
        // max * 2.0 → NaN  (0x77 * 0x72)
        exp_val = af8_mac_ref(8'h77, 8'h3a, 1'b1);
        drive_cycle(8'h77, 8'h3a, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 11, "Overflow: max * 2.0 → NaN");

        // -- Subnormal tests --
        // min_sub * 1.0 = min_sub (0x01 * 0x71)
        exp_val = af8_mac_ref(8'h01, 8'h39, 1'b1);
        drive_cycle(8'h01, 8'h39, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 12, "Subnormal: min_sub * 1.0 = min_sub");

        // min_sub * min_sub = too small → 0
        exp_val = af8_mac_ref(8'h01, 8'h01, 1'b1);
        drive_cycle(8'h01, 8'h01, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 13, "Underflow: min_sub * min_sub → 0");

        // -- NaN propagation --
        // NaN * 1.0 = NaN
        exp_val = af8_mac_ref(8'h7C, 8'h39, 1'b1);
        drive_cycle(8'h7C, 8'h39, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 14, "NaN: NaN * 1.0 = NaN");

        // 1.0 * NaN = NaN
        exp_val = af8_mac_ref(8'h39, 8'h83, 1'b1);
        drive_cycle(8'h39, 8'h83, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 15, "NaN: 1.0 * NaN = NaN");

        //===================================================================
        // Phase 2: Multi-Cycle Accumulation Sequences
        //===================================================================
        $display("");
        $display("--- Phase 2: Accumulation Sequences ---");

        // Sequence A: 1.0 * 1.0 five times → 5.0
        $display("[SEQ] Five 1.0 accumulations");
        for (int i = 0; i < 5; i = i + 1) begin
            exp_val = af8_mac_ref(8'h39, 8'h39, (i == 0));
            drive_cycle(8'h39, 8'h39, (i == 0));
            repeat (LATENCY - 1) @(posedge clk);
            check(exp_val, 20 + i, $sformatf("Accum 1.0 x5 [step %0d]", i));
        end

        // Sequence B: 1.0*2.0 + (-1.0)*2.0 = 0.0 (cancellation)
        $display("[SEQ] Sign cancellation: 2.0 + (-2.0) = 0.0");
        exp_val = af8_mac_ref(8'h39, 8'h3a, 1'b1);
        drive_cycle(8'h39, 8'h3a, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 30, "Cancel: 1.0*2.0 = 2.0");

        exp_val = af8_mac_ref(8'hc6, 8'h3a, 1'b0);
        drive_cycle(8'hc6, 8'h3a, 1'b0);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 31, "Cancel: 2.0 + (-2.0) = 0.0");

        // Sequence C: Subnormal accumulation
        $display("[SEQ] Subnormal accumulation");
        for (int i = 0; i < 3; i = i + 1) begin
            exp_val = af8_mac_ref(8'h01, 8'h39, (i == 0));
            drive_cycle(8'h01, 8'h39, (i == 0));
            repeat (LATENCY - 1) @(posedge clk);
            check(exp_val, 40 + i, $sformatf("Subnorm accum [step %0d]", i));
        end

        // Sequence D: Accumulate to overflow
        $display("[SEQ] Accumulate to overflow");
        exp_val = af8_mac_ref(8'h77, 8'h39, 1'b1);
        drive_cycle(8'h77, 8'h39, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 50, "Overflow accum: max*1.0 = max");

        // Accumulate: max + (max * 0.5) → NaN
        // 0.5 = 0x62 (M=2, E=6)
        exp_val = af8_mac_ref(8'h77, 8'h32, 1'b0);
        drive_cycle(8'h77, 8'h32, 1'b0);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 51, "Overflow accum: max + ~half_max → NaN");

        //===================================================================
        // Phase 3: Accumulator Clear & Reset Sanity
        //===================================================================
        $display("");
        $display("--- Phase 3: Clear & Reset Sanity ---");

        // acc_clear mid-sequence
        $display("[CHK] acc_clear mid-sequence");
        exp_val = af8_mac_ref(8'h39, 8'h3a, 1'b1);  // 1.0*2.0=2.0
        drive_cycle(8'h39, 8'h3a, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 60, "Sanity: acc_clear=1 → 2.0");

        exp_val = af8_mac_ref(8'h39, 8'h3b, 1'b0);  // +3.0 → 5.0
        drive_cycle(8'h39, 8'h3b, 1'b0);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 61, "Sanity: acc_clear=0 → 5.0");

        exp_val = af8_mac_ref(8'h39, 8'h39, 1'b1);  // clear + 1.0 → 1.0
        drive_cycle(8'h39, 8'h39, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 62, "Sanity: acc_clear=1 → 1.0 (clear)");

        // Reset test
        $display("[CHK] rst_n reset");
        exp_val = af8_mac_ref(8'h3a, 8'h3a, 1'b1);  // 2.0*2.0=4.0
        drive_cycle(8'h3a, 8'h3a, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 63, "RST: before reset → 4.0");

        // Assert reset
        rst_n = 1'b0;
        repeat (3) @(posedge clk);
        rst_n = 1'b1;
        @(posedge clk);

        exp_val = af8_mac_ref(8'h39, 8'h39, 1'b1);  // 1.0*1.0=1.0
        drive_cycle(8'h39, 8'h39, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 64, "RST: after reset → 1.0");

        //===================================================================
        // Phase 4: Constrained Random Tests
        //===================================================================
        $display("");
        $display("--- Phase 4: Random Tests (%0d vectors) ---", RANDOM_COUNT);

        begin
            int rng = 32'hDEADBEEF;
            logic [7:0] ra, rb;
            logic       rclr;

            for (int i = 0; i < RANDOM_COUNT; i = i + 1) begin
                // Generate random AF8 values (uniform over all 256 encodings)
                rng = ($random(rng)) & 32'hFFFF;
                ra = rng[7:0];
                rng = ($random(rng)) & 32'hFFFF;
                rb = rng[7:0];

                // ~1/8 tests use acc_clear=0 (accumulate), rest are fresh
                if ((i % 8) == 0 && i > 0) begin
                    rclr = 1'b0;
                end else begin
                    rclr = 1'b1;
                end

                exp_val = af8_mac_ref(ra, rb, rclr);
                drive_cycle(ra, rb, rclr);
                repeat (LATENCY - 1) @(posedge clk);
                check(exp_val, 100 + i, $sformatf("Random #%0d", i));
            end
        end

        //===================================================================
        // Final Report
        //===================================================================
        $display("");
        $display("============================================================");
        $display(" TEST SUMMARY");
        $display("============================================================");
        $display(" Total:   %0d", test_cnt);
        $display(" Passed:  %0d", pass_cnt);
        $display(" Failed:  %0d", fail_cnt);
        $display("============================================================");

        if (fail_cnt == 0) begin
            $display(" RESULT: ALL TESTS PASSED");
            $finish(0);
        end else begin
            $display(" RESULT: %0d TEST(S) FAILED", fail_cnt);
            $finish(1);
        end
    end

    //===========================================================================
    // Simulation Timeout
    //===========================================================================
    initial begin
        #(CLK_PERIOD * (RANDOM_COUNT + 5000));
        $display("[FATAL] Simulation timeout");
        $finish(1);
    end

endmodule
