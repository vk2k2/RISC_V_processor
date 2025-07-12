`timescale 1ns / 1ps
//byte adressable RAM with read word/half/byte signed or unsigned extended
//note: keeping this only for mem, adding stuff to deal with bit extending, byte read and write and others outside 

module RAM(
    input write_en,
    input read_en,
    input [31:0] addr,
    input [31:0] write_data,
    output [31:0] read_data,
    input clk 
    );
    reg [7:0] mem [63:0];
    
    initial begin $readmemb("ram_data.mem",mem); end
    
    assign read_data = (read_en == 1 & addr>23)? {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]} : 32'bz;
    
    always @ (posedge clk)
        if (write_en & addr>23)
            {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]} <= write_data; 
endmodule



