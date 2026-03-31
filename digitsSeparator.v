`timescale 1ns / 1ps

module digitsSeparator(min_counter, sec_counter, min_tens, min_ones, sec_tens, sec_ones);
    input [5:0] min_counter, sec_counter; 
    output [3:0] min_tens, min_ones; 
    output [3:0] sec_tens, sec_ones;


    assign min_tens = min_counter/10;
    assign min_ones = min_counter%10;
    
    assign sec_tens = sec_counter/10;
    assign sec_ones = sec_counter%10;
endmodule
