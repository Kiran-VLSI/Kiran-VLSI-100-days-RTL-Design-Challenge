`timescale 1ns / 1ps

module sync_async_rst(
    input clk,rst,in,
    output reg out_async,out_sync
    );

    always@(posedge clk)  
    begin
        if(rst) out_sync<= 1'b0;
        else out_sync <= in;
    end

    always@(posedge clk, posedge rst)
    begin
        if(rst) out_async<= 1'b0;
        else out_async <= in;
    end  
    
endmodule

