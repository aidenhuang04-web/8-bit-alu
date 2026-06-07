transcript file alu8_transcript.txt
transcript on

if {[file exists work]} {
    vdel -lib work -all
}

vlib work
vlog -sv opcode_decoder.sv
vlog -sv and_op.sv
vlog -sv or_op.sv
vlog -sv xor_op.sv
vlog -sv not_a_op.sv
vlog -sv add_sub_unit.sv
vlog -sv shift_unit.sv
vlog -sv display_hex.sv
vlog -sv output_handler.sv
vlog -sv alu8.sv
vlog -sv alu8_tb.sv

vsim -voptargs=+acc work.alu8_tb

add wave -divider "ALU Inputs"
add wave -radix hexadecimal sim:/alu8_tb/a
add wave -radix hexadecimal sim:/alu8_tb/b
add wave -radix binary sim:/alu8_tb/opcode
add wave sim:/alu8_tb/enable
add wave sim:/alu8_tb/reset_n

add wave -divider "ALU Outputs"
add wave -radix hexadecimal sim:/alu8_tb/result
add wave sim:/alu8_tb/carry
add wave sim:/alu8_tb/overflow
add wave -radix binary sim:/alu8_tb/display

add wave -divider "Decoder Selects"
add wave sim:/alu8_tb/dut/sel_add
add wave sim:/alu8_tb/dut/sel_sub
add wave sim:/alu8_tb/dut/sel_and
add wave sim:/alu8_tb/dut/sel_or
add wave sim:/alu8_tb/dut/sel_xor
add wave sim:/alu8_tb/dut/sel_pass_a
add wave sim:/alu8_tb/dut/sel_pass_b
add wave sim:/alu8_tb/dut/sel_not_a
add wave sim:/alu8_tb/dut/sel_shift

configure wave -namecolwidth 180
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
run -all
wave zoom full
transcript off
