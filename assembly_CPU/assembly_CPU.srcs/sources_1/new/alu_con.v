`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/20 10:42:09
// Design Name: 
// Module Name: alu_con
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

module alu_con(
    input [1:0] aluop,
    input [5:0] func,
    output reg [2:0] cal
);

always @(*) begin
    case (aluop)  
        2'b00: cal = 3'b000; 
        2'b01: cal = 3'b001;
        2'b10: begin
            case (func)
                6'b100000: cal = 3'b000; // add
                6'b100010: cal = 3'b001; // sub
                6'b100100: cal = 3'b010; // and
                6'b100101: cal = 3'b011; // or
                6'b101010: cal = 3'b100;
                default: cal = 3'b111;
            endcase
        end
        default: cal = 3'b111;
    endcase
end

endmodule    
