# RiscV-CPU
This repo is for little term, the goal is to develop a risc-v based cpu with pipeline struct

## Author

ZoroGH, Changhao Du, LBW, Fishko.

## Update Log
- ZoroGH, Init
- LBW, update instructions & jmp, 20230830

## Instructions

- add
- sub
- addi
- mul
- mulh
- beq
- bne
- blt
- bge
- jal
- sw
- lw
- xor
- and
- or
- lui
- auipc



## Module interface definition
Fetch
```verilog
input clk,
input rst,
input clr,
input jmp_en,
input jmp_addr,
// ouptut 
output [31:0] ins
```

Decode
```verilog
input clk,
input rst,
input clr,
input [31:0] ins,
output opcode,
output rs1,
output rs2,
output rd,
output offset,
output immediate
```


Execute
```verilog
    input clk,
    input rst,
    input [4:0] optype,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] offset,
    input [31:0] immediate,

    output [31:0] mem_addr,     // addr for load or store
    input  [31:0] mem_data,     // data from mem(for load)
    output [31:0] write_data,   // data to mem (for store)
    output load_en,
    output store_en,

    output jmp_en,
    output jmp_addr,

    output res,// result
    output clr

```


----
## TODO List

- [ ] state machine 
- [ ] waveform graph
- [ ] interface
- [ ] simulation result



## Resource

- [wave](https://wavedrom.com/)
- [state machine](https://www.writebug.com/article/933fcc89-c790-11ed-a37d-6479f0e5e323)
- [tiny_riscv](https://liangkangnan.gitee.io/2020/04/29/%E4%BB%8E%E9%9B%B6%E5%BC%80%E5%A7%8B%E5%86%99RISC-V%E5%A4%84%E7%90%86%E5%99%A8/)

![diagram](https://liangkangnan.gitee.io/2020/04/29/%E4%BB%8E%E9%9B%B6%E5%BC%80%E5%A7%8B%E5%86%99RISC-V%E5%A4%84%E7%90%86%E5%99%A8/2_0.jpg)
