// Project: 8-bit ALU
// Author: Aiden Huang
// Date: 2026-06-02
// Description: Performs 8-bit addition and subtraction with carry/borrow and signed overflow flags.
// Sources used: Course project prompt and SystemVerilog language reference.

module add_sub_unit (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic       subtract,
    output logic [7:0] result,
    output logic       carry,
    output logic       overflow
);

    logic [7:0] b_effective;
    logic [8:0] sum;

    assign b_effective = subtract ? ~b : b;
    assign sum = {1'b0, a} + {1'b0, b_effective} + {8'b0, subtract};

    assign result = sum[7:0];
    assign carry = sum[8];

    always_comb begin
        if (subtract) begin
            overflow = (a[7] != b[7]) && (result[7] != a[7]);
        end else begin
            overflow = (a[7] == b[7]) && (result[7] != a[7]);
        end
    end

endmodule
