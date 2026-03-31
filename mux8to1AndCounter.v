`timescale 1ns / 1ps

//selects which AN will be on as well as which C seg pattern is out
module muxWithCounter(clock, W0, W1, W2, W3, W4, W5, W6, W7, W, AN);
    input [6:0] W0, W1, W2, W3, W4, W5, W6, W7;
    input clock;
    output [6:0] W;
    output [7:0] AN;
    wire [2:0] select;
    
    bitcounter3(clock, select);
    mux8to1 mux(W0, W1, W2, W3, W4, W5, W6, W7, select, W, AN);
endmodule 

module mux8to1(W0, W1, W2, W3, W4, W5, W6, W7, S, W, AN);
    input [6:0] W0, W1, W2, W3, W4, W5, W6, W7;
    input [2:0] S;
    output reg [6:0] W;
    output reg [7:0] AN;
    
    always @(S)
        case (S)
        0: begin W = W0; AN = 8'b0111_1111; end
        1: begin W = W1; AN = 8'b1011_1111; end
        2: begin W = W2; AN = 8'b1101_1111; end
        3: begin W = W3; AN = 8'b1110_1111; end
        4: begin W = W4; AN = 8'b1111_0111; end
        5: begin W = W5; AN = 8'b1111_1011; end
        6: begin W = W6; AN = 8'b1111_1101; end 
        7: begin W = W7; AN = 8'b1111_1110; end
        endcase

endmodule

module bitcounter3(Clock, Q);
    input Clock;
    output reg [2:0] Q;
    
    always @(posedge Clock)
            Q <= Q + 1;
endmodule
