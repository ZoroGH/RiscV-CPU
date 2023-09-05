`timescale 1ns / 1ns
`include "instruction.vh"
module fetch (
    input clk,
    input rst,
    input clr,
    input jmp_en,
    input hold,
    input [31:0] jmp_addr,
    output wire [31:0] ins
);

    reg [31:0] addr;
    reg [31:0] addr_d1;
    
    wire [31:0] real_addr;
    assign real_addr = ($signed(jmp_addr)) >>> 2;

    always @(posedge clk) begin
        if (rst || clr) begin
            addr <= `I_ONES;
        end else if (hold) begin
            addr <= addr + real_addr - 32'd2;
        end else if (jmp_en) begin
            addr <= addr + real_addr;
        end  else begin
            addr <= addr + 32'd1;
        end
    end

    always @(posedge clk) begin
        addr_d1 <= addr;
    end

    i_cache u_i_cache (
        .clk   (clk),
        .rst   (rst),
        .i_addr(addr_d1),
        .ins   (ins)
    );

endmodule
