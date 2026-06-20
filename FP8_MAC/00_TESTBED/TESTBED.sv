//===========================================================================
// TESTBED.sv — FP8 E4M3 MAC Unit Testbench
//===========================================================================
// Instantiates the FP8_MAC DUT and verifies against the software reference
// model in fp8_pattern_pkg.
//
// DUT Interface (FP8_MAC):
//   clk, rst_n    — clock & async active-low reset
//   in_a, in_b    — FP8 E4M3 operands (8-bit)
//   acc_clear     — clear accumulator (start new dot product)
//   out_result    — FP8 E4M3 accumulated result (registered: 1 cycle latency)
//
// Test Coverage:
//   - Zero operands & signed zero
//   - Normal × Normal (basic, near limits, overflow)
//   - Subnormal × Normal, Subnormal × Subnormal, underflow
//   - NaN propagation
//   - Mixed signs
//   - Multi-cycle accumulation sequences
//   - Accumulator clear & reset behavior
//   - ~5000 constrained random vectors
//===========================================================================

`timescale 1ns / 1ps

`ifndef RTL
    `define RTL
`endif

module TESTBED;

    import fp8_pattern_pkg::*;

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
    FP8_MAC dut (
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
    //
    // Timing:
    //   1. @(posedge clk) — end of previous cycle, acc_register latches
    //   2. Drive new inputs (after register has latched)
    //   3. #1 — combinational settling
    //   4. Return — caller checks out_result BEFORE next register latch
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
        test_cnt = test_cnt + 1;
        if (check_match(out_result, expected)) begin
            pass_cnt = pass_cnt + 1;
            if ((test_cnt % 500) == 0)
                $display("[PASS] #%0d: %s", test_cnt, desc);
        end else begin
            fail_cnt = fail_cnt + 1;
            $display("[FAIL] #%0d: %s", test_cnt, desc);
            $display("       DUT:      0x%02h (S=%b E=%d M=%d)",
                     out_result, out_result[7], out_result[6:3], out_result[2:0]);
            $display("       Expected: 0x%02h (S=%b E=%d M=%d)",
                     expected, expected[7], expected[6:3], expected[2:0]);
        end
    endtask

    //===========================================================================
    // Main Test Sequence
    //===========================================================================
    initial begin
        // Track reference accumulator state
        // Temp variable for expected FP8 value
        static logic [7:0] exp_val;

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
        $display(" FP8 E4M3 MAC Unit Testbench");
        $display(" Latency: %0d cycle(s)", LATENCY);
        $display("============================================================");

        //===================================================================
        // Phase 1: Directed Corner Cases (single MAC, acc_clear=1)
        //===================================================================
        $display("");
        $display("--- Phase 1: Directed Corner Cases ---");

        // -- Zero tests --
        exp_val = fp8_mac_ref(8'h00, 8'h00, 1'b1);
        drive_cycle(8'h00, 8'h00, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 1, "Zero: +0 * +0 = +0");

        exp_val = fp8_mac_ref(8'h80, 8'h00, 1'b1);
        drive_cycle(8'h80, 8'h00, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 2, "Zero: -0 * +0 = -0");

        exp_val = fp8_mac_ref(8'h38, 8'h00, 1'b1);
        drive_cycle(8'h38, 8'h00, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 3, "Zero: +1.0 * +0 = +0");

        exp_val = fp8_mac_ref(8'h00, 8'h38, 1'b1);
        drive_cycle(8'h00, 8'h38, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 4, "Zero: +0 * +1.0 = +0");

        // -- Normal * Normal (basic) --
        // 1.0 * 1.0 = 1.0  (0x38 * 0x38 = 0x38)
        exp_val = fp8_mac_ref(8'h38, 8'h38, 1'b1);
        drive_cycle(8'h38, 8'h38, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 5, "Normal: +1.0 * +1.0 = +1.0");

        // -1.0 * +1.0 = -1.0  (0xB8 * 0x38 = 0xB8)
        exp_val = fp8_mac_ref(8'hB8, 8'h38, 1'b1);
        drive_cycle(8'hB8, 8'h38, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 6, "Normal: -1.0 * +1.0 = -1.0");

        // -1.0 * -1.0 = +1.0  (0xB8 * 0xB8 = 0x38)
        exp_val = fp8_mac_ref(8'hB8, 8'hB8, 1'b1);
        drive_cycle(8'hB8, 8'hB8, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 7, "Normal: -1.0 * -1.0 = +1.0");

        // 2.0 * 3.0 = 6.0  (0x40 * 0x44 = 0x4C)
        exp_val = fp8_mac_ref(8'h40, 8'h44, 1'b1);
        drive_cycle(8'h40, 8'h44, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 8, "Normal: +2.0 * +3.0 = +6.0");

        // -2.0 * -2.0 = +4.0  (0xC0 * 0xC0 = 0x48)
        exp_val = fp8_mac_ref(8'hC0, 8'hC0, 1'b1);
        drive_cycle(8'hC0, 8'hC0, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 9, "Normal: -2.0 * -2.0 = +4.0");

        // -- Near limits --
        // max * 1.0 = max  (0x7F * 0x38 = 0x7F)
        exp_val = fp8_mac_ref(8'h7F, 8'h38, 1'b1);
        drive_cycle(8'h7F, 8'h38, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 10, "Normal: max * +1.0 = max");

        // max * 0.5 = 120  (0x7F * 0x30 = 0x77)
        exp_val = fp8_mac_ref(8'h7F, 8'h30, 1'b1);
        drive_cycle(8'h7F, 8'h30, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 11, "Normal: max * 0.5 = 120");

        // -- Overflow --
        // max * 2.0 = 480 → NaN  (0x7F * 0x40 → NaN)
        exp_val = fp8_mac_ref(8'h7F, 8'h40, 1'b1);
        drive_cycle(8'h7F, 8'h40, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 12, "Overflow: max * 2.0 → NaN");

        // 128 * 128 = 16384 → NaN  (0x78 * 0x78 → NaN)
        exp_val = fp8_mac_ref(8'h78, 8'h78, 1'b1);
        drive_cycle(8'h78, 8'h78, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 13, "Overflow: 128 * 128 → NaN");

        // -- Subnormal tests --
        // min_sub * 1.0 = min_sub  (0x01 * 0x38 = 0x01)
        exp_val = fp8_mac_ref(8'h01, 8'h38, 1'b1);
        drive_cycle(8'h01, 8'h38, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 14, "Subnormal: min_sub * 1.0 = min_sub");

        // max_sub * 1.0 = max_sub  (0x07 * 0x38 = 0x07)
        exp_val = fp8_mac_ref(8'h07, 8'h38, 1'b1);
        drive_cycle(8'h07, 8'h38, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 15, "Subnormal: max_sub * 1.0 = max_sub");

        // -- Underflow --
        // min_sub * min_sub = 2^(-18) → 0
        exp_val = fp8_mac_ref(8'h01, 8'h01, 1'b1);
        drive_cycle(8'h01, 8'h01, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 16, "Underflow: min_sub * min_sub → 0");

        // min_normal * min_normal = 2^(-12) → 0
        exp_val = fp8_mac_ref(8'h08, 8'h08, 1'b1);
        drive_cycle(8'h08, 8'h08, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 17, "Underflow: min_normal * min_normal → 0");

        // -- NaN propagation --
        exp_val = fp8_mac_ref(8'h7C, 8'h38, 1'b1);
        drive_cycle(8'h7C, 8'h38, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 18, "NaN: NaN * 1.0 = NaN");

        exp_val = fp8_mac_ref(8'h38, 8'hFC, 1'b1);
        drive_cycle(8'h38, 8'hFC, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 19, "NaN: 1.0 * NaN = NaN");

        //===================================================================
        // Phase 2: Multi-Cycle Accumulation Sequences
        //===================================================================
        $display("");
        $display("--- Phase 2: Accumulation Sequences ---");

        // Sequence A: 1.0 * 1.0 five times → 5.0
        // 5.0 = 1.25 × 2^2, E=9, M=2 → 0x4A
        $display("[SEQ] Five 1.0 accumulations");
        for (int i = 0; i < 5; i = i + 1) begin
            exp_val = fp8_mac_ref(8'h38, 8'h38, (i == 0));
            drive_cycle(8'h38, 8'h38, (i == 0));
            repeat (LATENCY - 1) @(posedge clk);
            check(exp_val, 20 + i, $sformatf("Accum 1.0 x5 [step %0d]", i));
        end

        // Sequence B: 1.0*2.0 + (-1.0)*2.0 = 0.0 (cancellation)
        $display("[SEQ] Sign cancellation: 2.0 + (-2.0) = 0.0");
        exp_val = fp8_mac_ref(8'h38, 8'h40, 1'b1);
        drive_cycle(8'h38, 8'h40, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 30, "Cancel: 1.0*2.0 = 2.0");

        exp_val = fp8_mac_ref(8'hB8, 8'h40, 1'b0);
        drive_cycle(8'hB8, 8'h40, 1'b0);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 31, "Cancel: 2.0 + (-2.0) = 0.0");

        // Sequence C: Subnormal accumulation 0x01 * 1.0 three times
        $display("[SEQ] Subnormal accumulation");
        for (int i = 0; i < 3; i = i + 1) begin
            exp_val = fp8_mac_ref(8'h01, 8'h38, (i == 0));
            drive_cycle(8'h01, 8'h38, (i == 0));
            repeat (LATENCY - 1) @(posedge clk);
            check(exp_val, 40 + i, $sformatf("Subnorm accum [step %0d]", i));
        end

        // Sequence D: Accumulate to overflow
        // Cycle 0: max * 1.0 = 240 (0x7F)
        // Cycle 1: max * 0.5 = 120, acc = 240+120 = 360 → NaN
        $display("[SEQ] Accumulate to overflow");
        exp_val = fp8_mac_ref(8'h7F, 8'h38, 1'b1);
        drive_cycle(8'h7F, 8'h38, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 50, "Overflow accum: max*1.0 = max");

        exp_val = fp8_mac_ref(8'h7F, 8'h30, 1'b0);
        drive_cycle(8'h7F, 8'h30, 1'b0);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 51, "Overflow accum: max + 120 → NaN");

        //===================================================================
        // Phase 3: Accumulator Clear & Reset Sanity
        //===================================================================
        $display("");
        $display("--- Phase 3: Clear & Reset Sanity ---");

        // acc_clear mid-sequence
        $display("[CHK] acc_clear mid-sequence");
        exp_val = fp8_mac_ref(8'h38, 8'h40, 1'b1);  // 1.0*2.0=2.0
        drive_cycle(8'h38, 8'h40, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 60, "Sanity: acc_clear=1 → 2.0");

        exp_val = fp8_mac_ref(8'h38, 8'h44, 1'b0);  // +3.0 → 5.0
        drive_cycle(8'h38, 8'h44, 1'b0);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 61, "Sanity: acc_clear=0 → 5.0");

        exp_val = fp8_mac_ref(8'h38, 8'h38, 1'b1);  // clear + 1.0 → 1.0
        drive_cycle(8'h38, 8'h38, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 62, "Sanity: acc_clear=1 → 1.0 (clear)");

        // Reset test
        $display("[CHK] rst_n reset");
        exp_val = fp8_mac_ref(8'h40, 8'h40, 1'b1);  // 2.0*2.0=4.0
        drive_cycle(8'h40, 8'h40, 1'b1);
        repeat (LATENCY - 1) @(posedge clk);
        check(exp_val, 63, "RST: before reset → 4.0");

        // Assert reset
        rst_n = 1'b0;
        repeat (3) @(posedge clk);
        rst_n = 1'b1;
        @(posedge clk);

        exp_val = fp8_mac_ref(8'h38, 8'h38, 1'b1);  // 1.0*1.0=1.0
        drive_cycle(8'h38, 8'h38, 1'b1);
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
                // Generate random FP8 values (uniform over all 256 encodings)
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

                exp_val = fp8_mac_ref(ra, rb, rclr);
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
