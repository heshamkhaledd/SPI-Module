`timescale 1ns / 1ps

module Shift_Register #(parameter REG_WIDTH = 8)
(
        input clk,
        input [REG_WIDTH-1:0] inReg,
        input inBit,
        input EN, //Always low on operation
        output reg outBit
);

reg [REG_WIDTH-1:0] inData;


always@(posedge clk)
begin
    if (!EN)
        begin
            outBit <= inData[0];
            inData <= {inBit,inData[REG_WIDTH-1:1]};
        end
    else
        inData <= inReg;
end
endmodule
