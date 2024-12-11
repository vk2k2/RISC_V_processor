`timescale 1ns / 1ps

module testbench;
reg clk, rst;
top dut(clk, rst);

initial begin
rst<=1; #50
rst<=0;
end

initial clk = 0;

always #10 clk = ~clk;



endmodule
