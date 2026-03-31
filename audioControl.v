`timescale 1ns / 1ps

module eventHappen(clock,reset, minCounter, secCounter, alarmMin, alarmSec, audioOut, aud_sd);
    input clock, reset;
    input[5:0] minCounter, secCounter, alarmMin, alarmSec;
    reg trigger;
    output audioOut;
    output aud_sd;
    
    always@(*) begin
        if((minCounter == alarmMin) && (secCounter == alarmSec))
            trigger = 1;
        else trigger = 0;
    end
    alarmSound sound(clock, reset, trigger, audioOut, aud_sd);
endmodule

module alarmSound (clk, reset, trigger, audioOut, aud_sd);
    input wire clk, reset, trigger;
    output reg audioOut;
    output wire aud_sd;

    // Parameters for note frequencies (100 MHz clock)
    parameter NOTE1_DIV = 170264;  
    parameter NOTE2_DIV = 191109;  
    parameter NOTE_DURATION = 50000000;  // 0.5 seconds at 100 MHz
    
    reg playing;
    reg [31:0] tone_counter;
    reg [31:0] time_counter;
    
    // Determine which note to play based on time
    wire first_note = (time_counter < NOTE_DURATION);
    wire [31:0] current_divider = first_note ? NOTE1_DIV : NOTE2_DIV;
    
    assign aud_sd = 1'b1;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            playing <= 0;
            tone_counter <= 0;
            time_counter <= 0;
            audioOut <= 0;
        end 
        else begin
            // Start playing when triggered
            if (trigger && !playing) begin
                playing <= 1;
                tone_counter <= 0;
                time_counter <= 0;
                end
            
            if (playing) begin
                // Generate tone by toggling speaker
                if (tone_counter >= current_divider - 1) begin
                    tone_counter <= 0;
                    audioOut <= ~audioOut;
                end else begin
                    tone_counter <= tone_counter + 1;
                end
                
                // Track total time
                time_counter <= time_counter + 1;
                
        
                if (time_counter >= (2 * NOTE_DURATION) - 1) begin
                    playing <= 0;
                    audioOut <= 0;
        
                end
            end 
            else begin
                audioOut <= 0;
             
            end
        end
    end

endmodule
/*module audioControl(clock, reset, playSound, audioOut, aud_sd, trigger);
    input clock, reset, playSound, trigger;
    output reg audioOut;
    output wire aud_sd;
    
    reg [19:0] counter;
    reg [31:0] time1;
    
    parameter clockFrequency = 100_000_000;
    parameter C4 = 191109,D4 = 170264;
    reg [9:0] msec, number;
    
    
    
    assign aud_sd = 1'b1;
    
    always @(posedge clock)
    begin
        if(trigger)begin
        
        
        
        end
        else begin
                counter <=0;
                time1<=0;
                number <=0;
                audioOut <=1;
        
        
        end
        
    
    end
    

endmodule*/
/*
module SongPlayer(clock, reset, playSound, audioOut, aud_sd);
    input clock, reset, playSound; 
    output reg audioOut;
    output wire aud_sd;
    
    reg [19:0] counter;
    reg [31:0] time1, noteTime;
    reg [9:0] msec, number; //millisecond counter, and sequence number of musical note.
    wire [4:0] note, duration;
    wire [19:0] notePeriod;
    
    parameter clockFrequency = 100_000_000;
    
    assign aud_sd = 1'b1;
    
    MusicSheet mysong(number, notePeriod, duration);
        always @ (posedge clock)
        begin
            if(reset | ~playSound)
            begin
                counter <=0;
                time1<=0;
                number <=0;
                audioOut <= 1;
            end
            
            else
            begin
                counter <= counter + 1;
                time1<= time1+1;
                if( counter >= notePeriod)
                begin
                    counter <=0;
                    audioOut <= ~audioOut ;
                end //toggle audio output
                if( time1 >= noteTime)
                begin
                    time1 <=0;
                    number <= number + 1;
                end //play next note
                if(number == 48) number <=0; // Make the number reset at the end of the song
             end
        end
        
    always @(duration) noteTime = (duration * clockFrequency/8); //number of FPGA clock periods in one note.
endmodule

module MusicSheet(input [9:0] number, output reg [19:0] note, reg [4:0] duration);
    parameter QUARTER = 5'b00010;//what is the max frequency output
    parameter HALF = 5'b00100;
    parameter ONE = 2* HALF;
    parameter TWO = 2* ONE;
    parameter FOUR = 2* TWO;
    parameter C4 = 191109, D4 = 170264, E4 = 151685, F4 = 142857, G4 = 127551,C5 = 95556, SP = 1;
    always @ (number) begin
        case(number) //Row Row Row your boat
            0: begin note = C4; duration = HALF; end //row
            1: begin note = SP; duration = HALF; end //
            2: begin note = C4; duration = HALF; end //row
            3: begin note = SP; duration = HALF; end //
            4: begin note = C4; duration = HALF; end //row
            5: begin note = SP; duration = HALF; end //
            6: begin note = D4; duration = HALF; end //your
            7: begin note = E4; duration = HALF; end //boat
            8: begin note = SP; duration = HALF; end //
            9: begin note = E4; duration = HALF; end //gently
            10: begin note = SP; duration = HALF; end //
            11: begin note = D4; duration = HALF; end //down
            12: begin note = E4; duration = HALF; end //
            13: begin note = SP; duration = HALF; end //
            14: begin note = F4; duration = HALF; end //the
            15: begin note = G4; duration = HALF; end //stream
            16: begin note = SP; duration = HALF; end //
            17: begin note = C5; duration = HALF; end //merrily
            18: begin note = SP; duration = QUARTER; end //
            19: begin note = C5; duration = HALF; end //
            20: begin note = SP; duration = QUARTER; end //
            21: begin note = C5; duration = HALF; end //
            22: begin note = SP; duration = QUARTER; end //
            23: begin note = G4; duration = HALF; end //
            24: begin note = SP; duration = QUARTER; end //
            25: begin note = G4; duration = HALF; end //
            26: begin note = SP; duration = QUARTER; end //
            27: begin note = G4; duration = HALF; end //
            28: begin note = SP; duration = QUARTER; end //
            29: begin note = E4; duration = HALF; end //
            30: begin note = SP; duration = QUARTER; end //
            31: begin note = E4; duration = HALF; end //
            32: begin note = SP; duration = QUARTER; end //
            33: begin note = E4; duration = HALF; end //
            34: begin note = SP; duration = QUARTER; end //
            35: begin note = C4; duration = HALF; end //
            36: begin note = SP; duration = QUARTER; end //
            37: begin note = C4; duration = HALF; end //
            38: begin note = SP; duration = QUARTER; end //
            39: begin note = C4; duration = HALF; end //
            40: begin note = SP; duration = QUARTER; end //5
            41: begin note = G4; duration = ONE; end //Life
            42: begin note = SP; duration = HALF; end //
            43: begin note = F4; duration = HALF; end //is
            44: begin note = E4; duration = HALF; end //but
            45: begin note = SP; duration = HALF; end //
            46: begin note = D4; duration = HALF; end //a
            47: begin note = C4; duration = HALF; end //dream
            default: begin note = C4; duration = FOUR; end
        endcase
    end
endmodule*/

