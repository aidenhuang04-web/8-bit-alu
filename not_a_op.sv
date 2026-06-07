// Project: 8-bit ALU
// Author: Aiden Huang
// Date: 2026-06-02
// Description: Extra-credit function that inverts operand A.
// Sources used: Course project prompt and SystemVerilog language reference.

module not_a_op (
    input  logic [7:0] a,
    output logic [7:0] y
);

    assign y = ~a;

endmodule
