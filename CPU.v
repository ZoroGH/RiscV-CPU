`timescale 1ns / 1ns
`include "instruction.vh"

module CPU_Top (
    input clk,
    input rst
);
    wire clr;
    wire jmp_en;
    wire hold;
    wire [31:0] jmp_addr;
    wire [31:0] ins;
    wire [6 : 0] op;
    wire [4:0] op_type;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [31:0] offset;
    wire [31:0] immediate;
    wire [31:0] ins_i;
    wire [31:0] offset_i;
    wire [31:0] immediate_i;
    wire [31:0] ins_addr_o;
    wire [4:0] op_type_o;
    wire [31:0] data1;
    wire [31:0] data2;
    wire [31:0] offset_o;
    wire [31:0] immediate_o;
    wire write_reg_flag;
    wire [31:0] res;
    wire [4:0] op_type_d1;
    wire [4:0] rs1_d1;
    wire [4:0] rs2_d1;
    wire [4:0] rd_d1;
    wire [4:0] rd_d2;
    wire [31:0] offset_d1;
    wire [31:0] immediate_d1;


    fetch u_fetch (
        .clk     (clk),
        .rst     (rst),
        .clr     (clr),
        .jmp_en  (jmp_en),
        .hold    (hold),
        .jmp_addr(jmp_addr),
        .ins     (ins)
    );

    decoder u_decoder (
        .clk      (clk),
        .rst      (rst),
        .hold     (hold),
        .ins      (ins),
        .op_type  (op_type),
        .rs1      (rs1),
        .rs2      (rs2),
        .rd       (rd),
        .offset   (offset),
        .immediate(immediate)
    );

    id_exe u_id_exe (
        .clk         (clk),
        .rst         (rst),
        .hold        (hold),
        .op_type     (op_type),
        .rs1         (rs1),
        .rs2         (rs2),
        .rd          (rd),
        .offset      (offset),
        .immediate   (immediate),
        .op_type_d1  (op_type_d1),
        .rs1_d1      (rs1_d1),
        .rs2_d1      (rs2_d1),
        .rd_d1       (rd_d1),
        .offset_d1   (offset_d1),
        .immediate_d1(immediate_d1)
    );

    exe u_exe (
        .clk           (clk),
        .rst           (rst),
        .optype        (op_type_d1),
        .data1         (data1),
        .data2         (data2),
        .rs1           (rs1_d1),
        .rs2           (rs2_d1),
        .rd            (rd_d1),
        .immediate     (immediate_d1),
        .offset        (offset_d1),
        .jmp_en        (jmp_en),
        .jmp_addr      (jmp_addr),
        .we_reg        (write_reg_flag),
        .res           (res),
        .clr           (hold),
        .rd_d1         (rd_d2)
    );

    reg_file u_reg_file (
        .clk     (clk),
        .rst     (rst),
        .write_en(write_reg_flag),
        .ra1     (rs1_d1),
        .ra2     (rs2_d1),
        .wa      (rd_d2),
        .wd      (res),
        .rd1     (data1),
        .rd2     (data2)
    );

endmodule
