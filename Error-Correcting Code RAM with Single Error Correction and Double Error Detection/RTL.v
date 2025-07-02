`timescale 1ns / 1ps

module ecc_ram_secded #(
  parameter ADDR_WIDTH = 4,
  parameter DATA_WIDTH = 8  
)(
  input wire clk,
  input wire rst,
  input wire [ADDR_WIDTH-1:0] addr,
  input wire [DATA_WIDTH-1:0] din,
  input wire we,
  output reg [DATA_WIDTH-1:0] dout,
  output reg single_bit_err,
  output reg double_bit_err
);
  localparam ECC_WIDTH = 5;  

  reg [DATA_WIDTH+ECC_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];
  function [ECC_WIDTH-1:0] gen_ecc(input [DATA_WIDTH-1:0] data);
    begin
      gen_ecc[0] = data[0] ^ data[1] ^ data[3] ^ data[4] ^ data[6];
      gen_ecc[1] = data[0] ^ data[2] ^ data[3] ^ data[5] ^ data[6];
      gen_ecc[2] = data[1] ^ data[2] ^ data[3] ^ data[7];
      gen_ecc[3] = data[4] ^ data[5] ^ data[6] ^ data[7];
      gen_ecc[4] = ^data;
    end
  endfunction

  always @(posedge clk) begin
    if (rst) begin
      dout <= 0;
      single_bit_err <= 0;
      double_bit_err <= 0;
    end else begin
      if (we) begin
        mem[addr] <= {gen_ecc(din), din};
      end else begin
        {ecc, data} = mem[addr];
        syndrome = gen_ecc(data) ^ ecc;
        parity_err = ^{data, ecc[3:0]} ^ ecc[4];

        case (syndrome)
          5'b00000: begin
            dout <= data;
            single_bit_err <= 0;
            double_bit_err <= 0;
          end
          default: begin
            if (parity_err == 1'b1) begin
              dout <= data;
              single_bit_err <= 1;
              double_bit_err <= 0;
            end else begin
              dout <= data;
              single_bit_err <= 0;
              double_bit_err <= 1;
            end
          end
        endcase
      end
    end
  end
  reg [DATA_WIDTH-1:0] data;
  reg [ECC_WIDTH-1:0] ecc;
  reg [ECC_WIDTH-1:0] syndrome;
  reg parity_err;
endmodule

