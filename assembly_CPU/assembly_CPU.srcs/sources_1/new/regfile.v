`timescale 1ns / 1ps

module regfile(
	input wire clk,
	input wire we3, //дʹ���ź�
	input wire[4:0] ra1,ra2,wa3, // �������Ĵ����ı�ţ���һ��д�Ĵ����ı��
	//������λ�źţ���Ϊ��32���Ĵ���
	input wire[31:0] wd3,  //д������
	output wire[31:0] rd1,rd2 //���Ĵ����е�����
    );

	reg [31:0] rf[31:0];  //32*32����

	always @(posedge clk) begin
		if(we3) begin
			 rf[wa3] = wd3;   //�����Ϊwa3�ļĴ���ѡ�У�����wd3���ݶ���Ĵ���
		end
	end

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;  //����0�Ĵ���ʼ��Ϊ0
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule