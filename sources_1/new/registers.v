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
    
    always @(posedge clk, posedge rst)
    if (rst) begin 
    mem[0] <= 0;
    mem[1] <= 0;
    mem[2] <= 0;
    mem[3] <= 0;
    mem[4] <= 0;
    mem[5] <= 0;
    mem[6] <= 0;
    mem[7] <= 0;
    mem[8] <= 0;
    mem[9] <= 0;
    mem[10] <= 0;
    mem[11] <= 0;
    mem[12] <= 0;
    mem[13] <= 0;
    mem[14] <= 0;
    mem[15] <= 0;
    mem[16] <= 0;
    mem[17] <= 0;
    mem[18] <= 0;
    mem[19] <= 0;
    mem[20] <= 0;
    mem[21] <= 0;
    mem[22] <= 0;
    mem[23] <= 0;
    mem[24] <= 0;
    mem[25] <= 0;
    mem[26] <= 0;
    mem[27] <= 0;
    mem[28] <= 0;
    mem[29] <= 0;
    mem[30] <= 0;
    mem[31] <= 0;
    end
    else
        if (write_enable) 
            mem[write_reg] <= write_data;
            //add rst code
        
assign read_data_1 = (rst == 0)?((read_reg_1 != 0) ? mem[read_reg_1] : 0) : 32'bx;
assign read_data_2 = (rst == 0)?((read_reg_2 != 0) ? mem[read_reg_2] : 0) : 32'bx;
endmodule

