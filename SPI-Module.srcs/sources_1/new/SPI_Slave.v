`timescale 1ns / 1ps


module SPI_Slave #(parameter REG_WIDTH = 8)
(
    input clk,
    input [REG_WIDTH-1:0] dataToSend,
    input MOSI,
    input SS,
    output MISO
);

Shift_Register #(REG_WIDTH)     shiftRegister (.clk(clk),
                                               .regClk(clk),
                                               .inReg(dataToSend),
                                               .inBit(MOSI),
                                               .EN(SS),
                                               .outBit(MISO));
integer Itr;

initial begin
Itr = 0;
end


always@(posedge clk)
begin
    if(!SS)
    begin
        if (Itr != REG_WIDTH)
           Itr = Itr + 1;
        else
            begin
                Itr <= 0;
            end
    end
end

endmodule
