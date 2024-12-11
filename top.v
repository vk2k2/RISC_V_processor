`timescale 1ns / 1ps

module top(input clk, input rst_in);
wire [31:0] instr;
wire [31:0] PC_next_wire;
wire [31:0] PC_wire; 
wire [31:0] PC_4_wire;
wire [31:0] PC_adder_result_wire;
wire [31:0] rs1_wire;
wire [31:0] if_jalr_op_wire;
wire [31:0] extendor_op_wire;
wire [31:0] result_op_wire;
wire [31:0] rs2_wire;
wire [31:0] alu_in_2_wire;
wire [31:0] alu_op_wire;
wire [31:0] mem_op_wire;
wire [31:0] auipc_adder_op;

wire clk_w;
wire rst;
wire PC_src_wire;
wire if_jalr_wire;
wire reg_wr_en_wire;
wire [2:0] imm_src_wire;
wire alu_src_wire;
wire [3:0] alu_ctrl_wire;
wire [4:0] flags;
wire mem_rd_en_wire;
wire mem_wr_en_wire;
wire [2:0] mem_rd_type_wire;
wire [1:0] mem_wr_type_wire;
wire [2:0] result_src_wire;

assign clk_w = clk;
assign rst = rst_in;

prog_counter PC(
    .PC_next(PC_next_wire),
    .PC_out(PC_wire),
    .clk(clk_w),
    .rst(rst)
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
    .Instruction(instr),
    .rst(rst)
    );
    
registers reg_file(
    .clk(clk_w),
    .rst(rst),
    .read_reg_1(instr[19:15]),
    .read_reg_2(instr[24:20]),
    .write_reg(instr[11:7]),
    .write_data(result_op_wire),
    .write_enable(reg_wr_en_wire),
    .read_data_1(rs1_wire),
    .read_data_2(rs2_wire)
    );

sign_extendor extendor(
    .in(instr[31:7]),
    .out(extendor_op_wire),
    .imm_src(imm_src_wire)
    );

mux_2to1 alusrc_mux(
    .a0(rs2_wire),
    .a1(extendor_op_wire),
    .select(alu_src_wire),
    .data_out(alu_in_2_wire)
    );    
    
ALU ALU_0(
    .in1(rs1_wire),
    .in2(alu_in_2_wire),
    .ALU_ctrl(alu_ctrl_wire),
    .ALU_out(alu_op_wire),
    .greater(flags[4]),
    .lesser(flags[3]),
    .equal(flags[2]),
    .greater_u(flags[1]),
    .lesser_u(flags[0])
    );
    
controller controller_0(
    .opcode(instr[6:0]),
    .func3(instr[14:12]),
    .func7(instr[31:25]),
    .greater_flag(flags[4]),
    .lesser_flag(flags[3]),
    .equal_flag(flags[2]),
    .greater_u_flag(flags[1]),
    .lesser_u_flag(flags[0]),
    .pc_src(PC_src_wire),
    .if_jalr(if_jalr_wire),
    .reg_wr_en(reg_wr_en_wire),
    .result_src(result_src_wire), 
    .immediate_src(imm_src_wire), 
    .alu_src(alu_src_wire),
    .alu_ctrl(alu_ctrl_wire),
    .mem_rd_en(mem_rd_en_wire),
    .mem_wr_en(mem_wr_en_wire),
    .mem_rd_type(mem_rd_type_wire),
    .mem_wr_type(mem_wr_type_wire)
    );

Memory mem_0(
    .rd_type(mem_rd_type_wire),
    .write_type(mem_wr_type_wire),
    .write_en(mem_wr_en_wire),
    .read_en(mem_rd_en_wire),
    .addr(alu_op_wire),
    .clk(clk_w),
    .wr_data(rs2_wire),
    .out(mem_op_wire)
    );
    
simple_adder auipc_adder(
    .in1(extendor_op_wire),
    .in2(PC_wire),
    .result(auipc_adder_op)
    );
    
mux5to1 result_mux(
    .a0(alu_op_wire),
    .a1(PC_4_wire),
    .a2(mem_op_wire),
    .a3(extendor_op_wire),
    .a4(auipc_adder_op),
    .out(result_op_wire),
    .select(result_src_wire)
    );
endmodule
