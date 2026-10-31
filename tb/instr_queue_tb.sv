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

    logic empty, full;
    logic enqueue, dequeue;
    logic [31:0] instr_in, pc_in;
    logic [31:0] instr_out, pc_out;    

    task automatic test_enqueue(input logic [31:0] test_pc_en, input logic [31:0] test_instr_en);
        @(negedge clk);
        pc_in    = test_pc_en;
        instr_in = test_instr_en;
        enqueue  = 1'b1;
        @(negedge clk);
        enqueue  = 1'b0;
    endtask

    task automatic test_en_and_de(input logic [31:0] test_pc, input logic [31:0] test_instr);
        @(negedge clk);
        pc_in    = test_pc;
        instr_in = test_instr;
        enqueue  = 1'b1;
        dequeue  = 1'b1;
        @(negedge clk);
        enqueue  = 1'b0;
        dequeue  = 1'b0;
    endtask
    
    initial begin

        enqueue  = 1'b0;
        dequeue  = 1'b0;
        instr_in = '0;
        pc_in    = '0;
    
        repeat (5) @(posedge clk);
        @(negedge clk);
        rst = 0;
        
        // enqueue testing
        test_enqueue(32'h00000000, 32'h00000000);

        // dequeue test with empty check
        @(negedge clk);
        dequeue = 1'b1;

        @(posedge clk);
        #1;

        assert (pc_out === 32'h00000000) 
            else   $display("ERROR: PC mismatch");
        assert (instr_out === 32'h00000000) 
            else   $display("ERROR: Instr mismatch");
        assert (empty)
            else  $display("ERROR: should be empty");
            
        @(negedge clk);
        dequeue  = 1'b0;
        
        // test full condition
        test_enqueue(32'h00000001, 32'h00000001);
        test_enqueue(32'h00000002, 32'h00000002);
        test_enqueue(32'h00000003, 32'h00000003);
        test_enqueue(32'h00000004, 32'h00000004);
        test_enqueue(32'h00000005, 32'h00000005);
        test_enqueue(32'h00000006, 32'h00000006);
        test_enqueue(32'h00000007, 32'h00000007);
        test_enqueue(32'h00000008, 32'h00000008);
        assert (full) 
            else   $display("ERROR: should be full");

        // test simultaneous enqueue and dequeue
        test_en_and_de(32'hdeadbeef, 32'hdeadbeef);
        assert (full)
            else $display("ERROR: Simultaneous Enqueue and Dequeue");

        // dequque all 8 entries
        for(int i = 0; i < 8; i++) begin
            @(negedge clk);
            dequeue = 1'b1;
            @(negedge clk);
            dequeue  = 1'b0;
        end
        
        repeat (5) @(posedge clk);
        $finish;
    end
    
endmodule
