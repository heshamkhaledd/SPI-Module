`timescale 1ns / 1ps

module SPI_Master #(parameter [3:0] clockPrescaler = 4'b0001, parameter REG_WIDTH = 8)
(
    input clk,
    input [REG_WIDTH-1:0] dataToSend,
    input inBit,
    input MISO,
    output SS,
    output SCLK,
    output MOSI     
);

Shift_Register #(REG_WIDTH) (.clk(SCLK),
                             .inReg(dataToSend),
                             .inBit(inBit),
                             .EN(SS),
                             .outBit(MOSI));
                             
Frequency_Divider #(clockPrescaler) Prescaler (.clk(clk),
                                               .EN(SS),
                                               .SCLK(SCLK));


parameter idleState     = 2'b00;
parameter dataState     = 2'b01; 
parameter finishState   = 2'b10;

reg [1:0] currState;
reg stateSS;
integer Itr;

assign SS = stateSS;
initial begin
currState = idleState;
Itr = 0;
end

always@(posedge SCLK)
    begin
        case (currState)
            idleState: begin
                        if (SS != 1)
                            currState <= dataState;
                        else
                            currState <= idleState;
                       end
                       
            dataState: begin
                        if (Itr != REG_WIDTH)
                           Itr = Itr + 1;
                        else
                            begin
                                Itr <= 0;
                                currState <= finishState;
                            end
                       end
            
            finishState: begin
                          stateSS = 1;
                         end
        endcase

    end
endmodule