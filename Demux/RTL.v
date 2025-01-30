`timescale 1ns / 1ps

module Demux(
    input sel,
    input i,
    output wire y0, 
    output wire y1
);    
    assign {y0, y1} = sel ? {1'b0, i} : {i, 1'b0};
endmodule
