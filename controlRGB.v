`timescale 1ns / 1ps

module controlRGB(clock, resetSW, counterMin, counterSec, alarmMin, alarmSec, RGB1,RGB2);
    input clock, resetSW;
    input [5:0] counterMin, counterSec, alarmMin, alarmSec;
    output reg [2:0] RGB1, RGB2;
   
    reg [4:0] count;
    
    always @(posedge clock)
    begin
        if(((counterMin == alarmMin) && (counterSec == alarmSec)))begin
            case(count)
                0: begin RGB1<=1; RGB2<=1; end
                1: begin RGB1<=2; RGB2<=2; end
                2: begin RGB1<=3; RGB2<=3; end
                3: begin RGB1<=4; RGB2<=4; end
                4: begin RGB1<=5; RGB2<=5; end
                5: begin RGB1<=6; RGB2<=6; end
                6: begin RGB1<=7; RGB2<=7; end
                default: begin RGB1<=1; RGB2<=1; end 
            endcase
            count <= count + 1;
            if(count == 6)
                count <= 0;
        end
        else begin 
            count <= 0;
            RGB1 <= 1;
            RGB2 <= 1;end
    end
endmodule
