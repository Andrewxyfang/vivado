`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/05 17:14:18
// Design Name: 
// Module Name: Hazard
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

module Hazard(
    input wire [4:0] rsD,        // Decode�׶ε�Դ�Ĵ���1
    input wire [4:0] rtD,        // Decode�׶ε�Դ�Ĵ���2
    input wire [4:0] rsE,        // Execute�׶ε�Դ�Ĵ���1
    input wire [4:0] rtE,        // Execute�׶ε�Դ�Ĵ���2
    input wire [4:0] WriteRegE,  // Execute�׶ε�д�Ĵ���
    input wire [4:0] WriteRegM,  // Memory�׶ε�д�Ĵ���
    input wire [4:0] WriteRegW,  // Writeback�׶ε�д�Ĵ���
    input wire RegWriteE,        // Execute�׶ε�дʹ��
    input wire RegWriteM,        // Memory�׶ε�дʹ��
    input wire RegWriteW,        // Writeback�׶ε�дʹ��
    input wire Branch,           // ��ָ֧�Decode�׶Σ�
    input wire jump,
    input wire memtoregE,        // Execute�׶ε�ָ���Ƿ�Ϊload��memtoreg��
    output reg ForwardAD,        // ǰ��Decode�׶�rsD������
    output reg ForwardBD,        // ǰ��Decode�׶�rtD������
    output reg [1:0] ForwardAE,  // Execute�׶�rsE��ǰ�ݿ���
    output reg [1:0] ForwardBE,  // Execute�׶�rtE��ǰ�ݿ���
    output reg StallF,           // ��ͣȡָ
    output reg StallD,           // ��ͣ����
    output reg flushE            // ���Execute�׶�
);

    // ����Execute�׶β�����ǰ��
    always @(*) begin
        // ForwardAE�߼������ȼ�MEM > WB
        if (RegWriteM && (WriteRegM != 0) && (WriteRegM == rsE)) begin
            ForwardAE = 2'b10; // ǰ��MEM�׶�����
        end else if (RegWriteW && (WriteRegW != 0) && (WriteRegW == rsE)) begin
            ForwardAE = 2'b01; // ǰ��WB�׶�����
        end else begin
            ForwardAE = 2'b00; // ��ǰ��
        end

        // ForwardBE�߼���ͬ��
        if (RegWriteM && (WriteRegM != 0) && (WriteRegM == rtE)) begin
            ForwardBE = 2'b10;
        end else if (RegWriteW && (WriteRegW != 0) && (WriteRegW == rtE)) begin
            ForwardBE = 2'b01;
        end else begin
            ForwardBE = 2'b00;
        end

        // ForwardAD/BD�߼�����ָ֧��ǰ��MEM�׶����ݵ�Decode�׶�
        ForwardAD = (Branch && RegWriteM && (WriteRegM == rsD));
        ForwardBD = (Branch && RegWriteM && (WriteRegM == rtD));
    end

    // ����Load-Useð�պͷ�֧ð��
    always @(*) begin
        // Ĭ����ͣ�ٺ�ˢ��
        StallF = 0;
        StallD = 0;
        flushE = 0;

        // Load-Useð�ռ�⣺EX�׶���load��Ŀ��Ĵ�����D�׶ε�Դ�Ĵ�����ͻ
        if (memtoregE && (WriteRegE == rsD || WriteRegE == rtD)) begin
            StallF = 1; // ��ͣȡָ
            StallD = 1; // ��ͣ����
            flushE = 1; // ���EX�׶Σ��������ݣ�
        end
        // ��֧ð�ռ�⣺��ָ֧������EX�׶ε�ALU�����δ��ɵ�����
        else if (Branch) begin
            // ����֧����EX�׶ε�д�Ĵ������޷�ǰ�ݣ���ALUָ�
            if (RegWriteE && (WriteRegE == rsD || WriteRegE == rtD)) begin
                StallF = 1;
                StallD = 1;
                flushE = 1;
            end
            // ����֧����MEM�׶ε����ݣ���ͨ��ǰ�ݽ��������ͣ��
        end
//        else if(jump)begin
//             StallF = 1;
//              StallD = 1;
//              flushE = 1;
//           end
    end

endmodule