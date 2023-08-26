`timescale 1ns/1ps
module binary_to_demical (
    input wire [31:0] binary_num,
    output reg [3:0] demical_digits[0:7]
);

    reg [31:0] quotient;
    reg [3:0] digit;
    reg [2:0] i;

    always @(*) begin
        quotient = binary_num;
        digit = 0;
        
        for (i = 0; i < 8; i = i + 1) begin
            digit = quotient % 10;
            demical_digits[i] = digit;
            quotient = quotient / 10;
        end
    end

endmodule
