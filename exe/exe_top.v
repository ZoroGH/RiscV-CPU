module exe_top(
    input clk,
    input rst,
    input [4:0] optype,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] offset,
    input [31:0] immediate,

    output [31:0] mem_addr,     // addr for load or store
    input  [31:0] mem_data,     // data from mem(for load)
    output [31:0] write_data,   // data to mem (for store)
    output load_en,
    output store_en,

    output jmp_en,
    output jmp_addr,

    output res,// result
    output clr
);

    wire [31:0] data1;
    wire [31:0] data2;

    wire write_reg;
    wire load_en;
    wire store_en;

    reg  [31:0] result_d1;
    always @(posedge clk) begin
        result_d1 <= res;
    end

    reg_file reg_file_inst(
        .clk (clk),
        .rst (rst),
        .write_en (write_reg),
        .ra1 (rs1),
        .ra2 (rs2),  
        .wa (rd), 
        .wd (),
        .rd1 (data1),
        .rd2 (data2)
    );

    exe exe_inst(
        .clk (clk),
        .optype(optype),
        .data1(data1),
        .data2(data2),
        .immediate(immediate),
        .offset(offset),

        .write_reg (write_reg),
        .load_en(load_en),
        .store_en(store_en),
        .addr(mem_addr),
        .data(data),

        .jmp_en(jmp_en),
        .jmp_addr(jmp_addr),

        .res(res),
        .clr(clr)
    );

endmodule