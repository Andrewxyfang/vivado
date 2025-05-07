`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 18:18:30
// Design Name: 
// Module Name: controler
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


module controler(
    input reset, 
    input [5:0] op,
    output reg regdst,
    output reg jump,
    output reg branch,
    output reg memread,
    output reg memtoreg,
    output reg [1:0]aluop,
    output reg memwrite,
    output reg alusrc,
    output reg regwrite
);
//always@(reset)
//begin
  //if(reset)
 // begin
 //           regdst=0;
 //           jump=0;
 //           branch = 0;
 //           memread = 0;
 //           memtoreg = 0;
  //          aluop = 0;
  //          memwrite = 0;
  //          alusrc = 0;
  //          regwrite = 0;
  // end
 // end

always @(op)
    begin
    case (op)
        6'b000010: begin // j（无条件跳转）
           regdst=0;
           jump=1;
            branch = 0;
            memread = 0;
            memtoreg = 0;
            aluop = 0;
            memwrite = 0;
            alusrc = 0;
            regwrite = 0;
        end
        6'b000100: begin // beq（相等时分支跳转）
            regdst=0;
            jump=0;
            branch = 1;
            memread = 0;
            memtoreg = 0;
            aluop = 2'b01; // 需要进行比较操作
            memwrite = 0;
            alusrc = 0;
            regwrite = 0;
        end
        6'b001000: begin // addi（立即数加法）
            regdst=0;
            jump=0;
            branch = 0;
            memread = 0;
            memtoreg = 0;
            aluop = 2'b00;
            memwrite = 0;
            alusrc = 1; // 立即数作为ALU输入
            regwrite = 1; // 需要写回寄存器
        end
        6'b101011: begin // sw指令
            regdst=0;
            jump=0;
            branch = 0;
            memread = 0;
            memtoreg = 0;
            aluop = 2'b00; // 需要根据功能码进一步确定ALU操作
            memwrite = 1;
            alusrc = 1;
            regwrite = 0; 
        end
         6'b100011: begin // lw指令
            regdst=0;
            jump=0;
            branch = 0;
            memread = 1;
            memtoreg = 1;
            aluop = 2'b00; // 需要根据功能码进一步确定ALU操作
            memwrite = 0;
            alusrc = 1;
            regwrite = 1; 
        end
        6'b000000: begin // R型指令
            regdst=1;
            jump=0;
            branch = 0;
            memread = 0;
            memtoreg = 0;
            aluop = 2'b10; // 需要根据功能码进一步确定ALU操作
            memwrite = 0;
            alusrc = 0;
            regwrite = 1; // 需要写回寄存器
        end
        default: begin
            regdst=0;
            jump=0;
            branch = 0;
            memread = 0;
            memtoreg = 0;
            aluop = 0;
            memwrite = 0;
            alusrc = 0;
            regwrite = 0;
        end
    endcase
end

endmodule 
