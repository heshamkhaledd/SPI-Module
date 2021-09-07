`timescale 1ns / 1ps

module SPI_Master_tb();

parameter REG_WIDTH = 8;

reg clk;
reg [REG_WIDTH-1:0] dataToSend;
reg inBit;
reg MISO;
wire SS;
wire SCLK;
wire MOSI;

initial begin
clk = 0;
dataToSend = 0;
inBit = 0;
MISO = 0;
end

SPI_Master #(1,8) Master_DUT ( .clk(clk),
                               .dataToSend(dataToSend),
                               .inBit(inBit),
                               .MISO(MISO),
                               .SS(SS),
                               .SCLK(SCLK),
                               .MOSI(MOSI));
                   
initial begin
#20
dataToSend = 8'b01010101;
end

initial begin
#1000
$finish;
end

endmodule