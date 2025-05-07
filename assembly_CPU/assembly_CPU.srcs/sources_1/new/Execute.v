`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 14:24:47
// Design Name: 
// Module Name: Execute
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


module Execute(
input clk,
input reset,
input wire [118:0]buff,

input [1:0]forwordAE,
input [1:0]forwordBE,
input [31:0]result,
input [31:0]datatoreg,
output [4:0] D_reg,
output reg [71:0]buff_ex
    );
    
    wire regwrite;
    wire memtoreg;
    wire memwrite;
    wire [2:0] ALUcontrolID;
    wire alusrc;
    wire regdst;
    wire [31:0] num1, num2, reg2, immed_ex;
    wire [4:0]  rs, rt, rd;

    // 信号赋值
    assign regwrite = buff[118:118];
    assign memtoreg = buff[117:117];
    assign memwrite = buff[116:116];
    assign ALUcontrolID = buff[115:113];
    assign alusrc = buff[112:112];
    assign regdst = buff[111:111];
    assign num1 = buff[110:79];
    assign reg2 = buff[78:47];
    assign rs = buff[46:42];
    assign rt = buff[41:37];
    assign rd = buff[36:32];
    assign immed_ex = buff[31:0];
    
    //计算数据选择与计算
    wire [31:0]data1,data2,cal_out;
    wire zero;
    multichoose_3 forwordAE_one(num1,datatoreg,result,forwordAE,data1);
    multichoose_3 forwordBE_one(reg2,datatoreg,result,forwordBE,num2);
    //数据选择，是寄存器的数据还是立即数
    multichose reg_or_im(num2,immed_ex,alusrc,data2);
    ALU_cal calculate(ALUcontrolID,data1,data2,cal_out,zero);
    
    //寄存器选择
    multichose which_reg(rt,rd,regdst,D_reg);
    
    //设置缓冲区
   always@(negedge clk or posedge reset)begin
            buff_ex <= {regwrite,memtoreg,memwrite,cal_out,num2,D_reg};
    end


    
  
endmodule
