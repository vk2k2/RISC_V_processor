`timescale 1ns / 1ps

module io_block(
    input [15:0] wr_data,
    input write_en,
    input read_en,
    input [31:0] addr,
    input [18:0] switches_and_buttons,
    output [31:0] switches_and_buttons_32b,
    output reg sound_L,
    output reg sound_R,
    output reg [15:0] LEDs,
    output reg [2:0] RBG_0,
    output reg [2:0] RBG_1,
    output io_vld,
    input clk,
    input rst
    );
    // upto addr = 23 only

assign switches_and_buttons_32b = {13'b0,switches_and_buttons[18:0]};
assign io_vld = (read_en && (addr == 19)) ? 1'b1 : 1'b0;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset all output ports when reset signal is active
        sound_L <= 1'b0;
        sound_R <= 1'b0;
        LEDs <= 16'b0;
        RBG_0 <= 3'b0;
        RBG_1 <= 3'b0;
    end 
    else begin


        if (write_en) begin
            case (addr)
                0: LEDs <= wr_data[15:0]; 
                3: sound_L <= wr_data[0]; 
                7: sound_R <= wr_data[0]; 
                11: RBG_0 <= wr_data[2:0]; 
                15: RBG_1 <= wr_data[2:0]; 
                default: ; // Do nothing for other addresses
            endcase
        end
    end
end

endmodule
