onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLOCK_50 -radix binary /testbench/CLOCK_50
add wave -noupdate -label Reset -radix binary /testbench/reset

add wave -noupdate -divider Inputs
add wave -noupdate -label inputA -radix hexadecimal /testbench/inputA
add wave -noupdate -label inputB -radix hexadecimal /testbench/inputB
add wave -noupdate -label select -radix hexadecimal /testbench/ALUSelect

add wave -noupdate -divider "Internal Nets"

add wave -noupdate -divider Outputs
add wave -noupdate -label output -radix hexadecimal /testbench/dataOut
add wave -noupdate -label outputHigh -radix hexadecimal /testbench/dataOutHigh
add wave -noupdate -label expectedOutput -radix hexadecimal /testbench/dataOutExpected
add wave -noupdate -label expectedOutputHigh -radix hexadecimal /testbench/dataOutHighExpected

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 80
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {300 ns}
