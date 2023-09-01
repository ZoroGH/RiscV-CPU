// an encapsulated ALU
module data_process(
    input clk,
    input rst,
    input [4:0]  optype,
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] immediate,
    input [31:0] offset,
    output reg write_reg,
    output reg load_en,
    output reg store_en,
    output res
);
    reg [31:0] A;
    reg [31:0] B;
    reg [2:0] opcode;

    alu alu(
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(res),
    );
 
    always @(*) begin
        case (optype)
            `I_BEQ, `I_BNE, `I_BLT, `I_BGE: begin
                opcode = 3'd1;  // -
                A      = data1;
                B      = data2;
                write_reg = 1'd0;
                load_en = 1'd0;
                store_en = 1'd0;
            end
            `I_LW: begin
                opcode = 'd0;
                A      = data1;
                B      = offset;
                write_reg = 'd1;
                load_en = 'd1;
                store_en = 'd0;
            end
            `I_SW: begin
                opcode = 'd0;
                A      = data2;
                B      = offset;
                write_reg = 'd0;
                load_en = 'd0;
                store_en = 'd1;
            end
            `I_JAL: begin
                opcode = 'd0;
                A      = offset;
                B      = 32'd0;
                write_reg = 'd0;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_ADDI: begin
                opcode = 'd0;
                A      = data1;
                B      = immediate;
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_ADD: begin
                opcode = 'd0;
                A      = data1;
                B      = data2;
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_SUB begin
                opcode = 'd1;
                A      = data1;
                B      = data2;
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_MUL begin
                opcode = 'd5;
                A      = data1;
                B      = data2;
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_MULH begin
                opcode = 'd6;
                A      = data1;
                B      = data2; 
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_XOR begin
                opcode = 'd4;
                A      = data1;
                B      = data2; 
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_AND begin
                opcode = 'd2;
                A      = data1;
                B      = data2; 
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_OR begin
                opcode = 'd3;
                A      = data1;
                B      = data2; 
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_LUI begin
                opcode = 'd0;
                A      = 32'd0;
                B      = immediate; 
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            `I_AUIPC begin
                opcode = 'd0;
                A      = 32'd0;
                B      = immediate; 
                write_reg = 'd1;
                load_en = 'd0;
                store_en = 'd0;
            end
            default: begin
                opcode = 'd9;
                A      = 'd0;
                B      = 'd0;
                write_reg = 'd0;
                load_en = 'd0;
                store_en = 'd0;
            end
        endcase
    end
endmodule