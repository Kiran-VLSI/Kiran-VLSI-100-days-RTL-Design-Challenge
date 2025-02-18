`timescale 1ns / 1ps
module alu16bit(
    input [15:0] A,       
    input [15:0] B,        
    input [3:0] ALU_Sel,   
    output reg [15:0] ALU_Out, 
    output reg Zero       
);

    always @(*) begin
        case (ALU_Sel)
            4'b0000: ALU_Out = A + B;    
            4'b0001: ALU_Out = A - B;    
            4'b0010: ALU_Out = A & B;    
            4'b0011: ALU_Out = A | B;    
            4'b0100: ALU_Out = A ^ B;    
            4'b0101: ALU_Out = ~(A | B); 
            4'b0110: ALU_Out = ~(A & B); 
            4'b0111: ALU_Out = ~(A ^ B); 
            4'b1000: ALU_Out = A << 1;  
            4'b1001: ALU_Out = A >> 1;   
            4'b1010: ALU_Out = A <<< 1;  
            4'b1011: ALU_Out = A >>> 1;  
            default: ALU_Out = 16'b0;   
        endcase
        if (ALU_Out == 16'b0)
            Zero = 1;
        else
            Zero = 0;
    end
endmodule

   
