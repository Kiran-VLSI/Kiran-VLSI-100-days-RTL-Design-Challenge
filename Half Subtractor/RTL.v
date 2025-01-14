`timescale 1ns / 1ps

module halfsubractor(
    input a,
    input b,
    output diff,
    output bout
    );
    assign diff = a ^ b;
    assign bout = ~a & b;
endmodule
