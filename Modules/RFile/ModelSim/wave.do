onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLOCK_50 -radix binary /testbench/CLOCK_50
add wave -noupdate -label Reset -radix binary /testbench/reset

add wave -noupdate -divider Inputs
add wave -noupdate -label registerA -radix hexadecimal /testbench/regA
add wave -noupdate -label RegisterB -radix hexadecimal /testbench/regB
add wave -noupdate -label registerW -radix hexadecimal /testbench/regW
add wave -noupdate -label dataW -radix hexadecimal /testbench/dataW

add wave -noupdate -divider "Internal Nets"

add wave -noupdate -divider Outputs
add wave -noupdate -label dataA -radix hexadecimal /testbench/dataA
add wave -noupdate -label dataB -radix hexadecimal /testbench/dataB

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
