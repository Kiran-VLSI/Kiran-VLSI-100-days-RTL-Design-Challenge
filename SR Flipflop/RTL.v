`timescale 1ns / 1ps

module sr_flipflop(
    input S,       
    input R,       
    input clk,    
    output reg Q,
    output Qn      
);
assign Qn = ~Q;

always @(posedge clk) begin
    if (S == 1 && R == 0)
        Q <= 1;
    else if (S == 0 && R == 1)
        Q <= 0;
    else if (S == 0 && R == 0)
        Q <= Q;  
    else
        Q <= 1'bx; 
end
endmodule

