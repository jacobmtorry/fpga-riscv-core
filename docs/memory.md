## Unified Main Memory (BRAM) - 10/10/2026
The unified memory consists of 64 KiB of FPGA Block RAM, organized as 16.384 words of 32 bits each.

A 32-Bit RISC-V address is divided as follows:
- Bits [31:16]: Memory region validation
- Bits [15:2]: 14-bit BRAM word index
- Bits [1:0]: Byte offset within the 32-bit word

The memory is implemented using Vivado's Block RAM inference, following AMD's *Vivado Design SUite User Guide: Synthesis (UG901)*. Rather than explicitly instantiating Xilinz BRAM primitives, the memory is described in SystemVerilog using a synchronous read/write structure and the ` (* ram_style = "block" *) ` synthesis attribute. Vivado automatically maps the memory array to dedicated FPGA BRAM resorces.