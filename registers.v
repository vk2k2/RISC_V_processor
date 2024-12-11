`timescale 1ns / 1ps

// three ported register file
// read two ports combinationally (read_reg_1,2)
// write third port on rising edge of clock (write_reg/write_enable)
// register 0 hardwired to 0

module registers(
    input clk,
    input rst,
    input [4:0] read_reg_1,
    input [4:0] read_reg_2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input write_enable,
    output [31:0] read_data_1,
    output [31:0] read_data_2
    );
    
    reg [31:0] mem [31:0];
    
    always @(posedge clk, negedge rst)
    if (rst == 0)
        if (write_enable) 
            mem[write_reg] <= write_data;
            //add rst code
        
assign read_data_1 = (rst == 0)?((read_reg_1 != 0) ? mem[read_reg_1] : 0) : 32'bx;
assign read_data_2 = (rst == 0)?((read_reg_2 != 0) ? mem[read_reg_2] : 0) : 32'bx;
endmodule