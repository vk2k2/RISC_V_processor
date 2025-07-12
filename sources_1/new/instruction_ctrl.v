`timescale 1ns / 1ps



module instruction_ctrl(
    output [31:0] Instruction,
    output [31:0] PC_add_4_result,
    output [31:0] auipc_result,
    input  [31:0] extender_op,
    input  [31:0] rs_1,
    input PC_src,
    input if_jalr,
    input clk,
    input rst_in
    );
    
wire [31:0] PC_next_wire;
wire [31:0] PC_wire; 
wire [31:0] PC_adder_result_wire;
wire [31:0] if_jalr_op_wire;

wire [31:0] PC_4_wire;
assign PC_add_4_result = PC_4_wire;

wire clk_w;
wire rst;
wire PC_src_wire;
wire if_jalr_wire;
wire [31:0] rs1_wire;
wire [31:0] extendor_op_wire;

assign clk_w = clk;
assign rst = rst_in;
assign PC_src_wire = PC_src;
assign if_jalr_wire = if_jalr;
assign rs1_wire = rs_1;
assign extendor_op_wire = extender_op;
    
prog_counter PC(
    .PC_next(PC_next_wire),
    .PC_out(PC_wire),
    .rst(rst),
    .clk(clk_w)
    );
    
mux_2to1 PC_src_mux(
    .a0(PC_4_wire),
    .a1(PC_adder_result_wire),
    .select(PC_src_wire),
    .data_out(PC_next_wire)
    ); 
    
add_4_to_PC PC_next(
    .PC_in(PC_wire),
    .PC_out(PC_4_wire)
    ); 

mux_2to1 if_jalr_mux(
    .a0(PC_wire),
    .a1(rs1_wire),
    .select(if_jalr_wire),
    .data_out(if_jalr_op_wire)
    ); 
    
simple_adder simple_adder_PC(
    .in1(if_jalr_op_wire),
    .in2(extendor_op_wire),
    .result(PC_adder_result_wire)
    );

Instruction_mem Instruction_mem_0(
    .PC(PC_wire),
    .Instruction(Instruction)
    );
    
simple_adder auipc_adder(
    .in1(extendor_op_wire),
    .in2(PC_wire),
    .result(auipc_result)
    );
endmodule
