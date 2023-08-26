`timescale 1ns/1ps
/*
    author : lbw
*/
module led_top(
    input   crtl,
    input   [31:0] num,
    output  LED0_CA,
    output  LED0_CB,
    output  LED0_CC,
    output  LED0_CD,
    output  LED0_CE,
    output  LED0_CF,
    output  LED0_CG,
    output  LED0_DP,
    output  DN0_K1,
    output  DN0_K2,
    output  DN0_K3,
    output  DN0_K4,
    output  LED1_CA,
    output  LED1_CB,
    output  LED1_CC,
    output  LED1_CD,
    output  LED1_CE,
    output  LED1_CF,
    output  LED1_CG,
    output  LED1_DP,
    output  DN1_K1,
    output  DN1_K2,
    output  DN1_K3,
    output  DN1_K4
);

    reg [3:0]   num0;
    reg [3:0]   num1;
    reg [3:0]   demical_digits[0:7];

    led led_0(
        .num    (num0),
        .CA     (LED0_CA),
        .CB     (LED0_CB),
        .CC     (LED0_CC),
        .CD     (LED0_CD),
        .CE     (LED0_CE),
        .CF     (LED0_CF),
        .CG     (LED0_CG),
        .DP     (LED0_DP)
    )

    led led_1(
        .num    (num0),
        .CA     (LED1_CA),
        .CB     (LED1_CB),
        .CC     (LED1_CC),
        .CD     (LED1_CD),
        .CE     (LED1_CE),
        .CF     (LED1_CF),
        .CG     (LED1_CG),
        .DP     (LED1_DP)
    )

    binary_to_demical b2d(
        .binary_num     (num),
        .demical_digits (demical_digits)
    )

    reg [1:0] i;
    always @(*) begin
        for(i = 0; i < 4; i++) begin
            case (i)
                2`d0:
                    begin
                        DN0_K1 = 1;
                        DN0_K2 = 0;
                        DN0_K3 = 0;
                        DN0_K4 = 0;
                        DN1_K1 = 1;
                        DN1_K2 = 0;
                        DN1_K3 = 0;
                        DN1_K4 = 0;
                        num0 = demical_digits[0];
                        num1 = demical_digits[4];
                    end
                2`d1:
                    begin
                        DN0_K1 = 0;
                        DN0_K2 = 1;
                        DN0_K3 = 0;
                        DN0_K4 = 0;
                        DN1_K1 = 0;
                        DN1_K2 = 1;
                        DN1_K3 = 0;
                        DN1_K4 = 0;
                        num0 = demical_digits[1];
                        num1 = demical_digits[5];
                    end
                2`d2:
                    begin
                        DN0_K1 = 0;
                        DN0_K2 = 0;
                        DN0_K3 = 1;
                        DN0_K4 = 0;
                        DN1_K1 = 0;
                        DN1_K2 = 0;
                        DN1_K3 = 1;
                        DN1_K4 = 0;
                        num0 = demical_digits[2];
                        num1 = demical_digits[6];
                    end
                2`d3:
                    begin
                        DN0_K1 = 0;
                        DN0_K2 = 0;
                        DN0_K3 = 0;
                        DN0_K4 = 1;
                        DN1_K1 = 0;
                        DN1_K2 = 0;
                        DN1_K3 = 0;
                        DN1_K4 = 1;
                        num0 = demical_digits[3];
                        num1 = demical_digits[7];
                    end            
            endcase
        end
    end
endmodule