`timescale 1ns / 1ps

module one_pulse_generator(
    input wire clk,
    input wire reset,
    input wire in_signal,      
    output reg pulse_out       
);
    reg in_signal_d;
    always @(posedge clk or posedge reset) begin
        if (reset)
            in_signal_d <= 0;
        else
            in_signal_d <= in_signal;
    end
    always @(posedge clk or posedge reset) begin
        if (reset)
            pulse_out <= 0;
        else
            pulse_out <= in_signal & ~in_signal_d; 
    end
endmodule
