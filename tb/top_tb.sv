`timescale 1ns / 1ps

module top_tb;

    logic clk = 0;
    logic rst = 1;

    // 100 MHz clock
    always #5 clk = ~clk;

    // Instantiate DUT
    top dut (
        .clk(clk),
        .rst(rst)
    );


    initial begin
        repeat (5) @(posedge clk);
        @(negedge clk);
        rst = 0;

        repeat (1000) @(posedge clk);

        $finish;
    end

endmodule