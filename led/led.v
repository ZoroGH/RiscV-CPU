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
            4'b1010: segs = 8'b11101110;
            4'b1011: segs = 8'b00111110;
            4'b1100: segs = 8'b10011100;
            4'b1101: segs = 8'b01111010;
            4'b1110: segs = 8'b10011110;
            4'b1111: segs = 8'b10001110;
        endcase
    end
endmodule