`timescale 1ns / 1ps

module decoder_tb();

reg [31:0] instruction;
wire [6:0] op;
wire [ 4:0] op_type;
wire [ 4:0] rs1;
wire [ 4:0] rs2;
wire [ 4:0] rd;
wire [31:0] offset;
wire [31:0] immediate;

decoder u_decoder(
    .instruction  ( instruction  ),
    .op(op),
    .op_type(op_type),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .offset(offset),
    .immediate(immediate)
);


initial begin
    # 10
    instruction <= 32'b00000000011001010010011000000011; // lw
    # 50
    instruction <= 32'b00000000101101010010001100100011; // sw
    # 50
    instruction <= 32'b00000011110000000000011001101111; // jal
    # 50
    instruction <= 32'b00000000011001010000011000010011; // addi
    # 50
    instruction <= 32'b00000000101101010000011000110011; // add
    # 50
    instruction <= 32'b01000000101101010000011000110011; // sub
    # 50
    instruction <= 32'b00000010101101010000011000110011; // mul
    # 50
    instruction <= 32'b00000010101101010001011000110011; // mulh
    # 50
    instruction <= 32'b00000010101101010101001001100011; // bge
    # 50
    instruction <= 32'b00000000101101010100011000110011; // xor
    # 50
    instruction <= 32'b00000000101101010111011000110011; // and
    # 50
    instruction <= 32'b00000000101101010110011000110011; // or
    # 50
    instruction <= 32'b00000000000000000110011000110111; // lui
    # 50
    instruction <= 32'b00000000000000000110011000010111; // auipc
    # 50
    instruction <= 32'b00000000101101010100011001100011; // blt
    # 50
    instruction <= 32'b00000000101101010000010001100011; // beq
    # 50
    instruction <= 32'b00000000101101010001001001100011; // bne

    
    
    
end

endmodule
