`timescale 1ns / 1ps

module johnson_counter (
    input wire clk,   
    input wire rst,   
    output reg [3:0] count 
);
  always @(posedge clk or posedge rst) begin
    if (rst)
      count <= 4'b0000; 
    else
      count <= {~count[0], count[3:1]}; 
  end

endmodule
