`timescale 1ns / 1ps

module Shift_Register #(parameter REG_WIDTH = 8)
(
        input clk,
        input regClk,
        input [REG_WIDTH-1:0] inReg,
        input inBit,
        input EN,
        output reg outBit
);

reg [REG_WIDTH-1:0] inData;


always@(posedge regClk && EN)
begin
    inData <= inReg;
end

always@(posedge clk)
begin
           outBit <= inData[0];
           inData <= {inBit,inData[REG_WIDTH-1:1]};
end
endmodule