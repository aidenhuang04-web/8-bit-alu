// Project: 8-bit ALU
// Author: Aiden Huang
// Date: 2026-06-02
// Description: Selects the final ALU result, applies enable/reset behavior, and drives display outputs.
// Sources used: Course project prompt and SystemVerilog language reference.

module output_handler (
    input  logic       enable,
    input  logic       reset_n,
    input  logic       sel_add,
    input  logic       sel_sub,
    input  logic       sel_and,
    input  logic       sel_or,
    input  logic       sel_xor,
    input  logic       sel_pass_a,
    input  logic       sel_pass_b,
    input  logic       sel_not_a,
    input  logic       sel_shift,
    input  logic [7:0] add_result,
    input  logic [7:0] sub_result,
    input  logic [7:0] and_result,
    input  logic [7:0] or_result,
    input  logic [7:0] xor_result,
    input  logic [7:0] pass_a_result,
    input  logic [7:0] pass_b_result,
    input  logic [7:0] not_a_result,
    input  logic [7:0] shift_result,
    input  logic       add_carry,
    input  logic       sub_carry,
    input  logic       add_overflow,
    input  logic       sub_overflow,
    output logic [7:0] result,
    output logic       carry,
    output logic       overflow,
    output logic [13:0] display
);

    logic [6:0] display_high;
    logic [6:0] display_low;

    always_comb begin
        result = 8'b0;
        carry = 1'b0;
        overflow = 1'b0;

        if (reset_n && enable) begin
            if (sel_add) begin
                result = add_result;
                carry = add_carry;
                overflow = add_overflow;
            end else if (sel_sub) begin
                result = sub_result;
                carry = sub_carry;
                overflow = sub_overflow;
            end else if (sel_and) begin
                result = and_result;
            end else if (sel_or) begin
                result = or_result;
            end else if (sel_xor) begin
                result = xor_result;
            end else if (sel_pass_a) begin
                result = pass_a_result;
            end else if (sel_pass_b) begin
                result = pass_b_result;
            end else if (sel_not_a) begin
                result = not_a_result;
	    end else if (sel_shift) begin
		result = shift_result;
            end
        end
    end

    display_hex high_digit (
        .value(result[7:4]),
        .segments(display_high)
    );

    display_hex low_digit (
        .value(result[3:0]),
        .segments(display_low)
    );

    assign display = {display_high, display_low};

endmodule
