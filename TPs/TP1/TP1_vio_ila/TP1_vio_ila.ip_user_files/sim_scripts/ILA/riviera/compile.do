transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/814a/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/1017/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/52c0/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/2276/hdl/verilog" -l xpm -l xil_defaultlib \
"C:/Xilinx/tools/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/tools/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"C:/Xilinx/tools/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/814a/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/1017/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/52c0/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/2276/hdl/verilog" -l xpm -l xil_defaultlib \
"../../../bd/ILA/ip/ILA_ila_0_0/sim/ILA_ila_0_0.v" \
"../../../bd/ILA/sim/ILA.v" \

vlog -work xil_defaultlib \
"glbl.v"

