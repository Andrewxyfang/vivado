`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 16:54:01
// Design Name: 
// Module Name: Writeback
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


module Writeback(
    input clk,
    input reset,
    input [70:0] buff,
    output wire [31:0]datatoreg,
    output wire regwrite,
    output wire [4:0] D_reg
);


    wire memtoreg;
    wire [31:0] memorydata;
    wire [31:0] cal_out;


    // ½âÎö buff ÐÅºÅ
    assign regwrite = buff[70];
    assign memtoreg = buff[69];
    assign memorydata = buff[68:37];
    assign cal_out = buff[36:5];
    assign D_reg = buff[4:0];
    
    
    multichose data_to_reg(cal_out,memorydata,memtoreg,datatoreg);
    
endmodule
