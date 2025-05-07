`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 18:17:17
// Design Name: 
// Module Name: my_pc
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


module mypc(
input wire clk,
input wire reset,
input wire [31:0]pc_need,
output  wire [31:0]pc
    );
    
     assign pc = pc_need;

endmodule
