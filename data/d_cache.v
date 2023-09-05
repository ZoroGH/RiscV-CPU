module d_cache (
    input clk,
    input rst,
    input [31:0] addr,
    input write_en,
    input [31:0] data_in,
    output reg [31:0] data_out
);
    reg [7:0] mem[511:0];

    // write
    integer j;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (j = 0; j < 512; j = j + 1) mem[j] <= 8'd0;
        end else if (write_en) begin
            // if(we) begin
            mem[addr] <= data_in[31:24];
            mem[addr+1] <= data_in[23:16];
            mem[addr+2] <= data_in[15:8];
            mem[addr+3] <= data_in[7:0];
        end
    end

    always @(*) begin
        data_out = {mem[addr],mem[addr+1],mem[addr+2],mem[addr+3]};
    end

    initial begin
        // #10
        #8 $readmemb("C:/Users/CAFISK/Desktop/RiscV-CPU-lbw/RiscV-CPU-main/data/cache.bin", mem);
    end

endmodule
