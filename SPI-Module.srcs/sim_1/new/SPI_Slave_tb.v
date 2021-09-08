`timescale 1ns / 1ps


module SPI_Slave_tb();

parameter REG_WIDTH = 8;

reg clk;
reg [REG_WIDTH-1:0] dataToSend;
reg MOSI;
reg SS;
wire MISO;

initial begin
clk = 1;
dataToSend = 0;
MOSI = 0;
SS = 1;
end

SPI_Slave #(8) Slave_DUT (.clk(clk),
                          .dataToSend(dataToSend),
                          .MOSI(MOSI),
                          .SS(SS),
                          .MISO(MISO));
                          
always #10 clk = ~clk;

initial begin
SS = 1'b1;
dataToSend = 8'b01010101;
#20
MOSI = 1'b1;
SS = 1'b0;
end

initial begin
#1000
$finish;
end

endmodule