module modular_inverse #(parameter WIDTH = 64)(
    input compute,
    input [WIDTH-1:0] X,
    input [WIDTH-1:0] PRIME_MOD,
    output reg [WIDTH*8-1:0] INV,
    output reg done_mod_inverse
    );
    reg [WIDTH*8-1:0] temp;
    integer i;
    always @(X) begin
        done_mod_inverse = 0;
        INV = 0;
        temp = 1; 
        for(i = 0; i < PRIME_MOD-2; i = i+1) begin
            temp = (temp * X) % PRIME_MOD;
        end
        INV = temp;
        done_mod_inverse = 1;
    end
endmodule