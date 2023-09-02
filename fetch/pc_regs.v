`include "ins_addrtruction.vh"

// PC寄存器模块
module pc_reg(

    input wire clk,
    input wire rst,
    input wire clr,
    input wire jump_en,                 // 跳转标志
    input wire[31:0] jump_addr,   // 跳转地址
    input wire hold_en, // 流水线暂停标志

    output reg[31:0] ins_addr           // PC指针

    );


    always @ (posedge clk) begin
        // 复位
        if (rst || clr) begin
            ins_addr <= 32'd0;
        // 跳转
        end else if (jump_en) begin
            ins_addr <= jump_addr;
        // 暂停
        end else if (hold_en) begin
            ins_addr <= ins_addr;
        // 地址加4
        end else begin
            ins_addr <= ins_addr + 32'd4;
        end
    end

endmodule
