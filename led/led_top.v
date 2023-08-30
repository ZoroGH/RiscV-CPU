module led_top(
    input clk,
    input rst,
    input [31:0] digits,      // 8 decimal digits to display, coded in BCD
    output wire [7:0] led0_segs,     // 7 segs and dp
    output reg [3:0] led0_en,       // the led to light
    output wire [7:0] led1_segs,
    output reg [3:0] led1_en
);
    reg [3:0] digit0;
    reg [3:0] digit1;

    led led0(
        .digit(digit0),
        .segs(led0_segs)
    );
    
    led led1(
        .digit(digit1),
        .segs(led1_segs)
    );

    always @(posedge clk) begin
        if (rst) begin
            led0_en <= 4'd0;
        end
        else if( led0_en == 4'd0 || led0_en == 4'd8) begin
            led0_en <= 4'd1;
        end else begin
            led0_en <= {led0_en[3:0],1'd0};
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            led1_en <= 4'd0;
        end
        else if( led1_en == 4'd0 || led1_en == 4'd8) begin
            led1_en <= 4'd1;
        end else begin
            led1_en <= {led1_en[3:0],1'd0};
        end
    end

    always @(*) begin
        case(led1_en)
            4'd1: digit1 = digits[31:28];
            4'd2: digit1 = digits[27:24];
            4'd4: digit1 = digits[23:20];
            4'd8: digit1 = digits[19:16];
            default :
                digit1 = 4'd0;
        endcase
    end

    always @(*) begin
        case(led0_en)
            4'd1: digit0 = digits[15:12];
            4'd2: digit0 = digits[11:8];
            4'd4: digit0 = digits[7:4];
            4'd8: digit0 = digits[3:0];
            default :
                digit0 = 4'd0;
        endcase
    end


endmodule