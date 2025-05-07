// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Tue May  6 10:32:26 2025
// Host        : LAPTOP-5TDS493D running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/vivado/vr_code/assembly_CPU/assembly_CPU.srcs/sources_1/ip/instructionROM_1/instructionROM_stub.v
// Design      : instructionROM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2019.2" *)
module instructionROM(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[31:0],douta[31:0]" */;
  input clka;
  input [31:0]addra;
  output [31:0]douta;
endmodule
