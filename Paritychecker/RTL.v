`timescale 1ns / 1ps

module evenparitychecker(
  input wire [7:0] data_in,
  input wire parity_in,
  output wire error
);
assign error = ^({parity_in, data_in});
endmodule
