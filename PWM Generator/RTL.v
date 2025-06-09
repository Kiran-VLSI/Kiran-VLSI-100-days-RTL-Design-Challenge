`timescale 1ns / 1ps

module pwm_generator(
    input wire clk,
    input wire reset,
    input wire [7:0] duty_cycle, 
    output reg pwm_out
);
    reg [7:0] counter;
    always @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 0;
        else if (counter == 8'd255)
            counter <= 0;
        else
            counter <= counter + 1;
    end
    always @(posedge clk or posedge reset) begin
        if (reset)
            pwm_out <= 0;
        else if (counter < duty_cycle)
            pwm_out <= 1;
        else
            pwm_out <= 0;
    end
endmodule
