vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/814a/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/1017/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/52c0/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/2276/hdl/verilog" \
"C:/Xilinx/tools/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/tools/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/tools/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/814a/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/1017/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/52c0/hdl/verilog" "+incdir+../../../../TP1_vio_ila.gen/sources_1/bd/ILA/ipshared/2276/hdl/verilog" \
"../../../bd/ILA/ip/ILA_ila_0_0/sim/ILA_ila_0_0.v" \
"../../../bd/ILA/sim/ILA.v" \

vlog -work xil_defaultlib \
"glbl.v"

