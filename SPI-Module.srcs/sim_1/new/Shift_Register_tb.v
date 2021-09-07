`timescale 1ns / 1ps


module Shift_Register_tb();

parameter REG_WIDTH = 8;

reg clk;
reg [REG_WIDTH-1:0] inReg;
reg inBit;
reg EN;
wire outBit;

initial begin
clk = 1;
inReg = 0;
inBit = 0;
EN = 1;
end

Shift_Register#(8) DUT (.clk(clk),
                        .inReg(inReg),
                        .inBit(inBit),
                        .EN(EN),
                        .outBit(outBit)
                                        );

always #10 clk = ~clk;

initial begin
inReg = 8'b01010101;
#20
EN = 0;
inBit = 1;
end

initial begin
#1000
$finish;

end
endmodule
