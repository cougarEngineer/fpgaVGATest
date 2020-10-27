`timescale 1ns / 1ps

module vgaColors(
    input active,
    input [1:0] pressed,
    input [11:0] in,
    input [9:0] xPos,
    input [8:0] yPos,
    output [3:0] Red,
    output [3:0] Green,
    output [3:0] Blue
    );
    reg [11:0] mod;
    reg [9:0] a, b;
    wire [9:0] b32;
    
    always@(*)
    case (pressed)
        0: begin a=xPos; b=yPos; end
        1: begin a=xPos; b=479-yPos; end
        2: begin a=yPos; b=xPos; end
        3: begin a=yPos; b=639-xPos; end
    endcase
    assign Red = mod[11:8];
    assign Green = mod[7:4];
    assign Blue = mod[3:0];
    assign b32 = b+32;
    
    always@(*)
        if(!active)
            mod <= 12'h000;
        else
            if(b < 32)
                mod <= (a[1] ^ b[1]) ? in : ~in;
            else if (b < 96)
                mod <= (a[3] ^ b[3]) ? in : ~in;
            else if (b < 224)
                mod <= (a[5] ^ b[5]) ? in : ~in;
            else if (b < 608)
                mod <= (a[7] ^ b32[7]) ? in : ~in;
            else
                mod <= (a[0] ^ b[0]) ? in : ~in;

endmodule
