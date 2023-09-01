`include "instruction.vh"

// 将指令向译码模块传递
module if_id(

    input wire clk,
    input wire rst,

    input wire[31:0] inst_i,            // 指令内容
    input wire[31:0] inst_addr_i,   // 指令地址

    input wire hold_en, // 流水线暂停标志

    output wire[31:0] inst_o,           // 指令内容
    output wire[31:0] inst_addr_o   // 指令地址

    );

    wire[31:0] inst;
    gen_pipe_dff #(32) inst_ff(clk, rst, hold_en, I_NOP, inst_i, inst);
    assign inst_o = inst;

    wire[31:0] inst_addr;
    gen_pipe_dff #(32) inst_addr_ff(clk, rst, hold_en, 32'b0, inst_addr_i, inst_addr);
    assign inst_addr_o = inst_addr;

endmodule
