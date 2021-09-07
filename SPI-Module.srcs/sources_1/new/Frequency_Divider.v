`timescale 1ns / 1ps

module Frequency_Divider #(parameter [3:0] clockPrescaler = 4'b0010)
(
    input clk,
    input EN,
    output reg SCLK
);

reg [3:0] counter;
reg flag;

initial begin
counter = 4'b0000;
SCLK = 0;
end

always@(posedge clk)
begin
    if (EN == 1'b1)
        SCLK <= 0;
        
    else if (clockPrescaler == 4'b0001)
        begin
            SCLK <= 1;
        end
    else if (counter == (clockPrescaler/2)-1)
        begin
        SCLK = ~ SCLK;
        counter <= 0;
        end
    else
        begin
        counter = counter + 1;
        end
end

always@(negedge clk)
begin
    if (clockPrescaler == 4'b0001)
        SCLK <= 0;
    else
        SCLK <= SCLK;
end
endmodule
