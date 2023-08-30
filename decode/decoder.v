`timescale 1ns / 1ps

`include "instruction.vh"

module decoder (
    input [31:0] instruction,
    output wire [6:0] op,
    output reg [ 4:0] op_type, // this is a rearrange of op, only for this file.
    output reg [ 4:0] rs1,
    output reg [ 4:0] rs2,
    output reg [ 4:0] rd,
    output reg [31:0] offset,
    output reg [31:0] immediate
);

    assign op = instruction[6:0];
    reg [31:0] op_ascii;
    // op_ascii and op_type
    always @(*) begin
        if(instruction != 32'b0)
        case (op)
            7'b011_0011: begin
                case(instruction[14:12])
                    3'b000: begin
                        case(instruction[31:25])
                            7'b0000000: begin
                                op_ascii = "add";
                                op_type = `I_ADD;
                            end
                            7'b0100000: begin
                                op_ascii = "sub";
                                op_type = `I_SUB;
                            end
                            7'b0000001: begin
                                op_ascii = "mul";
                                op_type = `I_MUL;
                            end
                            default: begin
                                op_ascii = "err";
                                op_type  = `I_ERR;
                            end
                        endcase
                    end
                    3'b001: begin
                        op_ascii = "mulh";
                        op_type = `I_MULH;
                    end
                    3'b100: begin
                        op_ascii = "xor";
                        op_type = `I_XOR;
                    end
                    3'b110: begin
                        op_ascii = "or";
                        op_type = `I_OR;
                    end
                    3'b111: begin
                        op_ascii = "and";
                        op_type = `I_AND;
                    end
                    default: begin
                        op_ascii = "err";
                        op_type  = `I_ERR;
                    end
                endcase
            end
            7'b001_0011: begin
                op_ascii = "addi";
                op_type  = `I_ADDI;
            end
            7'b110_0011: begin
                case (instruction[14:12])
                    3'b000: begin
                        op_ascii = "beq";
                        op_type  = `I_BEQ;
                    end
                    3'b100: begin
                        op_ascii = "blt";
                        op_type  = `I_BLT;
                    end
                    3'b001: begin
                        op_ascii = "bne";
                        op_type  = `I_BNE;
                    end
                    3'b101: begin
                        op_ascii = "bge";
                        op_type = `I_BGE;
                    end
                    default: begin
                        op_ascii = "err";
                        op_type  = `I_ERR;
                    end
                endcase
            end
            7'b000_0011: begin
                op_ascii = "lw";
                op_type  = `I_LW;
            end
            7'b010_0011: begin
                op_ascii = "sw";
                op_type  = `I_SW;
            end
            7'b110_1111: begin
                op_ascii = "jal";
                op_type  = `I_JAL;
            end
            7'b011_0111: begin
                op_ascii = "lui";
                op_type = `I_LUI;
            end
            7'b001_0111: begin
                op_ascii = "auipc";
                op_type = `I_AUIPC;
            end
            default: begin
                op_ascii = "err";
                op_type  = `I_ERR;
            end
        endcase
        else begin
            op_ascii = "null";
            op_type = `I_NULL;
        end
    end

    // decoder param
    // get the param according to the instruction.

    always @(*) begin
        case (op_type)
            `I_ADD, `I_SUB, `I_MUL, `I_XOR, `I_AND, `I_OR, `I_MULH: begin
                rs1       = instruction[19:15];
                rs2       = instruction[24:20];
                rd        = instruction[11:7];
                offset    = 32'd0;
                immediate = 32'd0;
            end
            `I_ADDI: begin
                rs1       = instruction[19:15];
                rs2       = 5'd0;
                rd        = instruction[11:7];
                offset    = 32'd0;
                immediate = {{20{instruction[31]}}, instruction[31:20]};  // 20bit+12bit
            end
            `I_BEQ, `I_BNE, `I_BLT, `I_BGE: begin
                rs1       = instruction[19:15];
                rs2       = instruction[24:20];
                rd        = 5'd0;
                //          ext sign                 12                 11              10 - 5              4 - 1
                // offset    = {{20{instruction[31]}},instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
                offset    = {{19{instruction[31]}},instruction[31], instruction[7], instruction[30:25], instruction[11:8],1'b0};
                immediate = 32'd0;
            end
            `I_LW: begin
                rs1       = instruction[19:15];
                rs2       = 5'd0;
                rd        = instruction[11:7];
                offset    = instruction[31:20];
                immediate = 32'd0;
            end
            `I_SW: begin
                rs1       = instruction[19:15];
                rs2       = instruction[24:20];
                rd        = 5'd0;
                offset    = {instruction[31:25], instruction[11:7]};
                immediate = 32'd0;
            end
            `I_JAL: begin
                rs1       = 5'd0;
                rs2       = 5'd0;
                rd        = instruction[11:7];
                offset    = {{12{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21],1'b0};
                immediate = 32'd0;
            end
            `I_LUI, `I_AUIPC: begin
                rs1       = 5'd0;
                rs2       = 5'd0;
                rd        = instruction[11:7];
                offset    = 32'd0;
                immediate = instruction[31:12] << 12;
            end
            `I_ERR: begin
                rs1       = 5'd0;
                rs2       = 5'd0;
                rd        = 5'd0;
                offset    = 32'd0;
                immediate = 32'd0;
            end
            default: begin
                rs1       = 5'd0;
                rs2       = 5'd0;
                rd        = 5'd0;
                offset    = 32'd0;
                immediate = 32'd0;
            end
        endcase
    end


endmodule
