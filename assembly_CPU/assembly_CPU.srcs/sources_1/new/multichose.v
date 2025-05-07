`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/20 10:47:49
// Design Name: 
// Module Name: multichose
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


module multichose(
input [31:0]num1,
input [31:0]num2,
input [0:0]choose,
output wire [31:0]num
    );
    assign num = (choose == 0)? num1 : num2;
endmodule