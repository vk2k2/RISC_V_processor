`timescale 1ns / 1ps

module Memory(
    input [2:0] rd_type,
    input [1:0] write_type,
    input write_en,
    input read_en,
    input [31:0] addr,
    input clk,
    input [31:0] wr_data,
    input [18:0] switches_and_buttons,
    output sound_L,
    output sound_R,
    output [15:0] LEDs,
    output [2:0] RBG_0,
    output [2:0] RBG_1,
    output [31:0] out,
    input rst
    );
    wire [31:0] write_temp;
    wire [31:0] read_temp;
    wire [31:0] RDU_out;
    wire mux_src;
    wire [31:0] mux_temp;
    WDU WDU_0(.write_type(write_type),.wr_data(wr_data),.out(write_temp),.rd_data(read_temp));
    RAM RAM_0(.write_en(write_en),.read_en(read_en),.addr(addr),.write_data(write_temp),.read_data(read_temp),.clk(clk));
    RDU RDU_0(.data_in(read_temp),.rd_type(rd_type),.out(RDU_out));
    mux_2to1 out_src_mux(
    .a0(RDU_out),
    .a1(mux_temp),
    .select(mux_src),
    .data_out(out)
    );
    io_block io_block_0(.wr_data(wr_data[15:0]),.write_en(write_en),.read_en(read_en),.addr(addr),
    .sound_L(sound_L),
    .sound_R(sound_R),
    .LEDs(LEDs),
    .RBG_0(RBG_0),
    .RBG_1(RBG_1),
    .switches_and_buttons(switches_and_buttons),
    .switches_and_buttons_32b(mux_temp),
    .io_vld(mux_src),
    .clk(clk),
    .rst(rst)
    );
    
endmodule
