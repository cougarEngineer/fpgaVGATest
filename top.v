`timescale 1ns / 1ps

module top(
    input clk,
    input [15:0] sw,
    input btnC,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    output Hsync,
    output Vsync,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue
    );
    
    wire clk25MHz, active;
    wire [1:0] pressed;
    wire [9:0] xPos;
    wire [8:0] yPos;
    
    //clk_div clk0(.clk(clk), .rst(btnC), .clk_div(clk25MHz));
    clk_wiz_0 clkwiz0(.clk_25MHz(clk25MHz), .reset(btnC), .locked(locked), .clk_100MHz(clk));
    
    vgaTimings timing(.clk(clk), .clk_div(clk25MHz), .rst(btnC), 
        .xPos(xPos), .yPos(yPos), .Hsync(Hsync), .Vsync(Vsync), .active(active));
    
    vgaColors pixels(.active(active), .pressed(pressed), .in(sw[11:0]),
        .xPos(xPos), .yPos(yPos), .Red(vgaRed), .Green(vgaGreen), .Blue(vgaBlue));
    
    btnMem direction(.clk(clk), .u(btnU), .d(btnD), .l(btnL), .r(btnR), .pressed(pressed));
    
endmodule
