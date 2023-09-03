module i_cache (
    input clk,
    input rst,
    input [31:0] i_addr,  // pc >> 2
    output reg [31:0] ins
);
    reg [31:0] mem[511:0];

    always @(*) begin
        ins = mem[i_addr];
    end

    // integer j;
    // always @(posedge clk) begin
    //     if( rst ) begin
    //         for(j=0; j<512;j=j+1) mem[j] <= 32'd0;
    //     end
    // end

    initial begin
        // #10
        @(negedge rst)
        // #1   
        $readmemb(
            "C:/Users/CAFISK/Desktop/RiscV-CPU-lbw/RiscV-CPU-main/data/cache.bin", mem
        );
    end

endmodule
