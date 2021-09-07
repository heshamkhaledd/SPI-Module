`timescale 1ns / 1ps

module Frequency_Divider_tb();

reg clk;
wire SCLK;


Frequency_Divider DUT (.clk(clk),
                       .SCLK(SCLK));

always #10 clk = ~clk;

initial begin
clk = 0;
end

initial begin
#1000
$finish;
end


endmodule
