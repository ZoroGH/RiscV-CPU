module exe(
    input clk,
    input rst,
    input [4:0]  optype,
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] immediate,
    input [31:0] offset,
    input [31:0] ins_addr,

    output reg jmp_en,
    output reg [31:0] jmp_addr,

    output reg write_reg,       // 该指令是否要写寄存器
    output reg [31:0] res,      // 对于write_reg为1时，此处为要写入寄存器的值
    output reg clr              // 分支预测错误
);

    wire write_reg_d0;
    wire jmp_en_d0;
    wire [31:0] jmp_addr_d0;
    wire [31:0] res_d0;
    wire clr_d0;
    wire [31:0] read_mem_data;
    wire load_en_d0;
    wire store_en_d0;
    wire load_en_d1;
    wire store_en_d1;
    wire [31:0] store_data_d0;
    reg [31:0] store_data_d1;

    // 延迟一拍
    always @(posedge clk) begin
        write_reg   <=  write_reg_d0;
        jmp_en      <=  jmp_en_d0;
        jmp_addr    <=  jmp_addr_d0;
        clr         <=  clr_d0;
        store_en_d1 <=  store_en_d0;
        load_en_d1  <=  load_en_d0;
        store_data_d1  <= store_data_d0;
    end

    always @(*) begin
        if(load_en_d1 == 1)    res = read_mem_data;
        else                   res = res_d0;
    end

    data_process data_process_inst(
        .optype     ( optype      ),
        .data1      ( data1       ),
        .data2      ( data2       ),
        .immediate  ( immediate   ),
        .offset     ( offset      ),
        .ins_addr   ( ins_addr    ),
        .write_reg  ( write_reg_d0),
        .load_en    ( load_en_d0  ),
        .store_en   ( store_en_d0 ),
        .write_mem_data ( store_data_d0 ),
        .jmp_en     ( jmp_en_d0   ),
        .jmp_addr   ( jmp_addr_d0 ),
        .res        ( res_d0      ),
        .clr        ( clr_d0      )
    );

    d_cache d_cache_inst(
        .clk        ( clk           ),
        .rst        ( rst           ),
        .addr       ( res_d0        ),
        .write_en   ( store_en_d1   ),
        .data_in    ( store_data_d1 ),
        .data_out   ( read_mem_data )
    );

endmodule