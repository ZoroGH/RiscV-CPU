`timescale 1ns / 1ns
`include "instruction.vh"

module CPU_Top(
    input clk,
    input rst
);
wire clk;     
wire rst;     
wire clr;     
wire jmp_en;  
wire hold_en; 
wire [31:0] jmp_addr;
wire [31:0] ins;    

wire [6 :0] op;
wire [ 4:0] op_type;
wire [ 4:0] rs1;
wire [ 4:0] rs2;
wire [ 4:0] rd;
wire [31:0] offset;
wire [31:0] immediate;


fetch u_fetch(
    .clk      ( clk      ),
    .rst      ( rst      ),
    .clr      ( clr      ),
    .jmp_en   ( jmp_en   ),
    .hold_en  ( hold_en  ),
    .jmp_addr ( jmp_addr ),
    .ins      ( ins      )
);


decoder u_decoder(
    .instruction ( ins ),
    .op          ( op          ),
    .op_type     ( op_type     ),
    .rs1         ( rs1         ),
    .rs2         ( rs2         ),
    .rd          ( rd          ),
    .offset      ( offset      ),
    .immediate   ( immediate   )
);

wire [ 4:0] op_type_o;
wire [31:0] data1;
wire [31:0] data2;
wire [31:0] offset_o;
wire [31:0] immediate_o;

id_exe u_id_exe(
    .clk        ( clk       ),
    .rst        ( rst       ),
    .ins_i      ( ins       ),
    .ins_addr_i  (0         ),
    .op_type_i  ( op_type   ),
    .rs1        ( rs1       ),
    .rs2        ( rs2       ),
    .rd         ( rd        ),
    .offset_i   ( offset    ),
    .immediate_i( immediate ),
    .hold_en    ( hold_en   ),
    .ins_addr_o ( 0         ),
    .op_type_o  ( op_type_o ),
    .data1      ( data1     ),
    .data2      ( data2     ),
    .offset_o   ( offset_o  ),
    .immediate_o( immediate_o )
);

wire write_reg;
wire load_en;
wire store_en;
wire [31:0] mem_addr;
wire [31:0] mem_data;
wire jmp_en;
wire jmp_addr;
wire [31:0] res;

exe u_exe(
    .clk        ( clk       ),
    .rst        ( rst       ),
    .op_type    ( op_type_o ),
    .data1      ( data1     ),
    .data2      ( data2     ),
    .offset     ( offset_o  ),
    .immediate  ( immediate_o),
    .ins_addr   ( 0         ),
    .write_reg  ( write_reg ),
    .jmp_en     ( jmp_en    ),
    .jmp_addr   ( jmp_addr  ),
    .res        ( res       ),
    .clr        ( hold_en   )
);

endmodule