transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../ipstatic" -l xil_defaultlib \
"../../../../Trabajo_V.5.gen/sources_1/ip/clk_wiz_tetris/clk_wiz_tetris_clk_wiz.v" \
"../../../../Trabajo_V.5.gen/sources_1/ip/clk_wiz_tetris/clk_wiz_tetris.v" \


vlog -work xil_defaultlib \
"glbl.v"

