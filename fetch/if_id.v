`include "instruction.vh"

// 将指令向译码模块传递
module if_id(

    input wire clk,
    input wire rst,

    input wire[31:0] ins_i,            // 指令内容
    input wire[31:0] ins_addr_i,   // 指令地址

    input wire hold_en, // 流水线暂停标志

    output wire[31:0] ins_o,           // 指令内容
    output wire[31:0] ins_addr_o   // 指令地址
    );

    wire [31:0] tmp_ins;
    always @ (posedge clk) begin
        if(!rst | hold_en) begin
            tmp_ins <= `I_NOP;
        end else begin
            tmp_ins <= ins_i;
        end
    end
    assign ins_o = tmp_ins;

    wire [31:0] tmp_ins_addr;
    always @ (posedge clk) begin
        if(!rst | hold_en) begin
            tmp_ins_addr <= 32'd0;
        end else begin
            tmp_ins_addr <= ins_addr_i;
        end
    end
    assign ins_addr_o = tmp_ins_addr;

endmodule
