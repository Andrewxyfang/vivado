`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/20 09:55:21
// Design Name: 
// Module Name: ALU_cal
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


module ALU_cal(
    input [2:0] op,
    input [31:0] num1,
    input [31:0] num2,
    output [31:0] result,
    output zero
);

// º∆À„ result
assign result = (op == 3'b000)? num1 + num2 :
                (op == 3'b001)? num1 - num2 :
                (op == 3'b010)? num1 & num2 :
                (op == 3'b011)? num1 | num2 :
                (op == 3'b100)? (num1 < num2)?1:0 :
                (op == 3'b111)? num1 >> num2 :
                32'b0;

// º∆À„ zero
assign zero = (result == 0)? 1'b1 : 1'b0;

endmodule 