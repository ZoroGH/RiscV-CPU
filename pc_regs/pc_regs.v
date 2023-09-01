`include "instruction.vh"

// PC寄存器模块
module pc_reg(

    input wire clk,
    input wire rst,

    input wire jump_flag_i,                 // 跳转标志
    input wire[31:0] jump_addr_i,   // 跳转地址
    input wire hold_flag_i, // 流水线暂停标志
    input wire fetch_flag_i;
    input wire jtag_reset_flag_i,           // 复位标志

    output reg[31:0] pc_o           // PC指针

    );


    always @ (posedge clk) begin
        // 复位
        if (rst) begin
            pc_o <= 32'd0;
        // 跳转
        end else if (jump_flag_i) begin
            pc_o <= jump_addr_i;
        // 暂停
        end else if (hold_flag_i) begin
            pc_o <= pc_o;
        // 地址加4
        end else if (fetch_flag_i) begin
            pc_o <= pc_o + 32'd4;
        end
    end

endmodule
