`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 12:10:54
// Design Name: 
// Module Name: topone
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


module topone(
    input clk,
    input reset,
     output wire[31:0] dataw,
    output wire[31:0] dataadr,
    output wire memwrite,
    output  wire [31:0]instruction
    );
 
    datapath path(clk,reset);
    



endmodule