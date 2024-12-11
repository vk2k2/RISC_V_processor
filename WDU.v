`timescale 1ns / 1ps

module WDU(
    input [31:0] wr_data,
    input [31:0] rd_data,
    input [1:0] write_type,
    output reg [31:0] out
    );
    always@*
    case (write_type)
        'h0: out = {rd_data[31:8],wr_data[7:0]};    // store byte
        'h1: out = {rd_data[31:16],wr_data[15:0]};   // store half word
        'h2: out = wr_data;   // store word
        default: out = rd_data;
    endcase
endmodule
