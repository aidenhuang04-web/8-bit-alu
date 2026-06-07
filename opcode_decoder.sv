// Project: 8-bit ALU
// Author: Aiden Huang
// Date: 2026-06-02
// Description: Decodes the 4-bit opcode into one-hot operation selects.
// Sources used: Course project prompt and SystemVerilog language reference.

module opcode_decoder (
    input  logic [3:0] opcode,
    output logic       sel_add,
    output logic       sel_sub,
    output logic       sel_and,
    output logic       sel_or,
    output logic       sel_xor,
    output logic       sel_pass_a,
    output logic       sel_pass_b,
    output logic       sel_not_a,
    output logic       sel_shift
);

    always_comb begin
        sel_add    = 1'b0;
        sel_sub    = 1'b0;
        sel_and    = 1'b0;
        sel_or     = 1'b0;
        sel_xor    = 1'b0;
        sel_pass_a = 1'b0;
        sel_pass_b = 1'b0;
        sel_not_a  = 1'b0;
	sel_shift  = 1'b0;
        unique case (opcode)
            4'b0000: sel_add    = 1'b1;
            4'b0001: sel_sub    = 1'b1;
            4'b0010: sel_and    = 1'b1;
            4'b0011: sel_pass_a = 1'b1;
            4'b0100: sel_pass_b = 1'b1;
            4'b0101: sel_xor    = 1'b1;
            4'b0110: sel_or     = 1'b1;
            4'b0111: sel_not_a  = 1'b1;
            4'b1000: sel_shift  = 1'b1;
            default: sel_add   = 1'b1;
        endcase
    end

endmodule
