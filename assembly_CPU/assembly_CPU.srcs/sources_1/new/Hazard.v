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
    input wire [4:0] rsD,        // Decode阶段的源寄存器1
    input wire [4:0] rtD,        // Decode阶段的源寄存器2
    input wire [4:0] rsE,        // Execute阶段的源寄存器1
    input wire [4:0] rtE,        // Execute阶段的源寄存器2
    input wire [4:0] WriteRegE,  // Execute阶段的写寄存器
    input wire [4:0] WriteRegM,  // Memory阶段的写寄存器
    input wire [4:0] WriteRegW,  // Writeback阶段的写寄存器
    input wire RegWriteE,        // Execute阶段的写使能
    input wire RegWriteM,        // Memory阶段的写使能
    input wire RegWriteW,        // Writeback阶段的写使能
    input wire Branch,           // 分支指令（Decode阶段）
    input wire jump,
    input wire memtoregE,        // Execute阶段的指令是否为load（memtoreg）
    output reg ForwardAD,        // 前递Decode阶段rsD的数据
    output reg ForwardBD,        // 前递Decode阶段rtD的数据
    output reg [1:0] ForwardAE,  // Execute阶段rsE的前递控制
    output reg [1:0] ForwardBE,  // Execute阶段rtE的前递控制
    output reg StallF,           // 暂停取指
    output reg StallD,           // 暂停译码
    output reg flushE            // 清空Execute阶段
);

    // 处理Execute阶段操作数前递
    always @(*) begin
        // ForwardAE逻辑：优先级MEM > WB
        if (RegWriteM && (WriteRegM != 0) && (WriteRegM == rsE)) begin
            ForwardAE = 2'b10; // 前递MEM阶段数据
        end else if (RegWriteW && (WriteRegW != 0) && (WriteRegW == rsE)) begin
            ForwardAE = 2'b01; // 前递WB阶段数据
        end else begin
            ForwardAE = 2'b00; // 无前递
        end

        // ForwardBE逻辑：同上
        if (RegWriteM && (WriteRegM != 0) && (WriteRegM == rtE)) begin
            ForwardBE = 2'b10;
        end else if (RegWriteW && (WriteRegW != 0) && (WriteRegW == rtE)) begin
            ForwardBE = 2'b01;
        end else begin
            ForwardBE = 2'b00;
        end

        // ForwardAD/BD逻辑：分支指令前递MEM阶段数据到Decode阶段
        ForwardAD = (Branch && RegWriteM && (WriteRegM == rsD));
        ForwardBD = (Branch && RegWriteM && (WriteRegM == rtD));
    end

    // 处理Load-Use冒险和分支冒险
    always @(*) begin
        // 默认无停顿和刷新
        StallF = 0;
        StallD = 0;
        flushE = 0;

        // Load-Use冒险检测：EX阶段是load且目标寄存器与D阶段的源寄存器冲突
        if (memtoregE && (WriteRegE == rsD || WriteRegE == rtD)) begin
            StallF = 1; // 暂停取指
            StallD = 1; // 暂停译码
            flushE = 1; // 清空EX阶段（插入气泡）
        end
        // 分支冒险检测：分支指令依赖EX阶段的ALU结果或未完成的数据
        else if (Branch) begin
            // 若分支依赖EX阶段的写寄存器且无法前递（如ALU指令）
            if (RegWriteE && (WriteRegE == rsD || WriteRegE == rtD)) begin
                StallF = 1;
                StallD = 1;
                flushE = 1;
            end
            // 若分支依赖MEM阶段的数据，可通过前递解决，无需停顿
        end
//        else if(jump)begin
//             StallF = 1;
//              StallD = 1;
//              flushE = 1;
//           end
    end

endmodule