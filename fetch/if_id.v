`include "instruction.vh"

// 将指令向译码模块传递
module if_id(

    input wire clk,
    input wire rst,

    input wire[31:0] ins,            // 指令内容
    input wire[31:0] ins_addr,   // 指令地址

    input wire hold_en, // 流水线暂停标志

    output wire[31:0] ins_o,           // 指令内容
    output wire[31:0] ins_addr_o   // 指令地址

    );


    // 还需要根据ins_addr去访问指令寄存器得到指令tmp_ins的相关代码
    //————————————————————






    //————————————————————

    wire[31:0] tmp_ins;
    gen_pipe_dff #(32) inst_ff(clk, rst, hold_en, I_NOP, ins, tmp_ins);
    assign ins_o = tmp_ins;

    wire[31:0] tmp_ins_addr;
    gen_pipe_dff #(32) inst_addr_ff(clk, rst, hold_en, 32'b0, ins_addr, tmp_ins_addr);
    assign ins_addr_o = tmp_ins_addr;

endmodule
