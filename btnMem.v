`timescale 1ns / 1ps

module btnMem(
    input clk,
    input u,
    input d,
    input l,
    input r,
    output reg [1:0] pressed
    );
    
    always@(posedge clk)
    if(d)
        pressed <= 2'b01;
    else if(l)
        pressed <= 2'b10;
    else if(r)
        pressed <= 2'b11;
    else if (u)
        pressed <= 2'b00;
    else
        pressed <= pressed;
        
endmodule
