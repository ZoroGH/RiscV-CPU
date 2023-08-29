# RiscV-CPU
This repo is for little term, the goal is to develop a risc-v based cpu with pipeline struct

## Update Log
- ZoroGH, Init
## Module interface definition
Fetch
```verilog
input clk,
input rst,
input clr,
input jmp,
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
input opcode,
input rs1,
input rs2,
input rd,
input offset,
input immediate,

output read_en,
output read_addr,
input [31:0] read_data,

output write_addr,
output write_en,// read or write
output [31:0] write_data,


output [31:0] addr,
input  [31:0] data,
output [31:0] write_data,
output write_read,

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