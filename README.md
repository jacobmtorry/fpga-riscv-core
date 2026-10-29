# RISC-V Out-of-Order Processor

A custom 32-bit out-of-order RISC-V processor designed in SystemVerilog and targeting Xilinx FPGA hardware.

### Project Structure

- **`rtl/`** — SystemVerilog design modules.
- **`tb/`** — Testbenches and verification.
- **`docs/`** — Architecture documentation and design notes.
- **`programs/`** - Different Hex programs for testing and running

### Development

The processor is currently under development, beginning with instruction fetch and a 64 KiB unified memory implemented using Vivado-inferred Block RAM.

Planned features include branch prediction, reservation stations, a reorder buffer (ROB), load/store execution, and separate L1 instruction and data caches, and VGA-to-HDMI driven output for performance metrics.

Maybe eventually support linux idk.