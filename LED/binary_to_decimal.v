`timescale 1ns/1ns
module binary_to_decimal (
    input wire [31:0] binary_num,
    output reg [3:0] decimal_digits[0:7]
);

    reg [31:0] quotient;
    reg [3:0] digit;
    reg [2:0] i;

    always @(*) begin
        quotient = binary_num;
        digit = 0;
        
        for (i = 0; i < 8; i = i + 1) begin
            digit = quotient % 10;
            decimal_digits[i] = digit;
            quotient = quotient / 10;
        end
    end

endmodule
