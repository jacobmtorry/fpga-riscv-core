`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jacob Torry
// Create Date: 10/28/2026 09:25:24 PM
// Module Name: instr_queue_tb
// Project Name: KHONSU
//////////////////////////////////////////////////////////////////////////////////


module instr_queue_tb;

    logic clk = 0;
    logic rst = 1;

    always #5 clk = ~clk;
    
    instr_queue #( .DEPTH(8)) dut (
        .clk(clk),
        .rst(rst),

        .enqueue(enqueue),
        .dequeue(dequeue),
        .instr_in(instr_in),
        .pc_in(pc_in),

        .full(full),
        .empty(empty),
        .instr_out(instr_out),
        .pc_out(pc_out)
    );

    logic enqueue, dequeue;
    logic [31:0] instr_in, pc_in;   
    
    initial begin

        enqueue  = 1'b0;
        dequeue  = 1'b0;
        instr_in = '0;
        pc_in    = '0;
    
        repeat (5) @(posedge clk);
        @(negedge clk);
        rst = 0;

        assert (empty) 
        else    $error("Queue Not Initialized to empty");
        
        // Push one
        @(negedge clk);
        pc_in    = 32'h00000000;
        instr_in = 32'h00000000;
        enqueue  = 1'b1;
        @(negedge clk);
        enqueue  = 1'b0;

        // Push two
        @(negedge clk);
        pc_in    = 32'h00000001;
        instr_in = 32'h00000001;
        enqueue  = 1'b1;
        @(negedge clk);
        enqueue  = 1'b0;
        
        repeat (5) @(posedge clk);
        $finish;
    end
    
endmodule
