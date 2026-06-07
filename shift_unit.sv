// Project: 8-bit ALU
// Author: Li- Lung, Chang Chien
// Date: 2026-06-06
// Description: Barrel Shifter that performs 1-bit left or right shift.
// Sources used: Course project prompt and SystemVerilog language reference.

module shift_unit (
    input  logic [7:0] a,       
    input  logic       dir,     
    output logic [7:0] y       
);

    always_comb begin
        if (dir == 1'b0) begin
            y = a << 1;         
        end else begin
            y = a >> 1;         
        end
    end

endmodule
