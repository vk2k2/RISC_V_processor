`timescale 1ns / 1ps

module mux5to1(
    input [31:0] a0,
    input [31:0] a1,
    input [31:0] a2,
    input [31:0] a3,
    input [31:0] a4,
    output reg [31:0] out,
    input [2:0] select
    );
    
    always@*
    case (select)
    'd0: out = a0;
    'd1: out = a1;
    'd2: out = a2;
    'd3: out = a3;
    'd4: out = a4;
    default: out = 'bx;
    endcase
endmodule
