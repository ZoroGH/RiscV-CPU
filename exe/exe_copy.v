module exe (
    input              clk,
    input              rst,
    input       [ 4:0] optype,
    input       [31:0] data1,
    input       [31:0] data2,
    input       [ 4:0] rd,
    input       [31:0] immediate,
    input       [31:0] offset,
    // output
    output reg         jmp_en,
    output reg  [31:0] jmp_addr,
    // write
    output reg         write_reg_flag,  // 该指令是否要写寄存器
    output wire [31:0] res,             // 对于write_reg_flag为1时，此处为要写入寄存器的值
    output reg         clr,             // 分支预测错误
    output reg  [ 4:0] rd_d1
);

    wire write_reg_flag;
    wire load_en;
    wire store_en;
    wire [31:0] store_data;
    wire jmp_en;
    wire [31:0] jmp_addr;
    wire [31:0] res;
    wire clr;

    assign res = load_en ? read_mem_data : res;

    data_process data_process_inst (
        .optype        (optype),
        .data1         (data1),
        .data2         (data2),
        .immediate     (immediate),
        .offset        (offset),
        .ins_addr      (ins_addr),
        .write_reg     (write_reg_flag),
        .load_en       (load_en),
        .store_en      (store_en),
        .write_mem_data(store_data),
        .jmp_en        (jmp_en),
        .jmp_addr      (jmp_addr),
        .res           (res),
        .clr           (clr)
    );

    d_cache d_cache_inst (
        .clk     (clk),
        .rst     (rst),
        .addr    (res),
        .write_en(store_en),
        .data_in (store_data),
        .data_out(read_mem_data)
    );

endmodule
