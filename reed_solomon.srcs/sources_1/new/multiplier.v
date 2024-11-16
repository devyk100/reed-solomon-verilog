`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2024 10:33:28 PM
// Design Name: 
// Module Name: multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiplier #(parameter WIDTH = 16)(
    input [WIDTH-1:0]A,
    input [WIDTH-1:0]B,
    output [WIDTH-1:0]C
    );
    assign C = A*B;
endmodule
