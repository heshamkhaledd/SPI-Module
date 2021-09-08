`timescale 1ns / 1ps

module SPI_top_tb();

parameter REG_WIDTH = 8;

reg masterClk;
reg slaveClk1;
reg slaveClk2;
reg slaveClk3;
reg [REG_WIDTH-1:0] masterData;
reg [REG_WIDTH-1:0] slaveData_1;
reg [REG_WIDTH-1:0] slaveData_2;
reg [REG_WIDTH-1:0] slaveData_3;
reg spiInit;


initial begin
masterClk = 1;
slaveClk1 = 0;
slaveClk2 = 0;
slaveClk3 = 0;
masterData = 0;
slaveData_1 = 0;
slaveData_2 = 0;
slaveData_3 = 0;
spiInit = 0;
end

SPI_top #(8) top_DUT (.masterClk(masterClk),
                      .slaveClk1(slaveClk1),
                      .slaveClk2(slaveClk2),
                      .slaveClk3(slaveClk3),
                      .masterData(masterData),
                      .slaveData_1(slaveData_1),
                      .slaveData_2(slaveData_2),
                      .slaveData_3(slaveData_3),
                      .spiInit(spiInit));
             
always #10 masterClk = ~masterClk;
always #20 slaveClk1 = ~slaveClk1;
always #20 slaveClk2 = ~slaveClk2;
always #20 slaveClk3 = ~slaveClk3;
         
initial begin
masterData = 8'b01010101;
slaveData_1 = 8'b10101010;
slaveData_2 = 8'b11011011;
slaveData_3 = 8'b00100100;
#20
spiInit = 1;
end

initial begin
#1000
$finish;
end
endmodule