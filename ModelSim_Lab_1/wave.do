onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /rsqrt_tb/W
add wave -noupdate /rsqrt_tb/F
add wave -noupdate -divider {Clock & Data in}
add wave -noupdate /rsqrt_tb/clock
add wave -noupdate /rsqrt_tb/in_number
add wave -noupdate -divider {Leading Zero}
add wave -noupdate -radix decimal /rsqrt_tb/leading_zero
add wave -noupdate /rsqrt_tb/Z
add wave -noupdate -divider {Beta Computation}
add wave -noupdate /rsqrt_tb/beta_int
add wave -noupdate -radix decimal /rsqrt_tb/beta_signed
add wave -noupdate /rsqrt_tb/beta_signed
add wave -noupdate -divider {Alpha Computation}
add wave -noupdate -radix decimal /rsqrt_tb/B_even
add wave -noupdate -radix decimal /rsqrt_tb/B_odd
add wave -noupdate -radix decimal /rsqrt_tb/A_even
add wave -noupdate -radix decimal /rsqrt_tb/A_odd
add wave -noupdate -divider {Alpha Shift}
add wave -noupdate -radix decimal /rsqrt_tb/real_alpha
add wave -noupdate /rsqrt_tb/in_number
add wave -noupdate /rsqrt_tb/out_alpha_number
add wave -noupdate -divider {Beta Shift}
add wave -noupdate /rsqrt_tb/in_number
add wave -noupdate /rsqrt_tb/beta_signed
add wave -noupdate /rsqrt_tb/out_beta_number
add wave -noupdate -divider {Lookup Table}
add wave -noupdate /rsqrt_tb/out_beta_number
add wave -noupdate /rsqrt_tb/rom_address
add wave -noupdate /rsqrt_tb/rom_output
add wave -noupdate -divider {Initial Guess}
add wave -noupdate -radix decimal /rsqrt_tb/beta_signed
add wave -noupdate /rsqrt_tb/rom_output
add wave -noupdate /rsqrt_tb/out_alpha_number
add wave -noupdate /rsqrt_tb/yn_even_output
add wave -noupdate /rsqrt_tb/yn_odd_output
add wave -noupdate -divider {Final Step}
add wave -noupdate /rsqrt_tb/yn_final_output
add wave -noupdate /rsqrt_tb/out_number
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16933 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 204
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
configure wave -timelineunits ps
update
WaveRestoreZoom {10318 ps} {25063 ps}
