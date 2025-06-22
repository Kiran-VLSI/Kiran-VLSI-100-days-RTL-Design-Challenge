`timescale 1ns / 1ps

module clock_gating(
    input  wire clk,        
    input  wire rstn,       
    input  wire enable,     
    output wire gated_clk   
);
    reg latch_enable;
    always @(negedge clk or negedge rstn) begin
        if (!rstn)
            latch_enable <= 1'b0;
        else
            latch_enable <= enable;
    end
    assign gated_clk = clk & latch_enable;
endmodule

