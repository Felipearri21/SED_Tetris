// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Thu Nov 27 20:33:43 2025
// Host        : Pepo running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/G531GW/Desktop/Universidad/7_Septimo_Semestre/Sistemas_Electronicos_Digitales_SED/FPGAs/Trabajo/Trabajo.sim/sim_1/synth/timing/xsim/tb_tetris_top_time_synth.v
// Design      : clk_divider
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a12ticsg325-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* DROP_SPEED = "25000000" *) (* GAME_SPEED = "5000000" *) 
(* NotValidForBitStream *)
module clk_divider
   (clk,
    reset,
    tick_game,
    tick_drop);
  input clk;
  input reset;
  output tick_game;
  output tick_drop;

  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [31:0]cnt_drop;
  wire \cnt_drop[31]_i_10_n_0 ;
  wire \cnt_drop[31]_i_2_n_0 ;
  wire \cnt_drop[31]_i_3_n_0 ;
  wire \cnt_drop[31]_i_4_n_0 ;
  wire \cnt_drop[31]_i_6_n_0 ;
  wire \cnt_drop[31]_i_7_n_0 ;
  wire \cnt_drop[31]_i_8_n_0 ;
  wire \cnt_drop[31]_i_9_n_0 ;
  wire \cnt_drop_reg[12]_i_2_n_0 ;
  wire \cnt_drop_reg[12]_i_2_n_1 ;
  wire \cnt_drop_reg[12]_i_2_n_2 ;
  wire \cnt_drop_reg[12]_i_2_n_3 ;
  wire \cnt_drop_reg[12]_i_2_n_4 ;
  wire \cnt_drop_reg[12]_i_2_n_5 ;
  wire \cnt_drop_reg[12]_i_2_n_6 ;
  wire \cnt_drop_reg[12]_i_2_n_7 ;
  wire \cnt_drop_reg[16]_i_2_n_0 ;
  wire \cnt_drop_reg[16]_i_2_n_1 ;
  wire \cnt_drop_reg[16]_i_2_n_2 ;
  wire \cnt_drop_reg[16]_i_2_n_3 ;
  wire \cnt_drop_reg[16]_i_2_n_4 ;
  wire \cnt_drop_reg[16]_i_2_n_5 ;
  wire \cnt_drop_reg[16]_i_2_n_6 ;
  wire \cnt_drop_reg[16]_i_2_n_7 ;
  wire \cnt_drop_reg[20]_i_2_n_0 ;
  wire \cnt_drop_reg[20]_i_2_n_1 ;
  wire \cnt_drop_reg[20]_i_2_n_2 ;
  wire \cnt_drop_reg[20]_i_2_n_3 ;
  wire \cnt_drop_reg[20]_i_2_n_4 ;
  wire \cnt_drop_reg[20]_i_2_n_5 ;
  wire \cnt_drop_reg[20]_i_2_n_6 ;
  wire \cnt_drop_reg[20]_i_2_n_7 ;
  wire \cnt_drop_reg[24]_i_2_n_0 ;
  wire \cnt_drop_reg[24]_i_2_n_1 ;
  wire \cnt_drop_reg[24]_i_2_n_2 ;
  wire \cnt_drop_reg[24]_i_2_n_3 ;
  wire \cnt_drop_reg[24]_i_2_n_4 ;
  wire \cnt_drop_reg[24]_i_2_n_5 ;
  wire \cnt_drop_reg[24]_i_2_n_6 ;
  wire \cnt_drop_reg[24]_i_2_n_7 ;
  wire \cnt_drop_reg[28]_i_2_n_0 ;
  wire \cnt_drop_reg[28]_i_2_n_1 ;
  wire \cnt_drop_reg[28]_i_2_n_2 ;
  wire \cnt_drop_reg[28]_i_2_n_3 ;
  wire \cnt_drop_reg[28]_i_2_n_4 ;
  wire \cnt_drop_reg[28]_i_2_n_5 ;
  wire \cnt_drop_reg[28]_i_2_n_6 ;
  wire \cnt_drop_reg[28]_i_2_n_7 ;
  wire \cnt_drop_reg[31]_i_5_n_2 ;
  wire \cnt_drop_reg[31]_i_5_n_3 ;
  wire \cnt_drop_reg[31]_i_5_n_5 ;
  wire \cnt_drop_reg[31]_i_5_n_6 ;
  wire \cnt_drop_reg[31]_i_5_n_7 ;
  wire \cnt_drop_reg[4]_i_2_n_0 ;
  wire \cnt_drop_reg[4]_i_2_n_1 ;
  wire \cnt_drop_reg[4]_i_2_n_2 ;
  wire \cnt_drop_reg[4]_i_2_n_3 ;
  wire \cnt_drop_reg[4]_i_2_n_4 ;
  wire \cnt_drop_reg[4]_i_2_n_5 ;
  wire \cnt_drop_reg[4]_i_2_n_6 ;
  wire \cnt_drop_reg[4]_i_2_n_7 ;
  wire \cnt_drop_reg[8]_i_2_n_0 ;
  wire \cnt_drop_reg[8]_i_2_n_1 ;
  wire \cnt_drop_reg[8]_i_2_n_2 ;
  wire \cnt_drop_reg[8]_i_2_n_3 ;
  wire \cnt_drop_reg[8]_i_2_n_4 ;
  wire \cnt_drop_reg[8]_i_2_n_5 ;
  wire \cnt_drop_reg[8]_i_2_n_6 ;
  wire \cnt_drop_reg[8]_i_2_n_7 ;
  wire \cnt_drop_reg_n_0_[0] ;
  wire \cnt_drop_reg_n_0_[10] ;
  wire \cnt_drop_reg_n_0_[11] ;
  wire \cnt_drop_reg_n_0_[12] ;
  wire \cnt_drop_reg_n_0_[13] ;
  wire \cnt_drop_reg_n_0_[14] ;
  wire \cnt_drop_reg_n_0_[15] ;
  wire \cnt_drop_reg_n_0_[16] ;
  wire \cnt_drop_reg_n_0_[17] ;
  wire \cnt_drop_reg_n_0_[18] ;
  wire \cnt_drop_reg_n_0_[19] ;
  wire \cnt_drop_reg_n_0_[1] ;
  wire \cnt_drop_reg_n_0_[20] ;
  wire \cnt_drop_reg_n_0_[21] ;
  wire \cnt_drop_reg_n_0_[22] ;
  wire \cnt_drop_reg_n_0_[23] ;
  wire \cnt_drop_reg_n_0_[24] ;
  wire \cnt_drop_reg_n_0_[25] ;
  wire \cnt_drop_reg_n_0_[26] ;
  wire \cnt_drop_reg_n_0_[27] ;
  wire \cnt_drop_reg_n_0_[28] ;
  wire \cnt_drop_reg_n_0_[29] ;
  wire \cnt_drop_reg_n_0_[2] ;
  wire \cnt_drop_reg_n_0_[30] ;
  wire \cnt_drop_reg_n_0_[31] ;
  wire \cnt_drop_reg_n_0_[3] ;
  wire \cnt_drop_reg_n_0_[4] ;
  wire \cnt_drop_reg_n_0_[5] ;
  wire \cnt_drop_reg_n_0_[6] ;
  wire \cnt_drop_reg_n_0_[7] ;
  wire \cnt_drop_reg_n_0_[8] ;
  wire \cnt_drop_reg_n_0_[9] ;
  wire [31:0]cnt_game;
  wire \cnt_game[31]_i_10_n_0 ;
  wire \cnt_game[31]_i_2_n_0 ;
  wire \cnt_game[31]_i_3_n_0 ;
  wire \cnt_game[31]_i_4_n_0 ;
  wire \cnt_game[31]_i_6_n_0 ;
  wire \cnt_game[31]_i_7_n_0 ;
  wire \cnt_game[31]_i_8_n_0 ;
  wire \cnt_game[31]_i_9_n_0 ;
  wire \cnt_game_reg[12]_i_2_n_0 ;
  wire \cnt_game_reg[12]_i_2_n_1 ;
  wire \cnt_game_reg[12]_i_2_n_2 ;
  wire \cnt_game_reg[12]_i_2_n_3 ;
  wire \cnt_game_reg[16]_i_2_n_0 ;
  wire \cnt_game_reg[16]_i_2_n_1 ;
  wire \cnt_game_reg[16]_i_2_n_2 ;
  wire \cnt_game_reg[16]_i_2_n_3 ;
  wire \cnt_game_reg[20]_i_2_n_0 ;
  wire \cnt_game_reg[20]_i_2_n_1 ;
  wire \cnt_game_reg[20]_i_2_n_2 ;
  wire \cnt_game_reg[20]_i_2_n_3 ;
  wire \cnt_game_reg[24]_i_2_n_0 ;
  wire \cnt_game_reg[24]_i_2_n_1 ;
  wire \cnt_game_reg[24]_i_2_n_2 ;
  wire \cnt_game_reg[24]_i_2_n_3 ;
  wire \cnt_game_reg[28]_i_2_n_0 ;
  wire \cnt_game_reg[28]_i_2_n_1 ;
  wire \cnt_game_reg[28]_i_2_n_2 ;
  wire \cnt_game_reg[28]_i_2_n_3 ;
  wire \cnt_game_reg[31]_i_5_n_2 ;
  wire \cnt_game_reg[31]_i_5_n_3 ;
  wire \cnt_game_reg[4]_i_2_n_0 ;
  wire \cnt_game_reg[4]_i_2_n_1 ;
  wire \cnt_game_reg[4]_i_2_n_2 ;
  wire \cnt_game_reg[4]_i_2_n_3 ;
  wire \cnt_game_reg[8]_i_2_n_0 ;
  wire \cnt_game_reg[8]_i_2_n_1 ;
  wire \cnt_game_reg[8]_i_2_n_2 ;
  wire \cnt_game_reg[8]_i_2_n_3 ;
  wire \cnt_game_reg_n_0_[0] ;
  wire \cnt_game_reg_n_0_[10] ;
  wire \cnt_game_reg_n_0_[11] ;
  wire \cnt_game_reg_n_0_[12] ;
  wire \cnt_game_reg_n_0_[13] ;
  wire \cnt_game_reg_n_0_[14] ;
  wire \cnt_game_reg_n_0_[15] ;
  wire \cnt_game_reg_n_0_[16] ;
  wire \cnt_game_reg_n_0_[17] ;
  wire \cnt_game_reg_n_0_[18] ;
  wire \cnt_game_reg_n_0_[19] ;
  wire \cnt_game_reg_n_0_[1] ;
  wire \cnt_game_reg_n_0_[20] ;
  wire \cnt_game_reg_n_0_[21] ;
  wire \cnt_game_reg_n_0_[22] ;
  wire \cnt_game_reg_n_0_[23] ;
  wire \cnt_game_reg_n_0_[24] ;
  wire \cnt_game_reg_n_0_[25] ;
  wire \cnt_game_reg_n_0_[26] ;
  wire \cnt_game_reg_n_0_[27] ;
  wire \cnt_game_reg_n_0_[28] ;
  wire \cnt_game_reg_n_0_[29] ;
  wire \cnt_game_reg_n_0_[2] ;
  wire \cnt_game_reg_n_0_[30] ;
  wire \cnt_game_reg_n_0_[31] ;
  wire \cnt_game_reg_n_0_[3] ;
  wire \cnt_game_reg_n_0_[4] ;
  wire \cnt_game_reg_n_0_[5] ;
  wire \cnt_game_reg_n_0_[6] ;
  wire \cnt_game_reg_n_0_[7] ;
  wire \cnt_game_reg_n_0_[8] ;
  wire \cnt_game_reg_n_0_[9] ;
  wire [31:1]data0;
  wire reset;
  wire reset_IBUF;
  wire tick_drop;
  wire tick_drop_OBUF;
  wire tick_drop_i_1_n_0;
  wire tick_game;
  wire tick_game_OBUF;
  wire tick_game_i_1_n_0;
  wire [3:2]\NLW_cnt_drop_reg[31]_i_5_CO_UNCONNECTED ;
  wire [3:3]\NLW_cnt_drop_reg[31]_i_5_O_UNCONNECTED ;
  wire [3:2]\NLW_cnt_game_reg[31]_i_5_CO_UNCONNECTED ;
  wire [3:3]\NLW_cnt_game_reg[31]_i_5_O_UNCONNECTED ;

