# Fetch Components

## Instruction Queue - 10/30/2026

## Overview
The instruction queue is a parameterized, synchronous FIFO (First-In, First-Out) buffer used in the **RISC-V processor**. It temporarily stores fetched instructions and their corresponding program counters (PCs) before they are processed by downstream pipeline stages.

## Code
[instr_queue.sv](../rtl/instr_queue.sv)

## Architecture
- **Depth:** Configurable through the `DEPTH` parameter (default: 8 entries).
- **Data Storage:** Two 32-bit arrays store instructions and their corresponding PCs.
- **Head Pointer:** Tracks the next entry to be dequeued.
- **Tail Pointer:** Tracks the next available location for enqueueing.
- **Direction Bit (`dir`):** Distinguishes between full and empty conditions when the head and tail pointers are equal.

## Operation
All queue operations occur on the rising edge of the clock.

- **Enqueue:** When `enqueue` is asserted and the queue is not full, the instruction and PC are stored at the tail pointer, which then advances.
- **Dequeue:** When `dequeue` is asserted and the queue is not empty, the oldest instruction and PC are transferred to the registered outputs, and the head pointer advances.
- **Simultaneous Enqueue/Dequeue:** Both pointers advance, allowing an instruction to enter and another to leave the queue during the same cycle.
- **Reset:** Synchronously clears the head pointer, tail pointer, and direction bit, marking the queue as empty.

## Full and Empty Detection

The `dir` bit differentiates the two conditions:

```systemverilog
assign full  = (head_ptr == tail_ptr) && dir;
assign empty = (head_ptr == tail_ptr) && !dir;
```

Requests are accepted only when the corresponding operation is permitted:

```systemverilog
assign do_enqueue = enqueue && !full;
assign do_dequeue = dequeue && !empty;
```

## Design Considerations
- Registered outputs update when a valid dequeue occurs.
- The queue maintains FIFO ordering between fetched instructions and their PCs.
- Full and empty conditions prevent overflow and underflow.
- The current pointer implementation assumes a power-of-two queue depth.
- When full, an enqueue request is rejected even if a dequeue is requested simultaneously.

## Verification
The instruction queue is verified using a SystemVerilog testbench [instr_queue_tb.sv](../tb/instr_queue_tb.sv) covering reset behavior, enqueue/dequeue operations, full and empty conditions, simultaneous operations, and FIFO ordering.