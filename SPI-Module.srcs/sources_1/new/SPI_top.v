`timescale 1ns / 1ps


module SPI_top #(parameter REG_WIDTH = 8)
(
    input masterClk,
    input slaveClk,
    input [REG_WIDTH-1:0] masterData,
    input [REG_WIDTH-1:0] slaveData,
    input spiInit
);
wire serialBus_1;
wire serialBus_2;
wire SS;
wire SCLK;

SPI_Master #(2,8) Master (.clk(masterClk),
                          .dataToSend(masterData),
                          .MISO(serialBus_2),
                          .spiInit(spiInit),
                          .SS(SS),
                          .MOSI(serialBus_1),
                          .SCLK(SCLK)       );


SPI_Slave #(8) Slave (.clk(SCLK),
                      .srcClk(slaveClk),
                      .dataToSend(slaveData),
                      .MOSI(serialBus_1),
                      .SS(SS),
                      .MISO(serialBus_2));

endmodule
