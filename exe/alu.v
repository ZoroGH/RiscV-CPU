`timescale 1ns / 1ps

module alu (
    input      [31:0] A,
    input      [31:0] B,
    input      [ 2:0] opcode,
    output reg [31:0] result
);
    wire [63:0] multip_res;
    assign multip_res = {{32{A[31]}},A} * {{32{B[31]}},B};   
    always @(*) begin
        case (opcode)
            3'd0: result = A + B;
            3'd1: result = A - B;
            3'd2: result = A & B;
            3'd3: result = A | B;
            3'd4: result = A ^ B;
            3'd5: result = multip_res[31:0];       // mul
            3'd6: result = multip_res[63:32];      // mulh
            default: result = 32'd0;
        endcase
    end

    // for debug
    reg [127:0] opcode_ascii;
    always @(*) begin
        case (opcode)
            3'd0: opcode_ascii = "+";
            3'd1: opcode_ascii = "-";
            3'd2: opcode_ascii = "&";
            3'd3: opcode_ascii = "|";
            3'd4: opcode_ascii = "^";
            3'd5: opcode_ascii = "*";
            3'd6: opcode_ascii = "*h";
            default: opcode_ascii = "error";
        endcase
    end
endmodule
