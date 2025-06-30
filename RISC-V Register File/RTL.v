`timescale 1ns / 1ps

module riscv_registerfile (
    input         clk,             
    input         reset,           
    input         reg_write,       
    input  [4:0]  rs1,             
    input  [4:0]  rs2,             
    input  [4:0]  rd,              
    input  [31:0] write_data,    
    output [31:0] read_data1,      
    output [31:0] read_data2       
);
    reg [31:0] regfile [0:31];
     integer i;

    assign read_data1 = (rs1 == 5'd0) ? 32'd0 : regfile[rs1];
    assign read_data2 = (rs2 == 5'd0) ? 32'd0 : regfile[rs2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                regfile[i] <= 32'd0;  
        end else if (reg_write && rd != 5'd0) begin
            regfile[rd] <= write_data;  
        end
    end
endmodule
