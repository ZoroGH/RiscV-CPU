/*
    an encapsulated ALU
    the first cycle, get res, write_reg, load_en, store_en, jmp+en, jmp_addr
*/
`include "instruction.vh"
module data_process (
    input wire [4:0] optype,
    input wire [31:0] data1,
    input wire [31:0] data2,
    input wire [31:0] immediate,
    input wire [31:0] offset,
    input wire [31:0] ins_addr,
    output reg write_reg,
    output reg load_en,
    output reg store_en,
    output wire [31:0] write_mem_data,
    output reg jmp_en,
    output reg [31:0] jmp_addr,
    output reg [31:0] res,
    output reg clr
);
    reg [31:0] A;
    reg [31:0] B;
    reg [2:0] opcode;
    wire [31:0] result;
    wire SF;
    wire ZF;

    alu alu (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .SF(SF),
        .ZF(ZF)
    );

    assign write_mem_data = data2;

    always @(*) begin
        res = result;
        case (optype)
            `I_BEQ: begin
                opcode    = 3'd1;
                A         = data1;
                B         = data2;
                write_reg = 1'd0;
                load_en   = 1'd0;
                store_en  = 1'd0;
                if (ZF == 1) begin
                    jmp_en = 1'd1;
                    jmp_addr = offset;
                    clr = 1'd1;
                end else begin
                    jmp_en = 1'd0;
                    jmp_addr = 32'd0;
                    clr = 1'd0;
                end
            end
            `I_BNE: begin
                opcode    = 3'd1;
                A         = data1;
                B         = data2;
                write_reg = 1'd0;
                load_en   = 1'd0;
                store_en  = 1'd0;
                if (ZF == 0) begin
                    jmp_en = 1'd1;
                    jmp_addr = offset;
                    clr = 1'd1;
                end else begin
                    jmp_en = 1'd0;
                    jmp_addr = 32'd0;
                    clr = 1'd0;
                end
            end
            `I_BLT: begin
                opcode    = 3'd1;
                A         = data1;
                B         = data2;
                write_reg = 1'd0;
                load_en   = 1'd0;
                store_en  = 1'd0;
                if (SF == 1) begin
                    jmp_en = 1'd1;
                    jmp_addr = offset;
                    clr = 1'd1;
                end else begin
                    jmp_en = 1'd0;
                    jmp_addr = 32'd0;
                    clr = 1'd0;
                end
            end
            `I_BGE: begin
                opcode    = 3'd1;
                A         = data1;
                B         = data2;
                write_reg = 1'd0;
                load_en   = 1'd0;
                store_en  = 1'd0;
                if (SF == 1) begin
                    jmp_en = 1'd0;
                    jmp_addr = 32'd0;
                    clr = 1'd0;
                end else begin
                    jmp_en = 1'd1;
                    jmp_addr = offset;
                    clr = 1'd1;
                end
            end
            `I_LW: begin
                opcode    = 3'd0;
                A         = data1;
                B         = offset;
                write_reg = 1'd1;
                load_en   = 1'd1;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_SW: begin
                opcode    = 3'd0;
                A         = data1;
                B         = offset;
                write_reg = 1'd0;
                load_en   = 1'd0;
                store_en  = 1'd1;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_JAL: begin
                opcode    = 3'd0;
                A         = ins_addr;
                B         = 32'd0;
                write_reg = 1'd0;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd1;
                jmp_addr  = offset;
                clr       = 1'd1;
            end
            `I_ADDI: begin
                opcode    = 3'd0;
                A         = data1;
                B         = immediate;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_ADD: begin
                opcode    = 3'd0;
                A         = data1;
                B         = data2;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_SUB: begin
                opcode    = 3'd1;
                A         = data1;
                B         = data2;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_MUL: begin
                opcode    = 3'd5;
                A         = data1;
                B         = data2;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_MULH: begin
                opcode    = 3'd6;
                A         = data1;
                B         = data2;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_XOR: begin
                opcode    = 3'd4;
                A         = data1;
                B         = data2;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_AND: begin
                opcode    = 3'd2;
                A         = data1;
                B         = data2;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_OR: begin
                opcode    = 3'd3;
                A         = data1;
                B         = data2;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_LUI: begin
                opcode    = 3'd0;
                A         = 32'd0;
                B         = immediate;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            `I_AUIPC: begin
                opcode    = 3'd0;
                A         = 32'd0;
                B         = immediate;
                write_reg = 1'd1;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
            default: begin
                opcode    = 3'd0;
                A         = 32'd0;
                B         = 32'd0;
                write_reg = 1'd0;
                load_en   = 1'd0;
                store_en  = 1'd0;
                jmp_en    = 1'd0;
                jmp_addr  = 32'd0;
                clr       = 1'd0;
            end
        endcase
    end
endmodule
