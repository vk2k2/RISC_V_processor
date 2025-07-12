`timescale 1ns / 1ps

module prog_counter(
    input [31:0] PC_next,
    output reg [31:0] PC_out,
    input clk,
    input rst
    );
    
    always @ (posedge clk)
        if (rst==1)
            PC_out <= 32'b0;
        else
            PC_out <= PC_next;
endmodule