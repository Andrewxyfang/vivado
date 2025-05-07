`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 15:21:19
// Design Name: 
// Module Name: Memory
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


module Memory(
input clk,
input reset,
input [71:0]buff,


output reg [70:0]buff_me,
output  wire [31:0] cal_out
    );
    
    wire regwrite;
    wire memtoreg;
    wire memwrite;
   
    wire [31:0] num2;
    wire [4:0] D_reg;

    // ½âÎö buff ÐÅºÅ
    assign regwrite = buff[71];
    assign memtoreg = buff[70];
    assign memwrite = buff[69];
    assign cal_out = buff[68:37];
    assign num2 = buff[36:5];
    assign D_reg = buff[4:0];
    
    wire [31:0]memorydata;
     blk_mem_gen_1 memoryop(
        .clka(clk),  // Input clock
        .wea(memwrite),    // Enable data read
        .addra(cal_out),
        .dina(num2),    
        .douta(memorydata),
        .rsta(reset)
    );
    always@(negedge clk)begin
      buff_me<={regwrite,memtoreg,memorydata,cal_out,D_reg};
    end
endmodule
