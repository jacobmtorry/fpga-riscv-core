`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jacob Torry
// Create Date: 10/12/2026 
//////////////////////////////////////////////////////////////////////////////////

module cpu (
    input   logic   clk,
    input   logic   rst,

    // imem signals
    input   logic   [31:0]  imem_rdata,

    output  logic   imem_en,
    output  logic   [31:0]  imem_addr
);

assign imem_en = 1'b1;
assign imem_addr = 32'h00000000;

    
endmodule
