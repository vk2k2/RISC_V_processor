`timescale 1ns / 1ps

//each instruction 32bit, next instruction at PC+1 

// how to instantiate the instructions to mem?

module Instruction_mem(
    input [31:0] PC,
    output [31:0] Instruction,
    input rst
    );
    reg [7:0] mem [63:0];
    
    initial
    begin
      $readmemb("program.mem",mem);
    end
    
    assign Instruction = (rst == 0)? {mem[PC],mem[PC+1],mem[PC+2],mem[PC+3]} : 32'bz;

    
endmodule
