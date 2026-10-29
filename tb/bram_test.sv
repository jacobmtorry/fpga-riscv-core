`timescale 1ns / 1ps

module tb_single_port_bram;

    logic clk = 0;
    logic en = 0;
    logic we = 0;

    logic [13:0] addr = 0;
    logic [31:0] din = 0;
    logic [31:0] dout;

    // Instantiate DUT
    bram dut (
        .clk(clk),
        .en(en),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // 100 MHz clock
    always #5 clk = ~clk;

    initial begin
        
        #10
        
        $finish;

    end

endmodule