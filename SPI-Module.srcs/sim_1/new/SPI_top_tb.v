`timescale 1ns / 1ps

module SPI_top_tb();

parameter REG_WIDTH = 8;

reg clk;
reg [REG_WIDTH-1:0] masterData;
reg [REG_WIDTH-1:0] slaveData;
reg spiInit;


initial begin
clk = 1;
masterData = 0;
slaveData = 0;
spiInit = 0;
end

SPI_top #(8) top_DUT (.clk(clk),
                      .masterData(masterData),
                      .slaveData(slaveData),
                      .spiInit(spiInit));
             
always #10 clk = ~clk;
         
initial begin
masterData = 8'b01010101;
slaveData = 8'b11111111;
#20
spiInit = 1;
end

initial begin
#1000
$finish;
end
endmodule