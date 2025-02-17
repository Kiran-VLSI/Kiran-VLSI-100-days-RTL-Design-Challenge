`timescale 1ns / 1ps
module Alu_8bit(
input [7:0] a,b,
input [3:0] sel,
output reg [7:0] out,
output reg carry
);
always@(*)begin
case(sel)
   3'b000: {carry, out } = a+b;
   3'b001: {carry, out } = a-b;
   3'b010:  out  = a&b;
   3'b011:  out = a|b;
   3'b100:  out = a^b;
   3'b101:  out = ~a;
   3'b110:  out = a<<1;
   3'b111:  out = a>>1;
  default: {carry, out } = 8'b00000000;
endcase
end 
endmodule
