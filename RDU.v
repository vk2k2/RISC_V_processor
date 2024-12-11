`timescale 1ns / 1ps

module RDU(
    input [31:0] data_in,
    input [2:0] rd_type,
    output reg [31:0] out
    );
    
    always@*
    case(rd_type)
        'h0: out = {{24{data_in[7]}},data_in[7:0]};  //read byte (sign extended)
        'h1: out = {{16{data_in[15]}},data_in[15:0]};  //read half (sign extended)
        'h2: out = data_in;  //read word
        'h4: out = {{24{1'b0}},{data_in[7:0]}};  //read byte unsigned
        'h5: out = {{16{1'b0}},{data_in[15:0]}};  //read half unsigned
        default: out = 32'bx;
    endcase    
endmodule
