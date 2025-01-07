`timescale 1ns / 1ps

module structural_tb;
    reg a, b; 
    wire and_g, 
         or_g,
         not_g,
         nand_g,
         nor_g,
         xor_g,
         xnor_g;
         
    logicgate_structural dut (
        .a(a), 
        .b(b), 
        .and_gate(and_g),
        .or_gate(or_g),
        .not_gate(not_g),
        .nand_gate(nand_g),
        .nor_gate(nor_g),
        .xor_gate(xor_g),
        .xnor_gate(xnor_g)
    );
    initial begin
        #10 a = 1'b0; b = 1'b0;
        #10 a = 1'b0; b = 1'b1;
        #10 a = 1'b1; b = 1'b0;
        #10 a = 1'b1; b = 1'b1;
    end
endmodule
