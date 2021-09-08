`timescale 1ns / 1ps


module SPI_top #(parameter REG_WIDTH = 8)
(
    input masterClk,
    input slaveClk1,
    input slaveClk2,
    input slaveClk3,
    input [REG_WIDTH-1:0] masterData,
    input [REG_WIDTH-1:0] slaveData_1,
    input [REG_WIDTH-1:0] slaveData_2,
    input [REG_WIDTH-1:0] slaveData_3,
    input spiInit
);

//Track wires
wire serialBus_MS1_MOSI;
wire serialBus_S1S2_MM;
wire serialBus_S2S3_MM;
wire serialBus_S3M_MISO;


wire SS;
wire SCLK;

SPI_Master #(2,8) Master (.clk(masterClk),
                          .dataToSend(masterData),
                          .MISO(serialBus_S3M_MISO),
                          .spiInit(spiInit),
                          .SS(SS),
                          .MOSI(serialBus_MS1_MOSI),
                          .SCLK(SCLK));


SPI_Slave #(8) Slave_1 (.clk(SCLK),
                        .srcClk(slaveClk1),
                        .dataToSend(slaveData_1),
                        .MOSI(serialBus_MS1_MOSI),
                        .SS(SS),
                        .MISO(serialBus_S1S2_MM));
                      

SPI_Slave #(8) Slave_2(.clk(SCLK),
                       .srcClk(slaveClk2),
                       .dataToSend(slaveData_2),
                       .MOSI(serialBus_S1S2_MM),
                       .SS(SS),
                       .MISO(serialBus_S2S3_MM));
                       
SPI_Slave #(8) Slave_3(.clk(SCLK),
                       .srcClk(slaveClk3),
                       .dataToSend(slaveData_3),
                       .MOSI(serialBus_S2S3_MM),
                       .SS(SS),
                       .MISO(serialBus_S3M_MISO));

endmodule
