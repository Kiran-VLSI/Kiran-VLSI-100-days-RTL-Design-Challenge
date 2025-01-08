`timescale 1ns / 1ps
module gatelevel_Modeling(
input a,b,
output wire and_gate,
output wire or_gate,
output wire notgate_a,
output wire notgate_b,
output wire nand_gate,
output wire nor_gate,
output wire xor_gate,
output wire xnor_gate
    );
    and andgate(and_gate,a,b);
    or orgate(or_gate, a, b);
    not notgate1(notgate_a, a);   
    not notgate2(notgate_b, b); 
    nand nandgate(nand_gate, a, b);
    nor norgate(nor_gate, a, b);
    xor xorgate(xor_gate, a, b);
    xnor xnorgate(xnor_gate, a, b);
endmodule
