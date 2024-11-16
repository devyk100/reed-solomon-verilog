module lagrange_interpolation #(parameter WIDTH = 64)(
    input operate,
    input [WIDTH-1:0] Y1, Y2, Y3, Y4,
    input [WIDTH-1:0] X1, X2, X3, X4,
    output reg [WIDTH-1:0] OUT_X_1, OUT_X_2,
    output reg [WIDTH-1:0] OUT_Y_1, OUT_Y_2
);
    parameter [WIDTH-1:0]PRIME_MOD = 257;
    reg signed [WIDTH-1:0] i, j, k, sum, product, result1, result2, temp1, temp2, temp;
    reg signed [WIDTH-1:0] out, Eout, Fout;
    reg compute_mod_inverse;
    wire done_mod_inverse;
    reg signed [WIDTH-1:0] unknown_x [1:0];
    reg signed [WIDTH-1:0] X[0:3], Y[0:3];
    reg signed [WIDTH-1:0] NUM;
    reg signed [WIDTH-1:0] INV;
    always @(posedge operate) begin
        j = 0;
        compute_mod_inverse = 0;
        k = 0;
        X[0] = X1;
        X[1] = X2;
        X[2] = X3;
        X[3] = X4;
        NUM = 0;
        Y[0] = Y1;
        Y[1] = Y2;
        Y[2] = Y3;
        Y[3] = Y4;
        sum = 0;
        product = 1;
        for(i = 0; i <= 3; i = i+1) begin
            sum = sum + X[i];
            product = product * X[i];
        end
        sum = 21 - sum;
        product = 720 / product;
        for(i = 1; i <= 6; i = i +1) begin
            for(j = 2; j <= 6; j = j+1) begin
                if(i*j == product) begin
                    if(i+j == sum) begin
                        unknown_x[0] = j;
                        unknown_x[1] = i;
                    end
                end
            end          
        end
        
        result1 = 0;
        
        for(i = 0; i <= 3; i = i+1) begin
            temp1 = 1;
            temp1 = Y[i];
            temp1 = temp1 % PRIME_MOD;
            for(k = 0; k <= 3; k = k+1) begin
                if(k != i) begin
                    temp1 = temp1 * (unknown_x[0]%PRIME_MOD + (PRIME_MOD - X[k])%PRIME_MOD)%PRIME_MOD;
                    NUM = (X[i]%PRIME_MOD + (PRIME_MOD - X[k])%PRIME_MOD)%PRIME_MOD;
                    INV = 0;
                    temp = 1; 
                    for(j = 0; j < PRIME_MOD-2; j = j+1) begin
                        temp = (temp * NUM) % PRIME_MOD;
                    end
                    INV = temp;
                    temp1 = temp1 * INV;
                    temp1 = temp1 % PRIME_MOD;
                    $display("inverse %d num %d", INV, NUM);
                end
            end
            temp1 = temp1 % PRIME_MOD;
            result1 = result1 + temp1;
            result1 = result1 % PRIME_MOD;
            
        end
        
               
        result2 = 0;
        
        for(i = 0; i <= 3; i = i+1) begin
            temp1 = 1;
            temp1 = Y[i];
            temp1 = temp1 % PRIME_MOD;
            for(k = 0; k <= 3; k = k+1) begin
                if(k != i) begin
                    temp1 = temp1 * (unknown_x[1]%PRIME_MOD + (PRIME_MOD - X[k])%PRIME_MOD)%PRIME_MOD;
                    NUM = (X[i]%PRIME_MOD + (PRIME_MOD - X[k])%PRIME_MOD)%PRIME_MOD;
                    INV = 0;
                    temp = 1; 
                    for(j = 0; j < PRIME_MOD-2; j = j+1) begin
                        temp = (temp * NUM) % PRIME_MOD;
                    end
                    INV = temp;
                    temp1 = temp1 * INV;
                    temp1 = temp1 % PRIME_MOD;
                    $display("inverse %d num %d", INV, NUM);
                end
            end
            temp1 = temp1 % PRIME_MOD;
            result2 = result2 + temp1;
            result2 = result2 % PRIME_MOD;
            
        end
        
        OUT_X_1 = unknown_x[0];
        OUT_X_2 = unknown_x[1];
        OUT_Y_1 = result1;
        OUT_Y_2 = result2;
    end
endmodule