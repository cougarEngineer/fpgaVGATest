`timescale 1ns / 1ps


module clk_div(
    input clk,
    input rst,
    output clk_div
    );
    
    reg[1:0] count;
    
    assign clk_div = &count;
    
    always@(posedge clk)
        if(rst)
            count <= 0;
        else
            count <= count + 1;
    
endmodule
