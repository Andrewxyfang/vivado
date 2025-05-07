`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 18:29:22
// Design Name: 
// Module Name: td
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


module td();
	reg clk;
	reg rst;
	
	wire[31:0] writedata,dataadr;
	wire memwrite;
	topone dut(clk,rst);

	initial begin 
		rst <= 1;
		#92;
		rst <= 0;
	end

	always begin
		clk <= 1;
		#10;
		clk <= 0;
		#10;
	
	end
	
  
	always @(negedge clk) begin
		if(memwrite) begin
			/* code */
			if(dataadr === 84 & writedata === 7) begin
				/* code */
				$display("Simulation succeeded");
				$stop;
			end else if(dataadr !== 80) begin
				/* code */
				$display("Simulation Failed");
				$stop;
			end
			
		end
	end
endmodule
