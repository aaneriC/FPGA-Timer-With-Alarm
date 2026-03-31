`timescale 1ns / 1ps

module alarmClock(clock, resetSW, userInput, audioOut, aud_sd, RGB1, RGB2, Cout, AN);
    input clock, resetSW;
    input [8:0] userInput;
    output audioOut, aud_sd;
    output [2:0] RGB1, RGB2; 
    output [7:0] AN;
    output [6:0] Cout;
    
    wire [3:0]alarmMinTens, alarmMinOnes, alarmSecTens, alarmSecOnes, minTens, minOnes, secTens, secOnes;
    wire [5:0]minuteCounter, secondCounter, alarmMin, alarmSec;
    wire POVClock, Clock1Hz;
    wire [6:0] C1, C2, C3,C4, C5, C6, C7, C8;
    
    slowClockGen clockgen(clock, resetSW, POVClock, Clock1Hz);
    
    minSecCounter counting(Clock1Hz, resetSW, alarmMin, alarmSec, minuteCounter, secondCounter);
    digitsSeparator sepCount(minuteCounter, secondCounter, minTens, minOnes, secTens, secOnes);
    
    setAlarm alarmSet(userInput, alarmMin, alarmSec);
    digitsSeparator sepAlarm(alarmMin, alarmSec, alarmMinTens, alarmMinOnes, alarmSecTens, alarmSecOnes);
    
    diplayNumber disp(alarmMinTens, alarmMinOnes, alarmSecTens, alarmSecOnes, minTens, minOnes, secTens, secOnes, C1, C2, C3, C4, C5, C6, C7, C8);
    muxWithCounter sel(POVClock, C1, C2, C3, C4, C5, C6, C7, C8, Cout, AN);
    
    eventHappen sound(clock, resetSW, minuteCounter, secondCounter, alarmMin, alarmSec, audioOut, aud_sd);
    controlRGB color(Clock1Hz, resetSW, minuteCounter, secondCounter, alarmMin, alarmSec, RGB1, RGB2);
endmodule