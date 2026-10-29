`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jacob Torry
// Create Date: 10/12/2026 
//
// Description: This is the top level that connects CPU to BRAM. This is what is
//    instanited in tob_tb.sv in order to test the CPU.
//
//////////////////////////////////////////////////////////////////////////////////

module top(
    input logic clk,
    input logic rst
);


// imem wires
logic imem_en;
logic [31:0] imem_addr;
logic [31:0] imem_rdata;

cpu cpu_inst(
    .clk(clk),
    .rst(rst),

    // imem signals
    .imem_rdata(imem_rdata),

    .imem_en(imem_en),
    .imem_addr(imem_addr)
);

bram bram_inst(
    .clk(clk),
    .we(1'b0),
    .en(imem_en),

    .addr(imem_addr[15:2]),
    .din(32'b0),

    .dout(imem_rdata)
);
    
endmodule