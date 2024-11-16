module testbench #(parameter WIDTH = 64)();
////    reg [63:0] A, B, C, D;
//    reg clk;
////    wire  [63:0] E, F;
//    reg [WIDTH-1:0] X1,X2,X3,X4, Y1, Y2, Y3, Y4;
//    wire [WIDTH-1:0] OUT_X_1, OUT_X_2 , OUT_Y_1, OUT_Y_2;
////    lagrange_interpolation #(WIDTH) m1(clk,A,B,C,D,E,F);
////    mod_inverse m(A, 65521, clk, E, F[0]);
////    modular_inverse m1(clk, A, B, E);
//    lagrange_interpolation lt(clk, Y1, Y2, Y3, Y4, X1,X2,X3,X4,OUT_X_1, OUT_X_2 , OUT_Y_1, OUT_Y_2);
//    initial X1 = 1;
//    initial X2 = 2;
//    initial X3 = 5;
//    initial X4 = 6;
//    initial Y1 = 3;
//    initial Y2 = 7;
//    initial Y3 = 105;
//    initial Y4 = 76;
////    initial A = 64'd10;
////    initial B =64'd257;
////    initial C = 16'd11;
////    initial D = 16'd14;
//    initial clk = 0;
////    assign C = A*B;
//    initial begin 
//    #20;
//    clk = 1;
//    #20;
////    clk = 0;
////    A = 64'd13; #1;
////    clk = 1;
////    #20;
////    clk = 0;
//    #2000;
//    $finish; 
////    C = A*B;
//    end
    reg start_compute, start, store_payload, reset;
    reg [2:0] position;
    reg[7:0] payload;
    wire [2:0] position_1, position_2;
    wire [7:0] payload_1, payload_2;
    reed_solomon_interfacer rsi(start_compute, start, store_payload, reset, position, payload, position_1, payload_1, position_2, payload_2);
    initial begin
    start = 0;
    reset = 1;
    reset = 0;
    
    position = 1;
    payload = 5;
    #5;
    store_payload = 1;
    #5;
    position = 2;
    payload = 7;
    #5;
    store_payload = ~store_payload;
    #5;
    position = 5;
    payload = 41;
    #5;
    store_payload = ~store_payload;
    #5;
    position = 4;
    payload = 9;
    #5;
    store_payload = ~store_payload;
    #5;
    start_compute = 0;
    #5;
    start_compute = 1;
    #1000; 
    
    end
endmodule