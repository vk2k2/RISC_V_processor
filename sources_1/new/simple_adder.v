`timescale 1ns / 1ps


module simple_adder(
    input [31:0] in1,
    input [31:0] in2,
    output [31:0] result
    );
    
    assign result = in1 + in2;
endmodule
