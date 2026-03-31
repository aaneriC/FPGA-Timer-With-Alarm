`timescale 1ns / 1ps

module setAlarm(userInput,userMin, userSec);
   input [8:0] userInput;
   output [5:0] userMin, userSec;
   
   assign userMin = userInput / 60; 
   assign userSec = userInput % 60;
   
endmodule
