`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jacob Torry
// Create Date: 10/10/2026 05:41:39 PM
//
// Notes:
//  64 KiB -> 64 * 1024 = 65536 bytes
//  65536 / 4 = 16384 words
//  log_2(16384) = 14 bits for addr
//
//////////////////////////////////////////////////////////////////////////////////


module bram(
    input   logic   clk,
    input   logic   we,
    input   logic   en,

    input   logic   [13:0]  addr,
    input   logic   [31:0]  din,

    output  logic   [31:0]  dout    
);

// Vivado Design Suit User Guide on Memory Inference
(* ram_style = "block" *) logic [31:0] ram [16383:0];

initial begin
    $readmemh("program.mem", ram);
end

always_ff @( posedge clk ) begin
    if (en) begin
        if (we) begin
            ram[addr] <= din;
        end
        dout <= ram[addr];  
    end
end

endmodule

