// Project: 8-bit ALU
// Author: Aiden Huang
// Date: 2026-06-02
// Description: Converts one 4-bit nibble to an active-low seven-segment display pattern.
// Sources used: Course project prompt and common seven-segment encoding table.

module display_hex (
    input  logic [3:0] value,
    output logic [6:0] segments
);

    always_comb begin
        unique case (value)
            4'h0: segments = 7'b1000000;
            4'h1: segments = 7'b1111001;
            4'h2: segments = 7'b0100100;
            4'h3: segments = 7'b0110000;
            4'h4: segments = 7'b0011001;
            4'h5: segments = 7'b0010010;
            4'h6: segments = 7'b0000010;
            4'h7: segments = 7'b1111000;
            4'h8: segments = 7'b0000000;
            4'h9: segments = 7'b0010000;
            4'ha: segments = 7'b0001000;
            4'hb: segments = 7'b0000011;
            4'hc: segments = 7'b1000110;
            4'hd: segments = 7'b0100001;
            4'he: segments = 7'b0000110;
            4'hf: segments = 7'b0001110;
            default: segments = 7'b1111111;
        endcase
    end

endmodule
