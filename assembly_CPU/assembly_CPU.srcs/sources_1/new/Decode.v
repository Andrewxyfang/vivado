`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 13:21:39
// Design Name: 
// Module Name: Decode
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


module Decode(
input clk,
input reset,
input [63:0]buff_pc,

input [31:0]result,
input forwordAD,
input forwordBD,

input  [4:0]D_reg,
input regw,
input wire [31:0]toreg,
input flushE,
output reg [118:0]buff_de,
output [31:0]pc,
output wire branch,
output wire jump
    );
   
    //解析buff
    wire [31:0]instruction;
    wire [31:0] pc_add;
    assign instruction=buff_pc[63:32];
    assign  pc_add=buff_pc[31:0];
    
    wire [2:0]ALUcontrolID;
    wire memwrite;
    wire regdst;
    
    
    wire memread;
    wire memtoreg;
    wire [1:0]aluop;
    wire alusrc;
    wire regwrite;
     wire  [5:0]op;
    assign op   = instruction[31:26];
    controler control(
    reset,
    op,
    regdst,
    jump,
    branch,
    memread,
    memtoreg,
    aluop,
    memwrite,
    alusrc,
    regwrite
    );
    
    //解码
    wire [31:0]num1,num2,reg2,immed_ex,memorydata;
    wire [15:0]immed;
    wire [5:0]  fun;
    wire [4:0]  rs, rt,rd;
    assign fun  = instruction[5:0];
    assign rs   = instruction[25:21];
    assign rt   = instruction[20:16];
    assign rd   = instruction[15:11];
    assign immed = instruction[15:0];
      //符号扩展
    extend extendsum(immed,immed_ex);
    //读寄存器
    regfile regheap(clk,regw,rs,rt,D_reg,toreg,num1,reg2);
    //pc变换
    wire [31:0]pc_jump;
    wire [31:0]pc_beq;
    wire [31:0]pc_beq_add;
    wire [31:0]pc_need;
    wire zero;
    wire [31:0]data1,data2;
    assign data1=(forwordAD==0)?num1:result;
    assign data2=(forwordBD==0)?reg2:result;
    assign zero=(data1==data2)?1:0;
    
    assign pc_jump={pc_add[31:28],instruction[25:0],2'b00};
    //beq条件跳转
    assign pc_beq=pc_add+{immed_ex[29:0],2'b00};
    //地址选择
    multichose beg_or_add(pc_add ,pc_beq ,branch && zero ,pc_beq_add);
    multichose begadd_or_jump(pc_beq_add,pc_jump,jump ,pc_need);
    //地址选择
    mypc add_pc(clk,reset,pc_need,pc);
    
    //ALU控制信号
      alu_con alu_control(aluop,fun,ALUcontrolID);
      
      always@(negedge clk)begin
      if(reset||flushE||jump)begin buff_de<=119'b0;end
      else begin
        buff_de = {regwrite, memtoreg, memwrite, ALUcontrolID, alusrc, regdst,num1, reg2,rs, rt, rd,immed_ex};
       end
     end
endmodule
