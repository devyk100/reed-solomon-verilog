module mod_inverse #(parameter WIDTH = 16) (
    input [WIDTH-1:0] a,     // Input number a
    input [WIDTH-1:0] M,     // Modulo prime number M
    input start,             // Start signal to trigger computation
    output reg [WIDTH-1:0] inv,   // Output: Modular inverse of a mod M
    output reg done            // Done signal to indicate computation is complete
);

    reg [WIDTH-1:0] x0, x1, q, t, temp;
    reg [WIDTH-1:0] a_reg, m_reg;
    
    always @(*) begin
        if (start) begin
            // Initialize the values
            a_reg = a;
            m_reg = M;
            x0 = 0;
            x1 = 1;
            done = 0;
            
            // Extended Euclidean Algorithm to compute modular inverse
            while (a_reg != 1) begin
                q = a_reg / m_reg;         // Calculate quotient
                t = m_reg;                 // Store current modulus
                m_reg = a_reg % m_reg;     // Update modulus as remainder
                a_reg = t;                 // Swap a and m
                temp = x0;
                x0 = x1 - q * x0;         // Update x0 (previous result)
                x1 = temp;                 // Update x1
            end
            
            // If the loop ends, x1 is the modular inverse
            inv = x1;
            done = 1;  // Indicate that the computation is complete
        end
    end
endmodule
