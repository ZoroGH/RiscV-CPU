module exe(
    input clk,
    input rst,
    input [4:0]  optype,
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] immediate,
    input [31:0] offset,
    input [31:0] ins_addr;

    output reg write_reg,       // 该指令是否要写寄存器
    output reg load_en,         // 是否要load
    output reg store_en,        // 是否要store
    output reg [31:0] addr,     // 要写入或者要读取的内存的地址
    output reg [31:0] data,     // 要写入内存的值

    output reg jmp_en,
    output reg [31:0] jmp_addr,

    output reg [31:0] res,      // 对于write_reg为1时，此处为要写入寄存器的值
    output reg clr
);

    wire write_reg_d0;
    wire load_en_d0;
    wire store_en_d0;
    wire [31:0] addr_d0;
    wire [31:0] data_d0;
    wire jmp_en_d0;
    wire jmp_addr_d0;
    wire res_d0;
    wire clr_d0;

    // 延迟一拍
    always @(posedge clk) begin
        write_reg <= write_reg_d0;
        load_en <= load_en_d0;
        store_en <= store_en_d0;
        addr <= addr_d0;
        data <= data_d0;
        jmp_en <= jmp_en_d0;
        jmp_addr <= jmp_addr_d0;
        res <= res_d0;
        clr <= clr_d0;
    end

    data_process data_process_inst(
        .optype (optype),
        .data1  (data1),
        .data2  (data2),
        .immediate  (immediate),
        .offset     (offset),
        ,ins_addr   (ins_addr),
        .write_reg  (write_reg_d0),
        .load_en    (load_en_d0),
        .store_en   (store_en_d0),
        .jmp_en     (jmp_en_d0),
        .jmp_addr   (jmp_addr_d0),
        .res        (res_d0),
        .clr        (clr_d0)
    );

endmodule