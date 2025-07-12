`timescale 1ns / 1ps

module clock_divider(
    input clk_in,    // 100 MHz input clock
    input reset,     // Asynchronous reset
    output reg clk_out // 10 MHz output clock
);

    reg [3:0] counter;  // 4-bit counter to divide by 10

    // Asynchronous reset and clock division logic
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 4'b0000;  // Reset counter
            clk_out <= 1;        // Reset output clock
        end
        else 
        begin
            if (counter == 4) 
            begin
                clk_out <= ~clk_out; // Toggle the output clock every 10 cycles
                counter <= 4'b0000;  // Reset counter
            end 
            else 
            begin
                counter <= counter + 1; // Increment the counter
            end
        end
    end
endmodule
