`timescale 1ns / 1ps

module Fullsubtractor(
    input a,
    input b,
    input bin,
    output diff,
    output bout
    );
  assign diff = a ^ b ^ bin;
  assign bout = (~a & (b^bin)) | (b & bin) ;
endmodule
