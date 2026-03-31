`timescale 1ns / 1ps

module minSecCounter(oneHzClock, resetSW, alarmMin, alarmSec, minute_counter, second_counter);
    input oneHzClock;
    input resetSW;
    input [5:0] alarmMin, alarmSec;
    output reg [5:0] minute_counter, second_counter;
    
    always @ (posedge oneHzClock, posedge resetSW) begin
    
        if (resetSW | ((second_counter == alarmSec) && (minute_counter == alarmMin))) begin
            minute_counter <= 0;
            second_counter <= 0;
        end
        
        else 
        begin
            second_counter <= second_counter +1;
            
            if (second_counter == 59)
            begin    
                minute_counter <= minute_counter + 1;
                second_counter <= 0;
                
                if(minute_counter == 59) begin minute_counter <= 0; end
                
            end
        end
    end
endmodule