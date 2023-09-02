module exe(
    input clk,
    input rst,
    input [4:0]  optype,
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] immediate,
    input [31:0] offset,

    output write_reg,       // 该指令是否要写寄存器
    output load_en,         // 是否要load
    output store_en,        // 是否要store
    output [31:0] addr,     // 要写入或者要读取的内存的地址
    output [31:0] data,     // 要写入内存的值

    output jmp_en,
    output jmp_addr,

    output res,             // 对于write_reg为1时，此处为要写入寄存器的值
    output clr
);
    always @(posedge clk) begin
        
    end


    data_process data_process_inst(
        .optype (optype),
        .data1  (data1),
        .data2  (data2),
        .immediate  (immediate),
        .offset     (offset),
        .write_reg  (write_reg),
        .load_en    (load_en),
        .store_en   (store_en),
        .jmp_en     (jmp_en),
        .jmp_addr   (jmp_addr),
        .res        (res)
    );

endmodule