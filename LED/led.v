`timescale 1ns/1ns
/*
    author : lbw
*/
module led(
    input   [3:0] num,
    output reg  CA,
    output reg  CB,
    output reg  CC,
    output reg  CD,
    output reg  CE,
    output reg  CF,
    output reg  CG,
    output reg DP
);
    always @(*) begin
        DP = 0;
        case (num)
            4'd0: 
                begin
                    CA = 1;
                    CB = 1;
                    CC = 1;
                    CD = 1;
                    CE = 1;
                    CF = 1;
                    CG = 0;
                end
            4'd1: 
                begin
                    CA = 0;
                    CB = 0;
                    CC = 1;
                    CD = 1;
                    CE = 0;
                    CF = 0;
                    CG = 0;
                end
            4'd2: 
                begin
                    CA = 1;
                    CB = 1;
                    CC = 0;
                    CD= 1;
                    CE = 1;
                    CF = 0;
                    CG = 1;
                end
            4'd3:
                begin
                    CA = 0;
                    CB = 1;
                    CC = 1;
                    CD = 1;
                    CE = 1;
                    CF = 0;
                    CG = 1;
                end
            4'd4: 
                begin
                    CA = 0;
                    CB = 0;
                    CC = 1;
                    CD = 1;
                    CE = 0;
                    CF = 1;
                    CG = 1;
                end
            4'd5: 
                begin
                    CA = 0;
                    CB = 1;
                    CC = 1;
                    CD = 0;
                    CE = 1;
                    CF = 1;
                    CG = 1;
                end
            4'd6:  
                begin
                    CA = 1;
                    CB = 1;
                    CC = 1; 
                    CD = 0;
                    CE = 1;
                    CF = 1;
                    CG = 1;
                end
            4'd7: 
                begin
                    CA = 0;
                    CB = 0;
                    CC = 1;
                    CD = 1;
                    CE = 1;
                    CF = 0;
                    CG = 0;
                end
            4'd8: 
                begin
                    CA = 1;
                    CB = 1;
                    CC = 1;
                    CD = 1;
                    CE = 1;
                    CF = 1;
                    CG = 1;
                end
            4'd9:   
                begin
                    CA = 0;
                    CB = 1;
                    CC = 1;
                    CD = 1;
                    CE = 1;
                    CF = 1;
                    CG = 1;
                end
        endcase
    end

endmodule