`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 13:07:43
// Design Name: 
// Module Name: r_instruction
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


module r_instruction(
   input clk,
   input wire [31:0]pcf,
   input wire StallD,
   output reg [63:0]buff
    );
        reg [31:0]pcplus4f;
        wire [31:0]instruction;
        reg [63:0]buff1;
        
     instructionROM readinstruct(
    .clka(clk),
    .addra(pcf),
    .douta(instruction)
   );
       
       always@(negedge clk)begin   
       if(StallD)begin
       buff=buff-4;
       end
       else begin
         pcplus4f=pcf+4;
         buff={instruction,pcplus4f};   
         buff1=buff;
        end
       end
endmodule
