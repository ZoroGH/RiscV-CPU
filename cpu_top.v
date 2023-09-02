module cpu_top(
    input clk,
    input rst
);

    wire [31:0] ins_addr;
    wire [31:0] ins;

    wire write_en;
    wire [4:0] ra1;
    wire [4:0] ra2;
    wire [4:0] wa;
    wire [31:0] wd;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire write_reg;

    wire load_en;
    wire store_en;
    wire [31:0] mem_addr;
    wire [31:0] mem_data;
    wire jmp_en;
    wire [31:0] jmp_addr;
    wire [31:0] res;
    reg [31:0]wd;
    wire clr;

    wire [31:0] do;

    always @(*) begin
        if(load_en == 1)    wd = do;
        else                wd = res;
    end

    reg_file reg_file_inst(
        .clk (clk),
        .rst (rst),
        .write_en(write_reg),          // write enbale
        .ra1(ra1),          // read index 1
        .ra2(ra2),          // read index 2
        .wa(wa),            // write index
        .wd(res),            // write data
        .rd1(read_data1),   // read data 1
        .rd2(read_data2)    // read data 2
    );

    exe exe_inst(
        .clk (clk),
        .rst (rst),
        .optype (optype),
        .data1 (read_data1),
        .data2 (read_data2),
        .immediate (immediate),
        .offset (offset),
        .ins_addr (ins_addr),
        .write_reg (write_reg),     // 该指令是否要写寄存器
        .load_en (load_en),         // 是否要load
        .store_en (store_en),       // 是否要store
        .addr (mem_addr),               // 要写入或者要读取的内存的地址
        .data (mem_data),               // 要写入内存的值
        .jmp_en (jmp_en),
        .jmp_addr (jmp_addr),
        .res (res),                 // 对于write_reg为1时，此处为要写入寄存器的值
        .clr (clr)
    );

    cache cache_inst(
        .clk (clk),
        .rst (rst),
        .i_addr (ins_addr),
        .d_addr (mem_addr),
        .ins (ins),
        .we (store_en),
        .di (mem_data),
        .do (do)
    );


endmodule