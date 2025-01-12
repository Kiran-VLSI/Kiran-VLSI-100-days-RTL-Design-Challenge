`timescale 1ns / 1ps

module Evenparitygenerator (
  input wire [7:0] data_in,
  output wire parity
);

assign parity = ^data_in;
  
endmodule

#Logic:
Even Parity: The XOR of all input bits (Even_Parity = Data[0] ⊕ Data[1] ⊕ ... ⊕ Data[N-1]).
Odd Parity: The complement of the even parity (Odd_Parity = ~Even_Parity).
