`include "instruction.vh"

module id_exe (
    input clk,
    input rst,
    input hold,
    input wire [4:0] op_type,  // this is a rearrange of op, only for this file.
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,
    input wire [31:0] offset,
    input wire [31:0] immediate,
    //output
    output reg [4:0] op_type_d1,
    output reg [4:0] rs1_d1,
    output reg [4:0] rs2_d1,
    output reg [4:0] rd_d1,
    output reg [31:0] offset_d1,
    output reg [31:0] immediate_d1
);


    // delay for all param
    always @(posedge clk) begin
        if (rst || hold) begin
            op_type_d1 <= 5'd0;
            rs1_d1 <= 5'd0;
            rs2_d1 <= 5'd0;
            rd_d1 <= 5'd0;
            offset_d1 <= 32'd0;
            immediate_d1 <= 32'd0;
            // end else if (hold) begin
            //     //TODO: not sure
            //     op_type_d1 <= op_type_d1;
            //     rs1_d1 <= rs1_d1;
            //     rs2_d1 <= rs2_d1;
            //     rd_d1 <= rd_d1;
            //     offset_d1 <= offset_d1;
            //     immediate_d1 <= immediate_d1;
        end else begin
            op_type_d1 <= op_type;
            rs1_d1 <= rs1;
            rs2_d1 <= rs2;
            rd_d1 <= rd;
            offset_d1 <= offset;
            immediate_d1 <= immediate;
        end
    end

endmodule
