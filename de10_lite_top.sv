// Project: 8-bit ALU
// Author: Aiden Huang
// Date: 2026-06-06
// Project: 8-bit ALU
// Description: DE10-Lite board wrapper for the reusable alu8 module.

module de10_lite_top (
    input  logic [9:0] SW,
    input  logic [1:0] KEY,
    output logic [9:0] LEDR,
    output logic [6:0] HEX0,
    output logic [6:0] HEX1
);

    logic [7:0] a_reg;
    logic [7:0] b_reg;
    logic [3:0] opcode_reg;
    logic [7:0] result;
    logic [7:0] board_display_value;
    logic [1:0] display_mode;
    logic       carry;
    logic       overflow;
    logic [13:0] display;
    logic [13:0] board_display;

    always_ff @(negedge KEY[1] or negedge KEY[0]) begin
        if (!KEY[0]) begin
            a_reg <= 8'h00;
            b_reg <= 8'h00;
            opcode_reg <= 4'h0;
            display_mode <= 2'b00;
        end else begin
            unique case (SW[9:8])
                2'b00: begin
                    a_reg <= SW[7:0];
                    display_mode <= 2'b00;
                end
                2'b01: begin
                    b_reg <= SW[7:0];
                    display_mode <= 2'b01;
                end
                2'b10: begin
                    opcode_reg <= SW[3:0];
                    display_mode <= 2'b10;
                end
                default: begin
                    a_reg <= a_reg;
                    b_reg <= b_reg;
                    opcode_reg <= opcode_reg;
                    display_mode <= 2'b11;
                end
            endcase
        end
    end

    alu8 alu (
        .a(a_reg),
        .b(b_reg),
        .opcode(opcode_reg),
        .enable(1'b1),
        .reset_n(KEY[0]),
        .result(result),
        .carry(carry),
        .overflow(overflow),
        .display(display)
    );

    always_comb begin
        unique case (display_mode)
            2'b00: board_display_value = a_reg;
            2'b01: board_display_value = b_reg;
            2'b10: board_display_value = {4'b0000, opcode_reg};
            default: board_display_value = result;
        endcase
    end

    display_hex board_high_digit (
        .value(board_display_value[7:4]),
        .segments(board_display[13:7])
    );

    display_hex board_low_digit (
        .value(board_display_value[3:0]),
        .segments(board_display[6:0])
    );

    assign LEDR[7:0] = board_display_value;
    assign LEDR[8]   = (display_mode == 2'b11) ? carry : 1'b0;
    assign LEDR[9]   = (display_mode == 2'b11) ? overflow : 1'b0;
    assign HEX0      = board_display[6:0];
    assign HEX1      = board_display[13:7];

endmodule
