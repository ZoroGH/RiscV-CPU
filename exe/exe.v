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
    output [31:0] addr,
    output [31:0] data,     // 要写入内存的值

    output jmp_en,
    output jmp_addr,

    output res,// result
    output clr
);

    data_process data_process_inst(
        .clk    (clk),
        .rst    (rst),
        .optype (optype),
        .data1  (data1),
        .data2  (data2),
        .immediate  (immediate),
        .offset     (offset),
        .write_reg  (write_reg),
        .load_en    (load_en),
        .store_en   (store_en),
        .res        (res)
    );

    always @(*) begin
        case (optype) 
            `I_BEQ: begin
                if (res == 'd0) begin
                    jmp_en = 'd1;
                    jmp_addr = offset;
                    clr = 'd1;
                end
                else begin
                    jmp_en = 'd0;
                    jmp_addr = 32'd0;
                    clr = 'd0;
                end
            end
            `I_BNE: begin
                if (res != 'd0) begin
                    jmp_en = 'd1;
                    jmp_addr = offset;
                    clr = 'd1;
                end
                else begin
                    jmp_en = 'd0;
                    jmp_addr = 32'd0;
                    clr = 'd0;
                end
            end
            `I_BLT: begin
                if (res < 'd0) begin
                    jmp_en = 'd1;
                    jmp_addr = offset;
                    clr = 'd1;
                end
                else begin
                    jmp_en = 'd0;
                    jmp_addr = 32'd0;
                    clr = 'd0;
                end
            end
            `I_BGE: begin
                if (res >= 'd0) begin
                    jmp_en = 'd1;
                    jmp_addr = offset;
                    clr = 'd1;
                end
                else begin
                    jmp_en = 'd0;
                    jmp_addr = 32'd0;
                    clr = 'd0;
                end
            end
            `I_LW: begin
                jmp_en = 'd0;
                jmp_addr = 32'd0;
                clr = 'd0;
                addr = res;
                data = 32'd0;
            end
            `I_SW: begin
                jmp_en = 'd0;
                jmp_addr = 32'd0;
                clr = 'd0;
                addr = res;
                data = data1;
            end
            `I_JAL: begin
                jmp_en = 'd1;
                jmp_addr = res;
                clr = 'd1;
                addr = 32'd0;
                data = 32'd0;
            end
            default: begin
                jmp_en = 'd0;
                jmp_addr = 32'd0;
                clr = 'd0;
                addr = 32'd0;
                data = 32'd0;
            end
        endcase
    end


endmodule