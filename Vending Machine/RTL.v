`timescale 1ns / 1ps

module vending_machine(
    input clk,
    input rst,
    input coin_5,
    input coin_10,
    input [1:0] item_select,
    input cancel,

    output reg dispense,
    output reg [7:0] change,
    output reg [7:0] balance
);

    localparam IDLE = 0, WAIT_COIN = 1, CHECK_AMOUNT = 2, DISPENSE = 3, RETURN_CHANGE = 4;

    reg [2:0] state, next_state;

    // Prices
    parameter ITEM_A = 8'd10;
    parameter ITEM_B = 8'd15;

    // Next-state logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            balance <= 0;
            dispense <= 0;
            change <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        dispense = 0;
        change = 0;

        case (state)
            IDLE: begin
                if (coin_5 || coin_10)
                    next_state = WAIT_COIN;
                else if (item_select != 2'b00)
                    next_state = CHECK_AMOUNT;
            end

            WAIT_COIN: begin
                next_state = CHECK_AMOUNT;
            end

            CHECK_AMOUNT: begin
                case (item_select)
                    2'b01: begin
                        if (balance >= ITEM_A)
                            next_state = DISPENSE;
                        else
                            next_state = WAIT_COIN;
                    end
                    2'b10: begin
                        if (balance >= ITEM_B)
                            next_state = DISPENSE;
                        else
                            next_state = WAIT_COIN;
                    end
                    default: next_state = WAIT_COIN;
                endcase
            end

            DISPENSE: begin
                dispense = 1;
                if (item_select == 2'b01)
                    change = balance - ITEM_A;
                else if (item_select == 2'b10)
                    change = balance - ITEM_B;
                next_state = IDLE;
            end
        endcase

        if (cancel)
            next_state = RETURN_CHANGE;
    end

    // Balance and outputs
    always @(posedge clk) begin
        if (coin_5)
            balance <= balance + 5;
        else if (coin_10)
            balance <= balance + 10;
        else if (state == DISPENSE) begin
            if (item_select == 2'b01)
                balance <= balance - ITEM_A;
            else if (item_select == 2'b10)
                balance <= balance - ITEM_B;
        end else if (state == RETURN_CHANGE) begin
            change <= balance;
            balance <= 0;
        end
    end

endmodule
