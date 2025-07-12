`timescale 1ns / 1ps

module testbench;
reg clk, rst;
    reg [18:0] switches_and_buttons;
    wire sound_L;
    wire sound_R;
    wire [15:0] LEDs;
    wire [2:0] RBG_0;
    wire [2:0] RBG_1;
    
top dut(clk, rst, switches_and_buttons, sound_L, sound_R, LEDs, RBG_0, RBG_1);

initial begin
rst<=1; #300
rst<=0;
end

initial clk = 0;

always #5 clk = ~clk;

initial begin
    switches_and_buttons <= 19'b0000000000000000000; #   6000
    switches_and_buttons <= 19'b0010000000000000010; #  10000
    switches_and_buttons <= 19'b0000000000000000110; #  20000
    switches_and_buttons <= 19'b0010000000000000001; #  20000
    switches_and_buttons <= 19'b0100000000000001110; #  20000
    switches_and_buttons <= 19'b1000000001000000111; #  20000
    switches_and_buttons <= 19'b1100000000000000011; #  20000
    switches_and_buttons <= 19'b0000000000000000100; 

end

endmodule
