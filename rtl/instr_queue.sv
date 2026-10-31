`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jacob Torry
// Create Date: 10/13/2026 09:12:50 PM
// Module Name: instr_queue
// Project Name: KHONSU
//////////////////////////////////////////////////////////////////////////////////


module instr_queue #(
    parameter DEPTH=8
)
(
    input   logic   clk,
    input   logic   rst,

    input   logic   enqueue,
    input   logic   dequeue,
    input   logic   [31:0]  instr_in,
    input   logic   [31:0]  pc_in,

    output  logic   full,
    output  logic   empty,
    output  logic   [31:0]  instr_out,
    output  logic   [31:0]  pc_out
);
    
logic dir;
logic do_enqueue;
logic do_dequeue;

logic [$clog2(DEPTH)-1:0] head_ptr, tail_ptr;

logic [31:0] pc_queue [DEPTH-1:0];
logic [31:0] instr_queue [DEPTH-1:0];

assign full = (head_ptr == tail_ptr) && dir;
assign empty = (head_ptr == tail_ptr) && !dir;

assign do_enqueue = enqueue && (!full || do_dequeue);
assign do_dequeue = dequeue && !empty;

always_ff @( posedge clk ) begin
    if (rst) begin
        dir      <= '0;
        head_ptr <= '0;
        tail_ptr <= '0;
        pc_queue <= '{default: 0};
        instr_queue <= '{default: 0};
    end else begin

        // only enqueue
        if (do_enqueue && !do_dequeue) begin
            dir <= 1'b1;
            tail_ptr <= tail_ptr + 1'b1;
            pc_queue[tail_ptr] <= pc_in;
            instr_queue[tail_ptr] <= instr_in;
        end 

        // only dequeue
        else if (do_dequeue && !do_enqueue) begin
            dir <= 1'b0;
            head_ptr <= head_ptr + 1'b1;
            pc_out <= pc_queue[head_ptr];
            instr_out <= instr_queue[head_ptr];
        end

        // same time enqueue and dequeue
        else if (do_enqueue && do_dequeue) begin
            tail_ptr <= tail_ptr + 1'b1;
            head_ptr <= head_ptr + 1'b1;

            pc_queue[tail_ptr] <= pc_in;
            instr_queue[tail_ptr] <= instr_in;
            
            pc_out <= pc_queue[head_ptr];
            instr_out <= instr_queue[head_ptr];
        end
    end
end
    
endmodule
