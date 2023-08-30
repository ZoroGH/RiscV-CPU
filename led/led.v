module led(
    input [3:0] digit,
    output reg [7:0] segs
);
    always @(*) begin
        case (digit)
            4'b0000: segs = 8'b11111100;
            4'b0001: segs = 8'b01100000;
            4'b0010: segs = 8'b11011010;
            4'b0011: segs = 8'b11110010;
            4'b0100: segs = 8'b01100110;
            4'b0101: segs = 8'b10110110;
            4'b0110: segs = 8'b10111110;
            4'b0111: segs = 8'b11100000;
            4'b1000: segs = 8'b11111110;
            4'b1001: segs = 8'b11110110;
            default: segs = 8'b11111111;
        endcase
    end
endmodule