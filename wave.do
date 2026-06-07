onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {ALU Inputs}
add wave -noupdate -radix hexadecimal /alu8_tb/a
add wave -noupdate -radix hexadecimal /alu8_tb/b
add wave -noupdate -radix binary /alu8_tb/opcode
add wave -noupdate /alu8_tb/enable
add wave -noupdate /alu8_tb/reset_n
add wave -noupdate -divider {ALU Outputs}
add wave -noupdate -radix hexadecimal /alu8_tb/result
add wave -noupdate /alu8_tb/carry
add wave -noupdate /alu8_tb/overflow
add wave -noupdate -radix binary /alu8_tb/display
add wave -noupdate -divider {Decoder Selects}
add wave -noupdate /alu8_tb/dut/sel_add
add wave -noupdate /alu8_tb/dut/sel_sub
add wave -noupdate /alu8_tb/dut/sel_and
add wave -noupdate /alu8_tb/dut/sel_or
add wave -noupdate /alu8_tb/dut/sel_xor
add wave -noupdate /alu8_tb/dut/sel_pass_a
add wave -noupdate /alu8_tb/dut/sel_pass_b
add wave -noupdate /alu8_tb/dut/sel_not_a
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 180
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {168 ns}
