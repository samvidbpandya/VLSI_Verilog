onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_niosII/dut/fetch_unit/clk
add wave -noupdate -radix unsigned /tb_niosII/dut/fetch_unit/PC
add wave -noupdate -radix hexadecimal /tb_niosII/dut/fetch_unit/instruction
add wave -noupdate -radix unsigned /tb_niosII/dut/dec_unit/alu_ctrl
add wave -noupdate -radix unsigned /tb_niosII/dut/dec_unit/exe_mux1_hctrl
add wave -noupdate -radix unsigned /tb_niosII/dut/dec_unit/exe_mux2_hctrl
add wave -noupdate -radix unsigned /tb_niosII/dut/dec_unit/mem_rd
add wave -noupdate -radix unsigned /tb_niosII/dut/dec_unit/mem_wr
add wave -noupdate -radix unsigned /tb_niosII/dut/dec_unit/opcode
add wave -noupdate -radix unsigned /tb_niosII/dut/dec_unit/reg_wr
add wave -noupdate -radix unsigned /tb_niosII/dut/dec_unit/reg_wr_add
add wave -noupdate -radix unsigned /tb_niosII/dut/exe_unit/alu_ctrl
add wave -noupdate -radix unsigned /tb_niosII/dut/exe_unit/data1
add wave -noupdate -radix unsigned /tb_niosII/dut/exe_unit/data1_reg
add wave -noupdate -radix unsigned /tb_niosII/dut/exe_unit/data2
add wave -noupdate -radix unsigned /tb_niosII/dut/exe_unit/data2_reg
add wave -noupdate -radix unsigned /tb_niosII/dut/exe_unit/mem_exe_reslt_data
add wave -noupdate -radix unsigned /tb_niosII/dut/exe_unit/reslt_data_out
add wave -noupdate -radix unsigned /tb_niosII/dut/exe_unit/wb_dec_exe_reslt_data
add wave -noupdate -radix unsigned /tb_niosII/dut/exe_unit/wb_exe_reslt_data
add wave -noupdate -radix unsigned /tb_niosII/dut/mem_unit/exe_mem_reslt_data_out
add wave -noupdate -radix unsigned /tb_niosII/dut/mem_unit/mem_hctrl_reg_wr_add
add wave -noupdate -radix unsigned /tb_niosII/dut/mem_unit/mem_rd
add wave -noupdate -radix unsigned /tb_niosII/dut/mem_unit/mem_wr
add wave -noupdate -radix unsigned /tb_niosII/dut/wb_unit/wb_dec_reg_wr_add
add wave -noupdate -radix unsigned /tb_niosII/dut/wb_unit/wb_dec_reg_wr_data
add wave -noupdate -radix unsigned /tb_niosII/dut/wb_unit/wb_dec_reg_wr_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {652 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 278
configure wave -valuecolwidth 100
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
WaveRestoreZoom {642 ns} {698 ns}
