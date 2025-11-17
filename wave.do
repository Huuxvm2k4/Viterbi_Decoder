onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/dut/clk
add wave -noupdate /tb_top/dut/rst_n
add wave -noupdate /tb_top/dut/en
add wave -noupdate -radix binary /tb_top/dut/d_in
add wave -noupdate -radix binary /tb_top/dut/d_out
add wave -noupdate -radix binary /tb_top/dut/d_valid
add wave -noupdate -radix binary /tb_top/dut/we
add wave -noupdate -radix binary /tb_top/dut/te
add wave -noupdate -radix binary /tb_top/dut/oe
add wave -noupdate -radix unsigned /tb_top/dut/wr_cnt
add wave -noupdate -radix unsigned /tb_top/dut/tb_cnt
add wave -noupdate -expand -group 00 -radix unsigned /tb_top/dut/bmc00_path_0
add wave -noupdate -expand -group 00 -radix unsigned /tb_top/dut/n_ACS00_path_cost
add wave -noupdate -expand -group 00 -radix unsigned /tb_top/dut/bmc00_path_1
add wave -noupdate -expand -group 00 -radix unsigned /tb_top/dut/n_ACS01_path_cost
add wave -noupdate -expand -group 00 -radix unsigned /tb_top/dut/ACS00_path_cost
add wave -noupdate -expand -group 00 -radix binary /tb_top/dut/ACS00_selection
add wave -noupdate -expand -group 00 -radix binary /tb_top/dut/ACS00_selection_o
add wave -noupdate -expand -group 10 -radix unsigned /tb_top/dut/bmc10_path_0
add wave -noupdate -expand -group 10 -radix unsigned /tb_top/dut/n_ACS00_path_cost
add wave -noupdate -expand -group 10 -radix unsigned /tb_top/dut/bmc10_path_1
add wave -noupdate -expand -group 10 -radix unsigned /tb_top/dut/n_ACS01_path_cost
add wave -noupdate -expand -group 10 -radix unsigned /tb_top/dut/ACS10_path_cost
add wave -noupdate -expand -group 10 -radix binary /tb_top/dut/ACS10_selection
add wave -noupdate -expand -group 10 -radix binary /tb_top/dut/ACS10_selection_o
add wave -noupdate -group 01 -radix unsigned /tb_top/dut/bmc01_path_0
add wave -noupdate -group 01 -radix unsigned /tb_top/dut/n_ACS10_path_cost
add wave -noupdate -group 01 -radix unsigned /tb_top/dut/bmc01_path_1
add wave -noupdate -group 01 -radix unsigned /tb_top/dut/n_ACS11_path_cost
add wave -noupdate -group 01 -radix unsigned /tb_top/dut/ACS01_path_cost
add wave -noupdate -group 01 -radix binary /tb_top/dut/ACS01_selection
add wave -noupdate -group 01 -radix binary /tb_top/dut/ACS01_selection_o
add wave -noupdate -group 11 -radix unsigned /tb_top/dut/bmc11_path_0
add wave -noupdate -group 11 -radix unsigned /tb_top/dut/n_ACS10_path_cost
add wave -noupdate -group 11 -radix unsigned /tb_top/dut/bmc11_path_1
add wave -noupdate -group 11 -radix unsigned /tb_top/dut/n_ACS11_path_cost
add wave -noupdate -group 11 -radix unsigned /tb_top/dut/ACS11_path_cost
add wave -noupdate -group 11 -radix binary /tb_top/dut/ACS11_selection
add wave -noupdate -group 11 -radix binary /tb_top/dut/ACS11_selection_o
add wave -noupdate -radix binary /tb_top/dut/u_control/state
add wave -noupdate -radix binary /tb_top/dut/u_control/n_state
add wave -noupdate -radix binary /tb_top/dut/u_tb/min_inst/min_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {79742 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 165
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
WaveRestoreZoom {0 ps} {225750 ps}
