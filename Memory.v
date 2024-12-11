`timescale 1ns / 1ps

module Memory(
    input [2:0] rd_type,
    input [1:0] write_type,
    input write_en,
    input read_en,
    input [31:0] addr,
    input clk,
    input [31:0] wr_data,
    output [31:0] out
    );
    wire [31:0] write_temp;
    wire [31:0] read_temp;
    WDU WDU_0(.write_type(write_type),.wr_data(wr_data),.out(write_temp),.rd_data(read_temp));
    RAM RAM_0(.write_en(write_en),.read_en(read_en),.addr(addr),.write_data(write_temp),.read_data(read_temp),.clk(clk));
    RDU RDU_0(.data_in(read_temp),.rd_type(rd_type),.out(out));
endmodule
