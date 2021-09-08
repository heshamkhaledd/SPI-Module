`timescale 1ns / 1ps

module SPI_Master #(parameter [3:0] clockPrescaler = 4'b0001, parameter REG_WIDTH = 8)
(
    input clk,
    input [REG_WIDTH-1:0] dataToSend,
    input MISO,
    input spiInit,
    output reg SS,
    output SCLK,
    output MOSI     
);

Shift_Register #(REG_WIDTH)     shiftRegister (.clk(SCLK),
                                               .regClk(clk),
                                               .inReg(dataToSend),
                                               .inBit(MISO),
                                               .EN(SS),
                                               .outBit(MOSI));
                             
Frequency_Divider #(clockPrescaler) Prescaler (.clk(clk),
                                               .EN(SS),
                                               .SCLK(SCLK));


localparam idleState     = 2'b00;
localparam dataState     = 2'b01; 
localparam finishState   = 2'b10;

reg [1:0] currState;
integer Itr;


initial begin
currState = idleState;
Itr = 0;
SS = 1;
end

always@(posedge clk)
    begin
        case (currState)
            idleState: begin
                        if (spiInit == 1)
                            begin
                                currState <= dataState;
                            end
                        else
                            currState <= idleState;
                       end
                       
            dataState: begin
                        SS <= 0;
                        if (Itr != REG_WIDTH*clockPrescaler)
                           Itr = Itr + 1;
                        else
                            begin
                                Itr <= 0;
                                currState <= finishState;
                            end
                       end
            
            finishState: begin
                          SS <= 1;
                         end
        endcase

    end
endmodule