initial begin
 $sdf_annotate("tb_tetris_top_time_synth.sdf",,,,"tool_control");
end
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h00FE)) 
    \cnt_drop[0]_i_1 
       (.I0(\cnt_drop[31]_i_4_n_0 ),
        .I1(\cnt_drop[31]_i_3_n_0 ),
        .I2(\cnt_drop[31]_i_2_n_0 ),
        .I3(\cnt_drop_reg_n_0_[0] ),
        .O(cnt_drop[0]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[10]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[12]_i_2_n_6 ),
        .O(cnt_drop[10]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[11]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[12]_i_2_n_5 ),
        .O(cnt_drop[11]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[12]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[12]_i_2_n_4 ),
        .O(cnt_drop[12]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[13]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[16]_i_2_n_7 ),
        .O(cnt_drop[13]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[14]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[16]_i_2_n_6 ),
        .O(cnt_drop[14]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[15]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[16]_i_2_n_5 ),
        .O(cnt_drop[15]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[16]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[16]_i_2_n_4 ),
        .O(cnt_drop[16]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[17]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[20]_i_2_n_7 ),
        .O(cnt_drop[17]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[18]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[20]_i_2_n_6 ),
        .O(cnt_drop[18]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[19]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[20]_i_2_n_5 ),
        .O(cnt_drop[19]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[1]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[4]_i_2_n_7 ),
        .O(cnt_drop[1]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[20]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[20]_i_2_n_4 ),
        .O(cnt_drop[20]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[21]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[24]_i_2_n_7 ),
        .O(cnt_drop[21]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[22]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[24]_i_2_n_6 ),
        .O(cnt_drop[22]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[23]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[24]_i_2_n_5 ),
        .O(cnt_drop[23]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[24]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[24]_i_2_n_4 ),
        .O(cnt_drop[24]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[25]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[28]_i_2_n_7 ),
        .O(cnt_drop[25]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[26]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[28]_i_2_n_6 ),
        .O(cnt_drop[26]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[27]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[28]_i_2_n_5 ),
        .O(cnt_drop[27]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[28]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[28]_i_2_n_4 ),
        .O(cnt_drop[28]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[29]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[31]_i_5_n_7 ),
        .O(cnt_drop[29]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[2]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[4]_i_2_n_6 ),
        .O(cnt_drop[2]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[30]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[31]_i_5_n_6 ),
        .O(cnt_drop[30]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[31]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[31]_i_5_n_5 ),
        .O(cnt_drop[31]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \cnt_drop[31]_i_10 
       (.I0(\cnt_drop_reg_n_0_[27] ),
        .I1(\cnt_drop_reg_n_0_[26] ),
        .I2(\cnt_drop_reg_n_0_[29] ),
        .I3(\cnt_drop_reg_n_0_[28] ),
        .O(\cnt_drop[31]_i_10_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF7FF)) 
    \cnt_drop[31]_i_2 
       (.I0(\cnt_drop_reg_n_0_[12] ),
        .I1(\cnt_drop_reg_n_0_[13] ),
        .I2(\cnt_drop_reg_n_0_[10] ),
        .I3(\cnt_drop_reg_n_0_[11] ),
        .I4(\cnt_drop[31]_i_6_n_0 ),
        .O(\cnt_drop[31]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \cnt_drop[31]_i_3 
       (.I0(\cnt_drop_reg_n_0_[4] ),
        .I1(\cnt_drop_reg_n_0_[5] ),
        .I2(\cnt_drop_reg_n_0_[2] ),
        .I3(\cnt_drop_reg_n_0_[3] ),
        .I4(\cnt_drop[31]_i_7_n_0 ),
        .O(\cnt_drop[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \cnt_drop[31]_i_4 
       (.I0(\cnt_drop[31]_i_8_n_0 ),
        .I1(\cnt_drop[31]_i_9_n_0 ),
        .I2(\cnt_drop_reg_n_0_[31] ),
        .I3(\cnt_drop_reg_n_0_[30] ),
        .I4(\cnt_drop_reg_n_0_[1] ),
        .I5(\cnt_drop[31]_i_10_n_0 ),
        .O(\cnt_drop[31]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \cnt_drop[31]_i_6 
       (.I0(\cnt_drop_reg_n_0_[14] ),
        .I1(\cnt_drop_reg_n_0_[15] ),
        .I2(\cnt_drop_reg_n_0_[16] ),
        .I3(\cnt_drop_reg_n_0_[17] ),
        .O(\cnt_drop[31]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFD)) 
    \cnt_drop[31]_i_7 
       (.I0(\cnt_drop_reg_n_0_[6] ),
        .I1(\cnt_drop_reg_n_0_[7] ),
        .I2(\cnt_drop_reg_n_0_[9] ),
        .I3(\cnt_drop_reg_n_0_[8] ),
        .O(\cnt_drop[31]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \cnt_drop[31]_i_8 
       (.I0(\cnt_drop_reg_n_0_[22] ),
        .I1(\cnt_drop_reg_n_0_[23] ),
        .I2(\cnt_drop_reg_n_0_[24] ),
        .I3(\cnt_drop_reg_n_0_[25] ),
        .O(\cnt_drop[31]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \cnt_drop[31]_i_9 
       (.I0(\cnt_drop_reg_n_0_[19] ),
        .I1(\cnt_drop_reg_n_0_[18] ),
        .I2(\cnt_drop_reg_n_0_[21] ),
        .I3(\cnt_drop_reg_n_0_[20] ),
        .O(\cnt_drop[31]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[3]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[4]_i_2_n_5 ),
        .O(cnt_drop[3]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[4]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[4]_i_2_n_4 ),
        .O(cnt_drop[4]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[5]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[8]_i_2_n_7 ),
        .O(cnt_drop[5]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[6]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[8]_i_2_n_6 ),
        .O(cnt_drop[6]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[7]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[8]_i_2_n_5 ),
        .O(cnt_drop[7]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[8]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[8]_i_2_n_4 ),
        .O(cnt_drop[8]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_drop[9]_i_1 
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .I4(\cnt_drop_reg[12]_i_2_n_7 ),
        .O(cnt_drop[9]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[0]),
        .Q(\cnt_drop_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[10]),
        .Q(\cnt_drop_reg_n_0_[10] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[11]),
        .Q(\cnt_drop_reg_n_0_[11] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[12]),
        .Q(\cnt_drop_reg_n_0_[12] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_drop_reg[12]_i_2 
       (.CI(\cnt_drop_reg[8]_i_2_n_0 ),
        .CO({\cnt_drop_reg[12]_i_2_n_0 ,\cnt_drop_reg[12]_i_2_n_1 ,\cnt_drop_reg[12]_i_2_n_2 ,\cnt_drop_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cnt_drop_reg[12]_i_2_n_4 ,\cnt_drop_reg[12]_i_2_n_5 ,\cnt_drop_reg[12]_i_2_n_6 ,\cnt_drop_reg[12]_i_2_n_7 }),
        .S({\cnt_drop_reg_n_0_[12] ,\cnt_drop_reg_n_0_[11] ,\cnt_drop_reg_n_0_[10] ,\cnt_drop_reg_n_0_[9] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[13]),
        .Q(\cnt_drop_reg_n_0_[13] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[14]),
        .Q(\cnt_drop_reg_n_0_[14] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[15]),
        .Q(\cnt_drop_reg_n_0_[15] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[16]),
        .Q(\cnt_drop_reg_n_0_[16] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_drop_reg[16]_i_2 
       (.CI(\cnt_drop_reg[12]_i_2_n_0 ),
        .CO({\cnt_drop_reg[16]_i_2_n_0 ,\cnt_drop_reg[16]_i_2_n_1 ,\cnt_drop_reg[16]_i_2_n_2 ,\cnt_drop_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cnt_drop_reg[16]_i_2_n_4 ,\cnt_drop_reg[16]_i_2_n_5 ,\cnt_drop_reg[16]_i_2_n_6 ,\cnt_drop_reg[16]_i_2_n_7 }),
        .S({\cnt_drop_reg_n_0_[16] ,\cnt_drop_reg_n_0_[15] ,\cnt_drop_reg_n_0_[14] ,\cnt_drop_reg_n_0_[13] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[17]),
        .Q(\cnt_drop_reg_n_0_[17] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[18]),
        .Q(\cnt_drop_reg_n_0_[18] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[19]),
        .Q(\cnt_drop_reg_n_0_[19] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[1]),
        .Q(\cnt_drop_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[20]),
        .Q(\cnt_drop_reg_n_0_[20] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_drop_reg[20]_i_2 
       (.CI(\cnt_drop_reg[16]_i_2_n_0 ),
        .CO({\cnt_drop_reg[20]_i_2_n_0 ,\cnt_drop_reg[20]_i_2_n_1 ,\cnt_drop_reg[20]_i_2_n_2 ,\cnt_drop_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cnt_drop_reg[20]_i_2_n_4 ,\cnt_drop_reg[20]_i_2_n_5 ,\cnt_drop_reg[20]_i_2_n_6 ,\cnt_drop_reg[20]_i_2_n_7 }),
        .S({\cnt_drop_reg_n_0_[20] ,\cnt_drop_reg_n_0_[19] ,\cnt_drop_reg_n_0_[18] ,\cnt_drop_reg_n_0_[17] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[21]),
        .Q(\cnt_drop_reg_n_0_[21] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[22]),
        .Q(\cnt_drop_reg_n_0_[22] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[23]),
        .Q(\cnt_drop_reg_n_0_[23] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[24]),
        .Q(\cnt_drop_reg_n_0_[24] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_drop_reg[24]_i_2 
       (.CI(\cnt_drop_reg[20]_i_2_n_0 ),
        .CO({\cnt_drop_reg[24]_i_2_n_0 ,\cnt_drop_reg[24]_i_2_n_1 ,\cnt_drop_reg[24]_i_2_n_2 ,\cnt_drop_reg[24]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cnt_drop_reg[24]_i_2_n_4 ,\cnt_drop_reg[24]_i_2_n_5 ,\cnt_drop_reg[24]_i_2_n_6 ,\cnt_drop_reg[24]_i_2_n_7 }),
        .S({\cnt_drop_reg_n_0_[24] ,\cnt_drop_reg_n_0_[23] ,\cnt_drop_reg_n_0_[22] ,\cnt_drop_reg_n_0_[21] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[25]),
        .Q(\cnt_drop_reg_n_0_[25] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[26]),
        .Q(\cnt_drop_reg_n_0_[26] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[27]),
        .Q(\cnt_drop_reg_n_0_[27] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[28]),
        .Q(\cnt_drop_reg_n_0_[28] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_drop_reg[28]_i_2 
       (.CI(\cnt_drop_reg[24]_i_2_n_0 ),
        .CO({\cnt_drop_reg[28]_i_2_n_0 ,\cnt_drop_reg[28]_i_2_n_1 ,\cnt_drop_reg[28]_i_2_n_2 ,\cnt_drop_reg[28]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cnt_drop_reg[28]_i_2_n_4 ,\cnt_drop_reg[28]_i_2_n_5 ,\cnt_drop_reg[28]_i_2_n_6 ,\cnt_drop_reg[28]_i_2_n_7 }),
        .S({\cnt_drop_reg_n_0_[28] ,\cnt_drop_reg_n_0_[27] ,\cnt_drop_reg_n_0_[26] ,\cnt_drop_reg_n_0_[25] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[29]),
        .Q(\cnt_drop_reg_n_0_[29] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[2]),
        .Q(\cnt_drop_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[30]),
        .Q(\cnt_drop_reg_n_0_[30] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[31]),
        .Q(\cnt_drop_reg_n_0_[31] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_drop_reg[31]_i_5 
       (.CI(\cnt_drop_reg[28]_i_2_n_0 ),
        .CO({\NLW_cnt_drop_reg[31]_i_5_CO_UNCONNECTED [3:2],\cnt_drop_reg[31]_i_5_n_2 ,\cnt_drop_reg[31]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_cnt_drop_reg[31]_i_5_O_UNCONNECTED [3],\cnt_drop_reg[31]_i_5_n_5 ,\cnt_drop_reg[31]_i_5_n_6 ,\cnt_drop_reg[31]_i_5_n_7 }),
        .S({1'b0,\cnt_drop_reg_n_0_[31] ,\cnt_drop_reg_n_0_[30] ,\cnt_drop_reg_n_0_[29] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[3]),
        .Q(\cnt_drop_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[4]),
        .Q(\cnt_drop_reg_n_0_[4] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_drop_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\cnt_drop_reg[4]_i_2_n_0 ,\cnt_drop_reg[4]_i_2_n_1 ,\cnt_drop_reg[4]_i_2_n_2 ,\cnt_drop_reg[4]_i_2_n_3 }),
        .CYINIT(\cnt_drop_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cnt_drop_reg[4]_i_2_n_4 ,\cnt_drop_reg[4]_i_2_n_5 ,\cnt_drop_reg[4]_i_2_n_6 ,\cnt_drop_reg[4]_i_2_n_7 }),
        .S({\cnt_drop_reg_n_0_[4] ,\cnt_drop_reg_n_0_[3] ,\cnt_drop_reg_n_0_[2] ,\cnt_drop_reg_n_0_[1] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[5]),
        .Q(\cnt_drop_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[6]),
        .Q(\cnt_drop_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[7]),
        .Q(\cnt_drop_reg_n_0_[7] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[8]),
        .Q(\cnt_drop_reg_n_0_[8] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_drop_reg[8]_i_2 
       (.CI(\cnt_drop_reg[4]_i_2_n_0 ),
        .CO({\cnt_drop_reg[8]_i_2_n_0 ,\cnt_drop_reg[8]_i_2_n_1 ,\cnt_drop_reg[8]_i_2_n_2 ,\cnt_drop_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cnt_drop_reg[8]_i_2_n_4 ,\cnt_drop_reg[8]_i_2_n_5 ,\cnt_drop_reg[8]_i_2_n_6 ,\cnt_drop_reg[8]_i_2_n_7 }),
        .S({\cnt_drop_reg_n_0_[8] ,\cnt_drop_reg_n_0_[7] ,\cnt_drop_reg_n_0_[6] ,\cnt_drop_reg_n_0_[5] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_drop_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_drop[9]),
        .Q(\cnt_drop_reg_n_0_[9] ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h00FE)) 
    \cnt_game[0]_i_1 
       (.I0(\cnt_game[31]_i_4_n_0 ),
        .I1(\cnt_game[31]_i_3_n_0 ),
        .I2(\cnt_game[31]_i_2_n_0 ),
        .I3(\cnt_game_reg_n_0_[0] ),
        .O(cnt_game[0]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[10]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[10]),
        .O(cnt_game[10]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[11]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[11]),
        .O(cnt_game[11]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[12]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[12]),
        .O(cnt_game[12]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[13]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[13]),
        .O(cnt_game[13]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[14]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[14]),
        .O(cnt_game[14]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[15]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[15]),
        .O(cnt_game[15]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[16]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[16]),
        .O(cnt_game[16]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[17]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[17]),
        .O(cnt_game[17]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[18]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[18]),
        .O(cnt_game[18]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[19]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[19]),
        .O(cnt_game[19]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[1]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[1]),
        .O(cnt_game[1]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[20]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[20]),
        .O(cnt_game[20]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[21]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[21]),
        .O(cnt_game[21]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[22]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[22]),
        .O(cnt_game[22]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[23]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[23]),
        .O(cnt_game[23]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[24]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[24]),
        .O(cnt_game[24]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[25]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[25]),
        .O(cnt_game[25]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[26]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[26]),
        .O(cnt_game[26]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[27]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[27]),
        .O(cnt_game[27]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[28]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[28]),
        .O(cnt_game[28]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[29]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[29]),
        .O(cnt_game[29]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[2]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[2]),
        .O(cnt_game[2]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[30]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[30]),
        .O(cnt_game[30]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[31]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[31]),
        .O(cnt_game[31]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \cnt_game[31]_i_10 
       (.I0(\cnt_game_reg_n_0_[27] ),
        .I1(\cnt_game_reg_n_0_[26] ),
        .I2(\cnt_game_reg_n_0_[29] ),
        .I3(\cnt_game_reg_n_0_[28] ),
        .O(\cnt_game[31]_i_10_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \cnt_game[31]_i_2 
       (.I0(\cnt_game_reg_n_0_[12] ),
        .I1(\cnt_game_reg_n_0_[13] ),
        .I2(\cnt_game_reg_n_0_[10] ),
        .I3(\cnt_game_reg_n_0_[11] ),
        .I4(\cnt_game[31]_i_6_n_0 ),
        .O(\cnt_game[31]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \cnt_game[31]_i_3 
       (.I0(\cnt_game_reg_n_0_[4] ),
        .I1(\cnt_game_reg_n_0_[5] ),
        .I2(\cnt_game_reg_n_0_[2] ),
        .I3(\cnt_game_reg_n_0_[3] ),
        .I4(\cnt_game[31]_i_7_n_0 ),
        .O(\cnt_game[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \cnt_game[31]_i_4 
       (.I0(\cnt_game[31]_i_8_n_0 ),
        .I1(\cnt_game[31]_i_9_n_0 ),
        .I2(\cnt_game_reg_n_0_[31] ),
        .I3(\cnt_game_reg_n_0_[30] ),
        .I4(\cnt_game_reg_n_0_[1] ),
        .I5(\cnt_game[31]_i_10_n_0 ),
        .O(\cnt_game[31]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFD)) 
    \cnt_game[31]_i_6 
       (.I0(\cnt_game_reg_n_0_[14] ),
        .I1(\cnt_game_reg_n_0_[15] ),
        .I2(\cnt_game_reg_n_0_[17] ),
        .I3(\cnt_game_reg_n_0_[16] ),
        .O(\cnt_game[31]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hDFFF)) 
    \cnt_game[31]_i_7 
       (.I0(\cnt_game_reg_n_0_[6] ),
        .I1(\cnt_game_reg_n_0_[7] ),
        .I2(\cnt_game_reg_n_0_[9] ),
        .I3(\cnt_game_reg_n_0_[8] ),
        .O(\cnt_game[31]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFFD)) 
    \cnt_game[31]_i_8 
       (.I0(\cnt_game_reg_n_0_[22] ),
        .I1(\cnt_game_reg_n_0_[23] ),
        .I2(\cnt_game_reg_n_0_[25] ),
        .I3(\cnt_game_reg_n_0_[24] ),
        .O(\cnt_game[31]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFF7)) 
    \cnt_game[31]_i_9 
       (.I0(\cnt_game_reg_n_0_[19] ),
        .I1(\cnt_game_reg_n_0_[18] ),
        .I2(\cnt_game_reg_n_0_[21] ),
        .I3(\cnt_game_reg_n_0_[20] ),
        .O(\cnt_game[31]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[3]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[3]),
        .O(cnt_game[3]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[4]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[4]),
        .O(cnt_game[4]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[5]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[5]),
        .O(cnt_game[5]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[6]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[6]),
        .O(cnt_game[6]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[7]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[7]),
        .O(cnt_game[7]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[8]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[8]),
        .O(cnt_game[8]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \cnt_game[9]_i_1 
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .I4(data0[9]),
        .O(cnt_game[9]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[0]),
        .Q(\cnt_game_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[10]),
        .Q(\cnt_game_reg_n_0_[10] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[11]),
        .Q(\cnt_game_reg_n_0_[11] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[12]),
        .Q(\cnt_game_reg_n_0_[12] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_game_reg[12]_i_2 
       (.CI(\cnt_game_reg[8]_i_2_n_0 ),
        .CO({\cnt_game_reg[12]_i_2_n_0 ,\cnt_game_reg[12]_i_2_n_1 ,\cnt_game_reg[12]_i_2_n_2 ,\cnt_game_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S({\cnt_game_reg_n_0_[12] ,\cnt_game_reg_n_0_[11] ,\cnt_game_reg_n_0_[10] ,\cnt_game_reg_n_0_[9] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[13]),
        .Q(\cnt_game_reg_n_0_[13] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[14]),
        .Q(\cnt_game_reg_n_0_[14] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[15]),
        .Q(\cnt_game_reg_n_0_[15] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[16]),
        .Q(\cnt_game_reg_n_0_[16] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_game_reg[16]_i_2 
       (.CI(\cnt_game_reg[12]_i_2_n_0 ),
        .CO({\cnt_game_reg[16]_i_2_n_0 ,\cnt_game_reg[16]_i_2_n_1 ,\cnt_game_reg[16]_i_2_n_2 ,\cnt_game_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:13]),
        .S({\cnt_game_reg_n_0_[16] ,\cnt_game_reg_n_0_[15] ,\cnt_game_reg_n_0_[14] ,\cnt_game_reg_n_0_[13] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[17]),
        .Q(\cnt_game_reg_n_0_[17] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[18]),
        .Q(\cnt_game_reg_n_0_[18] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[19]),
        .Q(\cnt_game_reg_n_0_[19] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[1]),
        .Q(\cnt_game_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[20]),
        .Q(\cnt_game_reg_n_0_[20] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_game_reg[20]_i_2 
       (.CI(\cnt_game_reg[16]_i_2_n_0 ),
        .CO({\cnt_game_reg[20]_i_2_n_0 ,\cnt_game_reg[20]_i_2_n_1 ,\cnt_game_reg[20]_i_2_n_2 ,\cnt_game_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[20:17]),
        .S({\cnt_game_reg_n_0_[20] ,\cnt_game_reg_n_0_[19] ,\cnt_game_reg_n_0_[18] ,\cnt_game_reg_n_0_[17] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[21]),
        .Q(\cnt_game_reg_n_0_[21] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[22]),
        .Q(\cnt_game_reg_n_0_[22] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[23]),
        .Q(\cnt_game_reg_n_0_[23] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[24]),
        .Q(\cnt_game_reg_n_0_[24] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_game_reg[24]_i_2 
       (.CI(\cnt_game_reg[20]_i_2_n_0 ),
        .CO({\cnt_game_reg[24]_i_2_n_0 ,\cnt_game_reg[24]_i_2_n_1 ,\cnt_game_reg[24]_i_2_n_2 ,\cnt_game_reg[24]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[24:21]),
        .S({\cnt_game_reg_n_0_[24] ,\cnt_game_reg_n_0_[23] ,\cnt_game_reg_n_0_[22] ,\cnt_game_reg_n_0_[21] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[25]),
        .Q(\cnt_game_reg_n_0_[25] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[26]),
        .Q(\cnt_game_reg_n_0_[26] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[27]),
        .Q(\cnt_game_reg_n_0_[27] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[28]),
        .Q(\cnt_game_reg_n_0_[28] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_game_reg[28]_i_2 
       (.CI(\cnt_game_reg[24]_i_2_n_0 ),
        .CO({\cnt_game_reg[28]_i_2_n_0 ,\cnt_game_reg[28]_i_2_n_1 ,\cnt_game_reg[28]_i_2_n_2 ,\cnt_game_reg[28]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[28:25]),
        .S({\cnt_game_reg_n_0_[28] ,\cnt_game_reg_n_0_[27] ,\cnt_game_reg_n_0_[26] ,\cnt_game_reg_n_0_[25] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[29]),
        .Q(\cnt_game_reg_n_0_[29] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[2]),
        .Q(\cnt_game_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[30]),
        .Q(\cnt_game_reg_n_0_[30] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[31]),
        .Q(\cnt_game_reg_n_0_[31] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_game_reg[31]_i_5 
       (.CI(\cnt_game_reg[28]_i_2_n_0 ),
        .CO({\NLW_cnt_game_reg[31]_i_5_CO_UNCONNECTED [3:2],\cnt_game_reg[31]_i_5_n_2 ,\cnt_game_reg[31]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_cnt_game_reg[31]_i_5_O_UNCONNECTED [3],data0[31:29]}),
        .S({1'b0,\cnt_game_reg_n_0_[31] ,\cnt_game_reg_n_0_[30] ,\cnt_game_reg_n_0_[29] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[3]),
        .Q(\cnt_game_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[4]),
        .Q(\cnt_game_reg_n_0_[4] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_game_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\cnt_game_reg[4]_i_2_n_0 ,\cnt_game_reg[4]_i_2_n_1 ,\cnt_game_reg[4]_i_2_n_2 ,\cnt_game_reg[4]_i_2_n_3 }),
        .CYINIT(\cnt_game_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S({\cnt_game_reg_n_0_[4] ,\cnt_game_reg_n_0_[3] ,\cnt_game_reg_n_0_[2] ,\cnt_game_reg_n_0_[1] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[5]),
        .Q(\cnt_game_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[6]),
        .Q(\cnt_game_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[7]),
        .Q(\cnt_game_reg_n_0_[7] ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[8]),
        .Q(\cnt_game_reg_n_0_[8] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cnt_game_reg[8]_i_2 
       (.CI(\cnt_game_reg[4]_i_2_n_0 ),
        .CO({\cnt_game_reg[8]_i_2_n_0 ,\cnt_game_reg[8]_i_2_n_1 ,\cnt_game_reg[8]_i_2_n_2 ,\cnt_game_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S({\cnt_game_reg_n_0_[8] ,\cnt_game_reg_n_0_[7] ,\cnt_game_reg_n_0_[6] ,\cnt_game_reg_n_0_[5] }));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_game_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(cnt_game[9]),
        .Q(\cnt_game_reg_n_0_[9] ));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
  OBUF tick_drop_OBUF_inst
       (.I(tick_drop_OBUF),
        .O(tick_drop));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    tick_drop_i_1
       (.I0(\cnt_drop_reg_n_0_[0] ),
        .I1(\cnt_drop[31]_i_2_n_0 ),
        .I2(\cnt_drop[31]_i_3_n_0 ),
        .I3(\cnt_drop[31]_i_4_n_0 ),
        .O(tick_drop_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    tick_drop_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(tick_drop_i_1_n_0),
        .Q(tick_drop_OBUF));
  OBUF tick_game_OBUF_inst
       (.I(tick_game_OBUF),
        .O(tick_game));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    tick_game_i_1
       (.I0(\cnt_game_reg_n_0_[0] ),
        .I1(\cnt_game[31]_i_2_n_0 ),
        .I2(\cnt_game[31]_i_3_n_0 ),
        .I3(\cnt_game[31]_i_4_n_0 ),
        .O(tick_game_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    tick_game_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(reset_IBUF),
        .D(tick_game_i_1_n_0),
        .Q(tick_game_OBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
