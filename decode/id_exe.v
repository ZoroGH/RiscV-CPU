`include "instruction.vh"

module id_exe(
    input wire clk,
    input wire rst,

    input [31:0] ins_i,       // 指令内容
    input [31:0] ins_addr_i,  // 指令地址

    input [4:0] op_type_i,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] offset_i,
    input [31:0] immediate_i,

    input hold_en,           // 流水线暂停标志

    output [31:0] ins_addr_o, // 指令地址

    output [4:0] op_type_o,
    output [31:0] data1,
    output [31:0] data2,
    output [31:0] offset_o,
    output [31:0] immediate_o,
);

    wire [5:0] op_type = op_type_i;
    op_type_o = op_type;


    wire [31:0] tmp_ins_addr;
    always @ (posedge clk) begin
        if(!rst | hold_en) begin
            tmp_ins_addr <= 32'd0;
        end else begin
            tmp_ins_addr <= ins_addr_i;
        end
    end
    assign ins_addr_o = tmp_ins_addr;

    wire [4:0] tmp_rs1;
    always @ (posedge clk) begin
        if(!rst | hold_en) begin
            tmp_rs1 <= 5'd0;
        end else begin
            tmp_rs1 <= rs1;
        end
    end
    assign rs1 = tmp_rs1;

    wire [4:0] tmp_rs2;
    always @ (posedge clk) begin
        if(!rst | hold_en) begin
            tmp_rs2 <= 5'd0;
        end else begin
            tmp_rs2 <= rs2;
        end
    end
    assign rs2 = tmp_rs2;

    wire [4:0] tmp_rd;
    always @ (posedge clk) begin
        if(!rst | hold_en) begin
            tmp_rd <= 5'd0;
        end else begin
            tmp_rd <= rd;
        end
    end
    assign rd = tmp_rd;

    wire [31:0] tmp_offset;
    always @ (posedge clk) begin
        if(!rst | hold_en) begin
            tmp_offset <= 32'd0;
        end else begin
            tmp_offset <= offset_i;
        end
    end
    assign offset_o = tmp_offset;

    wire [31:0] tmp_immediate;
    always @ (posedge clk) begin
        if(!rst | hold_en) begin
            tmp_immediate <= 32'd0;
        end else begin
            tmp_immediate <= immediate_i;
        end
    end
    assign immediate_o = tmp_ins_addr;



endmodule
