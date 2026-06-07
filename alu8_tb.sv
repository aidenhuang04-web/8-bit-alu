// Project: 8-bit ALU
// Author: Aiden Huang
// Date: 2026-06-02
// Description: Self-checking testbench for the modular 8-bit ALU.
// Sources used: Course project prompt and SystemVerilog language reference.

`timescale 1ns/1ps

module alu8_tb;

    logic [7:0] a;
    logic [7:0] b;
    logic [2:0] opcode;
    logic       enable;
    logic       reset_n;
    logic [7:0] result;
    logic       carry;
    logic       overflow;
    logic [13:0] display;

    int tests_run;
    int tests_failed;

    alu8 dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .enable(enable),
        .reset_n(reset_n),
        .result(result),
        .carry(carry),
        .overflow(overflow),
        .display(display)
    );

    task automatic check_case (
        input string      name,
        input logic [7:0] test_a,
        input logic [7:0] test_b,
        input logic [2:0] test_opcode,
        input logic       test_enable,
        input logic       test_reset_n,
        input logic [7:0] expected_result,
        input logic       expected_carry,
        input logic       expected_overflow
    );
        begin
            a = test_a;
            b = test_b;
            opcode = test_opcode;
            enable = test_enable;
            reset_n = test_reset_n;
            #10;

            tests_run++;
            if ((result !== expected_result) ||
                (carry !== expected_carry) ||
                (overflow !== expected_overflow)) begin
                tests_failed++;
                $display("FAIL %-18s A=%h B=%h opcode=%b enable=%b reset_n=%b result=%h carry=%b overflow=%b expected=%h/%b/%b",
                         name, a, b, opcode, enable, reset_n, result, carry, overflow,
                         expected_result, expected_carry, expected_overflow);
            end else begin
                $display("PASS %-18s result=%h carry=%b overflow=%b display=%b",
                         name, result, carry, overflow, display);
            end
        end
    endtask

    initial begin
        tests_run = 0;
        tests_failed = 0;

        a = 8'h00;
        b = 8'h00;
        opcode = 3'b000;
        enable = 1'b0;
        reset_n = 1'b0;
        #10;

        check_case("reset active",    8'h55, 8'haa, 3'b010, 1'b1, 1'b0, 8'h00, 1'b0, 1'b0);
        check_case("enable low",      8'h55, 8'haa, 3'b010, 1'b0, 1'b1, 8'h00, 1'b0, 1'b0);
        check_case("add basic",       8'h12, 8'h34, 3'b000, 1'b1, 1'b1, 8'h46, 1'b0, 1'b0);
        check_case("add carry",       8'hff, 8'h01, 3'b000, 1'b1, 1'b1, 8'h00, 1'b1, 1'b0);
        check_case("add overflow",    8'h7f, 8'h01, 3'b000, 1'b1, 1'b1, 8'h80, 1'b0, 1'b1);
        check_case("sub basic",       8'h20, 8'h05, 3'b001, 1'b1, 1'b1, 8'h1b, 1'b1, 1'b0);
        check_case("sub borrow",      8'h05, 8'h20, 3'b001, 1'b1, 1'b1, 8'he5, 1'b0, 1'b0);
        check_case("sub overflow",    8'h80, 8'h01, 3'b001, 1'b1, 1'b1, 8'h7f, 1'b1, 1'b1);
        check_case("and operation",   8'hf0, 8'h3c, 3'b010, 1'b1, 1'b1, 8'h30, 1'b0, 1'b0);
        check_case("or operation",    8'hf0, 8'h3c, 3'b011, 1'b1, 1'b1, 8'hfc, 1'b0, 1'b0);
        check_case("xor operation",   8'hf0, 8'h3c, 3'b100, 1'b1, 1'b1, 8'hcc, 1'b0, 1'b0);
        check_case("pass operand a",  8'h5a, 8'hc3, 3'b101, 1'b1, 1'b1, 8'h5a, 1'b0, 1'b0);
        check_case("not operand a",   8'h0f, 8'h00, 3'b110, 1'b1, 1'b1, 8'hf0, 1'b0, 1'b0);
        check_case("shift left",      8'h01, 8'h00, 3'b111, 1'b1, 1'b1, 8'h02, 1'b0, 1'b0);

        if (tests_failed == 0) begin
            $display("All %0d ALU tests passed.", tests_run);
        end else begin
            $display("%0d of %0d ALU tests failed.", tests_failed, tests_run);
        end

        #10;
        $finish;
    end

endmodule
