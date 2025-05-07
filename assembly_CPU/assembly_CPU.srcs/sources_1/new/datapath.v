`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 14:21:54
// Design Name: 
// Module Name: datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath(
input clk,
input reset
    );
    wire branch;
    wire jump;
    wire [63:0]buff_Fe;
    wire [31:0]pc;
    wire [31:0]pcf; 
        wire flushE;
          wire StallF;
     wire StallD;
    pc_buff buff_pc(clk,reset,pc,StallF,pcf);
    
    r_instruction read_in(clk,pcf,StallD,buff_Fe);

     wire [31:0]result;
     wire forwordAD;
     wire forwordBD;
     wire  [4:0]D_reg;
     wire regwrite;
     wire [31:0]datatoreg;
     wire [118:0]buff_de;
     wire [4:0]regwriteE;
     Decode DECODE(clk,reset,buff_Fe,result,forwordAD,forwordBD,D_reg,regwrite,datatoreg,flushE,buff_de,pc,branch,jump);
     
     wire [1:0]forwordAE;
     wire [1:0]forwordBE;
     wire [71:0]buff_ex;
     Execute EXECUTE(clk,reset,buff_de,forwordAE,forwordBE,result,datatoreg,regwriteE,buff_ex);
     
     wire [70:0]buff_me;
     Memory MEMORY(clk,reset,buff_ex,buff_me,result);
     
     Writeback writeback(clk,reset, buff_me,datatoreg, regwrite, D_reg);
     
   
     Hazard  HAZARDUnit(buff_Fe[57:53],buff_Fe[52:48],buff_de[46:42],buff_de[41:37],regwriteE,buff_ex[4:0],buff_me[4:0],buff_de[118],buff_ex[71],buff_me[70],branch,jump,buff_de[117:117],
     forwordAD,forwordBD,forwordAE,forwordBE,StallF, StallD,flushE);
     
     
     
endmodule
