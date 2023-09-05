`timescale 1ns / 1ps
module exe_tb ();

    // 时钟和复位信号
    reg clk;
    reg rst;

    // 输入信号
    reg [4:0] optype;
    reg [31:0] data1;
    reg [31:0] data2;
    reg [31:0] immediate;
    reg [31:0] offset;
    reg [31:0] ins_addr;

    // 输出信号
    wire jmp_en;
    wire [31:0] jmp_addr;
    wire write_reg;
    wire [31:0] res;
    wire clr;

    // 实例化待测试的模块
    exe u_exe (
        .clk      (clk),
        .rst      (rst),
        .optype   (optype),
        .data1    (data1),
        .data2    (data2),
        .immediate(immediate),
        .offset   (offset),
        .jmp_en   (jmp_en),
        .jmp_addr (jmp_addr),
        .write_reg(write_reg),
        .res      (res),
        .clr      (clr)
    );



    // 初始化时钟和复位信号
    initial begin
        clk = 0;
        rst = 1;

        // 在仿真开始前，等待一段时间来确保模块初始化
        #10;
        rst = 0;
        // 启动时钟
        optype = 5'b00101;  // 你的 optype 值
        data1 = 32'h12345678;  // 你的 data1 值
        data2 = 32'h87654321;  // 你的 data2 值
        immediate = 32'hABCDEF01;  // 你的 immediate 值
        offset = 32'h543210F0;  // 你的 offset 值
        ins_addr = 32'h00010004;  // 你的 ins_addr 
        forever begin
            #5 clk = ~clk;
        end

        // 模块初始化完成后，释放复位
        rst = 1;
    end

endmodule
