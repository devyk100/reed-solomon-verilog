`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 06:37:12 PM
// Design Name: 
// Module Name: reed_solomon_interfacer
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


module reed_solomon_interfacer(
    input start_compute,
    input toggle_output,
    input store_payload,
    input reset,
    input[2:0] position,
    input[7:0] payload,
    output[2:0] position_output,
    output[7:0] payload_output
    );
    wire [63:0] OUT_X[1:0], OUT_Y[1:0];
    wire [2:0] position_1, position_2;
    wire [7:0] payload_1, payload_2;
    reg [2:0] position_out;
    reg [7:0] payload_out;
    assign payload_output = payload_out;
    assign position_output = position_out;
    assign position_1 = OUT_X[0][2:0];
    assign position_2 = OUT_X[1][2:0];
    assign payload_1 = OUT_Y[0][7:0];
    assign payload_2 = OUT_Y[1][7:0];
    reg [63:0] X_values[3:0];
    reg [63:0] Y_values[3:0];
    integer y_counter = 0, x_counter = 0, toggle_counter = 0;
    lagrange_interpolation li(start_compute, Y_values[0], Y_values[1], Y_values[2], Y_values[3], X_values[0], X_values[1], 
                X_values[2], X_values[3], OUT_X[0], OUT_X[1], OUT_Y[0], OUT_Y[1]);
    always @(reset) begin
        y_counter = 0;
        x_counter = 0;
    end
    
    always @(store_payload) begin
        X_values[x_counter] = position;
        Y_values[y_counter] = payload;
        x_counter = x_counter + 1;
        y_counter = y_counter + 1;
    end
    
    always @(toggle_output) begin
        if(toggle_counter) begin 
            toggle_counter = 0;
            position_out <= position_1;
            payload_out <= payload_1;
        end else begin 
            toggle_counter = 1;
            position_out <= position_2;
            payload_out <= payload_2;
        end
    
    end
    
endmodule
