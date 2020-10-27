`timescale 1ns / 1ps

module vgaTimings(
    input clk_div,
    input rst,
    output [9:0] xPos, //active coordinates
    output [8:0] yPos,
    output Hsync, //sync signals
    output Vsync,
    output active //to drive or not
    );
    
    parameter startH = 16;    parameter stopH = 112; //horizontal sync
    parameter startX = 160;    parameter line = 799; //horizontal active
    
    parameter stopY = 480;    parameter startV = 490; //vertical active
    parameter stopV = 492;    parameter screen = 524; //vertical sync
    
    reg[9:0] horizontal, vertical; //overall coordinates
    
    assign Hsync = ~((horizontal >= startH) && (horizontal < stopH));
    assign Vsync = ~((vertical >= startV) && (vertical < stopV));
    
    assign xPos = (horizontal < startX) ? 0 : (horizontal - startX);
    assign yPos = (vertical < stopY) ? vertical : (stopY - 1);
    assign active = (horizontal >= startX) && (vertical < stopY);
    always@(posedge clk_div) 
        if(rst)
        begin
            horizontal <= 0;
            vertical <= 0;
        end
        else 
        begin
            if (horizontal == line)
            begin
                horizontal <= 0;
                if (vertical == screen)
                    vertical <= 0;
                else
                    vertical <= vertical + 1;
            end
            else
                horizontal <= horizontal + 1;
        end

endmodule
