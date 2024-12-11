`timescale 1ns / 1ps

module add_4_to_PC(
    input [31:0] PC_in,
    output [31:0] PC_out
    );
    
    assign PC_out = PC_in + 'd4;
endmodule
