`timescale 1ns / 1ps

module alu_4bit(
    input [3:0] A, B,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Out,
    output reg CarryOut
);
    always @(*) begin
        case (ALU_Sel)
            3'b000: {CarryOut, ALU_Out} = A + B;       
            3'b001: {CarryOut, ALU_Out} = A - B;      
            3'b010: ALU_Out = A & B;                   
            3'b011: ALU_Out = A | B;                   
            3'b100: ALU_Out = A ^ B;                   
            3'b101: ALU_Out = ~A;                      
            3'b110: ALU_Out = A << 1;                 
            3'b111: ALU_Out = A >> 1;                
            default: {CarryOut, ALU_Out} = 5'b00000;
        endcase
    end
endmodule
