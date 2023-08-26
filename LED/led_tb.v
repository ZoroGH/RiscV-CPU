`timescale 1ns/1ns
module led_tb();
    
    reg crtl = 0;
    reg [31:0] num;
    reg LED0_CA;
    reg LED0_CB;
    reg LED0_CC;
    reg LED0_CD;
    reg LED0_CE;
    reg LED0_CF;
    reg LED0_CG;
    reg LED0_DP;
    reg DN0_K1;
    reg DN0_K2;
    reg DN0_K3;
    reg DN0_K4;
    reg LED1_CA;
    reg LED1_CB;
    reg LED1_CC;
    reg LED1_CD;
    reg LED1_CE;
    reg LED1_CF;
    reg LED1_CG;
    reg LED1_DP;
    reg DN1_K1;
    reg DN1_K2;
    reg DN1_K3;
    reg DN1_K4;

    initial begin
        num <= 101111000110000101001110;
    end

    led_top test_led (
        .crtl   (crtl),
        .num    (num),
        .LED0_CA    (LED0_CA),
        .LED0_CB    (LED0_CB),
        .LED0_CC    (LED0_CC),
        .LED0_CD    (LED0_CD),
        .LED0_CE    (LED0_CE),
        .LED0_CF    (LED0_CF),
        .LED0_CG    (LED0_CG),
        .LED0_DP    (LED0_DP),
        .DN0_K1     (DN0_K1),
        .DN0_K2     (DN0_K2),
        .DN0_K3     (DN0_K3),
        .DN0_K4     (DN0_K4),
        .LED1_CA    (LED1_CA),
        .LED1_CB    (LED1_CB),
        .LED1_CC    (LED1_CC),
        .LED1_CD    (LED1_CD),
        .LED1_CE    (LED1_CE),
        .LED1_CF    (LED1_CF),
        .LED1_CG    (LED1_CG),
        .LED1_DP    (LED1_DP),
        .DN1_K1     (DN1_K1),
        .DN1_K2     (DN1_K2),
        .DN1_K3     (DN1_K3),
        .DN1_K4     (DN1_K4)
    );


endmodule