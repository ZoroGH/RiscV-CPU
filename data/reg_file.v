module reg_file (
    input             clk,
    input             rst,
    input             write_en,  // write enbale
    input      [ 4:0] ra1,       // read index 1
    input      [ 4:0] ra2,       // read index 2
    input      [ 4:0] wa,        // write index
    input      [31:0] wd,        // write data
    output reg [31:0] rd1,       // read data 1
    output reg [31:0] rd2        // read data 2
);

    reg [31:0] r[31:0];  // reg array

    //read     
    always @(*) begin
        rd1 <= r[ra1];
        rd2 <= r[ra2];
    end

    // write
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) r[i] <= 32'd0;
        end else begin
            if (write_en) begin
                r[wa] <= wd;
            end
        end
    end

endmodule
