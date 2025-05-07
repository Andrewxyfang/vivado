`timescale 1ns / 1ps

module regfile(
	input wire clk,
	input wire we3, //写使能信号
	input wire[4:0] ra1,ra2,wa3, // 两个读寄存器的编号，和一个写寄存器的编号
	//都是五位信号，因为有32个寄存器
	input wire[31:0] wd3,  //写的数据
	output wire[31:0] rd1,rd2 //读寄存器中的数据
    );

	reg [31:0] rf[31:0];  //32*32阵列

	always @(posedge clk) begin
		if(we3) begin
			 rf[wa3] = wd3;   //将编号为wa3的寄存器选中，并将wd3数据读入寄存器
		end
	end

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;  //保持0寄存器始终为0
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule