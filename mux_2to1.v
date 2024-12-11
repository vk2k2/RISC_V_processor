`timescale 1ns / 1ps


module mux_2to1(
    input [31:0] a0,
    input [31:0] a1,
    input select,
    output [31:0] data_out
    );
    
    assign data_out = (select)? a1 : a0;
endmodule
