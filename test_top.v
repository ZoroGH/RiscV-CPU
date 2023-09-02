module test_top(
    input clk,
    input rst,
    input clr,
    output reg [31:0] ins,
    output reg [31:0] final_ins_addr
);
    
    wire jmp_en;
    wire [31:0] jmp_addr;
    wire hold_en;
    wire [31:0] mem_addr;
    wire we;
    wire [31:0] di;

    assign jmp_en = 1'b0;
    assign jmp_addr = 32'd0;
    assign hold_en = 1'b0;
    assign mem_addr = 32'd0;
    assign we = 1'b0;
    assign di = 32'd0;


    wire [31:0] ins_addr;

    pc_regs pc_regs_inst(
        .clk(clk),
        .rst(rst),
        .clr(clr),
        .jump_en(jmp_en),
        .jump_addr(jmp_addr),
        .hold_en(hold_en),
        .ins_addr(ins_addr)
    );

    cache cache_inst(
        .clk(clk),
        .rst(rst),
        .i_addr(ins_addr),
        .d_addr(mem_addr),
        .i(ins),
        .we(we),
        .di(di),
        .do(do)
    );

    if_id if_id_inst(
        .clk(clk),
        .rst(rst),
        .ins_i(ins),
        .ins_addr_i(ins_addr),
        .hold_en(hold_en),
        .ins_o(ins_o),
        .ins_addr_o(final_ins_addr)
    );


endmodule