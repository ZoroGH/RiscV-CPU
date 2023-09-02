module test_top_tb;
    // 时钟生成
    reg clk;
    always begin
        #5 clk = ~clk;
    end

    // 信号初始化
    reg rst;
    reg clr;
    reg [31:0] ins;
    wire [31:0] final_ins_addr;

    // 模块实例化
    test_top dut (
        .clk(clk),
        .rst(rst),
        .clr(clr),
        .ins(ins),
        .final_ins_addr(final_ins_addr)
    );

    // 测试用例
    initial begin
        clk = 0;
        rst = 0;
        clr = 0;
        ins = 32'h12345678; // 请根据需要设置输入指令

        // 在时钟上升沿之前将复位信号保持低电平
        rst = 0;
        #10 rst = 1;

        // 在时钟上升沿之前将清除信号保持低电平
        clr = 0;
        #10 clr = 1;

        // 在时钟上升沿之前取消复位和清除信号
        #10 rst = 0;
        #10 clr = 0;

        // 时钟驱动
        #5 clk = 1;
        #5 clk = 0;

        // 监视输出信号
        $display("final_ins_addr = %h", final_ins_addr);

        // 添加更多的测试用例，重复以上步骤
    end

    // 模拟时钟
    always begin
        #2 clk = ~clk;
    end
endmodule
