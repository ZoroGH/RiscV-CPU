module exe(
    input              clk,
    input              rst,
    input       [ 4:0] optype,
    input       [31:0] data1,
    input       [31:0] data2,
    input       [ 4:0] rs1,
    input       [ 4:0] rs2,
    input       [ 4:0] rd,
    input       [31:0] immediate,
    input       [31:0] offset,
    // output
    output reg         jmp_en,
    output reg  [31:0] jmp_addr,
    // write
    output reg         we_reg,          // 该指令是否要写寄存器
    output wire [31:0] res,             // 对于write_reg_flag为1时，此处为要写入寄存器的值
    output reg         clr,             // 分支预测错误
    output reg  [ 4:0] rd_d1
);
    wire we_reg;
    wire load_en;
    wire store_en;
    wire [31:0] store_data;
    wire jmp_en;
    wire [31:0] jmp_addr;
    wire [31:0] res;
    wire clr;

    // 上一条指令的信息，为解决数据冒险而保存
    reg store_en_last;
    reg [31:0] res_last;
    reg we_reg_last;
    reg [31:0] store_data_last;
    reg [31:0] read_mem_data_last;

    // 要保存用于解决数据冒险的值
    always @(posedge clk) begin
        // 要保存：res, rd, we_reg,store_en,write_data,addr
        res_last        <= res;
        rd_d1           <= rd;
        we_reg_last     <= we_reg;
        store_en_last   <= store_en;
        store_data_last <= store_data;
    end

    wire [31:0] real_data1;
    wire [31:0] real_data2;
    wire [31:0] real_read_data;
    assign real_data1     = (rs1 == rd_d1 && we_reg_last) ? res_last : data1;
    assign real_data2     = (rs2 == rd_d1 && we_reg_last) ? res_last : data2;
    assign real_read_data = (optype == 5'd5 && store_en_last && res_last == offset+real_data2) ? store_data_last : read_mem_data;


    assign res = load_en ? real_read_data : res;

    data_process data_process_inst (
        .optype        (optype),
        .data1         (real_data1),
        .data2         (real_data2),
        .immediate     (immediate),
        .offset        (offset),
        .ins_addr      (ins_addr),
        .write_reg     (we_reg),
        .load_en       (load_en),
        .store_en      (store_en),
        .write_mem_data(store_data),
        .jmp_en        (jmp_en),
        .jmp_addr      (jmp_addr),
        .res           (res),
        .clr           (clr)
    );

    d_cache d_cache_inst (
        .clk        (clk),
        .rst        (rst),
        .addr       (res),
        .write_en   (store_en),
        .data_in    (store_data),
        .data_out   (read_mem_data)
    );


endmodule