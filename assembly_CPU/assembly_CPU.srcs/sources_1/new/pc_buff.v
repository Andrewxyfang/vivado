`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 12:24:50
// Design Name: 
// Module Name: pc_buff
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


module pc_buff(
   input clk,
   input reset,
   input  wire [31:0]pc,
   input StallF,
   output reg [31:0]pcf
    );
    reg [31:0]pcf1;
    always@(posedge clk)begin
    if(reset)begin pcf=31'b0;end
    else if(!StallF) begin
     pcf=pc;
    end
    end
endmodule
