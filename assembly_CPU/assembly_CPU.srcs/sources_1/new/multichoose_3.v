`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 14:53:13
// Design Name: 
// Module Name: multichoose_3
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


module multichoose_3(
input [31:0]num1,
input [31:0]num2,
input [31:0]num3,
input [1:0]op,
output wire [31:0]num
    );
  assign num = (op == 2'b00)? num1 :
                 (op == 2'b01)? num2 :
                 (op == 2'b10)? num3 : 32'b0;

endmodule
