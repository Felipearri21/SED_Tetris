vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../ipstatic" \
"../../../../Trabajo_V.5.gen/sources_1/ip/clk_wiz_tetris/clk_wiz_tetris_clk_wiz.v" \
"../../../../Trabajo_V.5.gen/sources_1/ip/clk_wiz_tetris/clk_wiz_tetris.v" \


vlog -work xil_defaultlib \
"glbl.v"

