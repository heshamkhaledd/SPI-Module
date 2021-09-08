`timescale 1ns / 1ps

module SPI_Master_tb();

parameter REG_WIDTH = 8;

reg clk;
reg [REG_WIDTH-1:0] dataToSend;
reg MISO;
reg spiInit;
wire SS;
wire SCLK;
wire MOSI;

initial begin
clk = 1;
dataToSend = 0;
MISO = 1;
spiInit = 0;
end

SPI_Master #(1,8) Master_DUT ( .clk(clk),
                               .dataToSend(dataToSend),
                               .MISO(MISO),
                               .spiInit(spiInit),
                               .SS(SS),
                               .SCLK(SCLK),
                               .MOSI(MOSI));
                   
always #10 clk = ~clk;
initial begin
#20
spiInit = 1;
dataToSend = 8'b01010101;
end

initial begin
#1000
$finish;
end

endmodule