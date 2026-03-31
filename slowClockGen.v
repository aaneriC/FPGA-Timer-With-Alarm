`timescale 1ns / 1ps

//gives two different timings POVclock and 1HzClock
module slowClockGen(clk, resetSW, POV_clock, Clock_1Hz);
    input clk;
    input resetSW;  
    output reg POV_clock;
    output reg Clock_1Hz;
   
    reg [16:0] counter_POV;
    reg [26:0] counter_1Hz;
    
    always @ (posedge clk)
    begin
        if (resetSW)
        begin

            counter_POV = 0;
            counter_1Hz = 0;

            POV_clock = 0;
            Clock_1Hz = 0;
        end
        else
        begin      
            counter_POV = counter_POV + 1;
            counter_1Hz = counter_1Hz + 1;
            
            
            if(counter_POV == 125_000) //.0025 seconds
            begin
                POV_clock=~POV_clock;
                counter_POV =0;
            end
            
            if(counter_1Hz == 50_000_000) // 1 second
            begin
                Clock_1Hz =~Clock_1Hz;
                counter_1Hz = 0;
            end
            
        end
    end
endmodule