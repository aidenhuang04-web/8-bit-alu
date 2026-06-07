// Project: 8-bit ALU
// Author: Aiden Huang
// Date: 2026-06-02
// Description: Performs bit-wise XOR on two 8-bit operands.
// Sources used: Course project prompt and SystemVerilog language reference.

module xor_op (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] y
);

    assign y = a ^ b;

endmodule
