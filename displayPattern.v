`timescale 1ns / 1ps

//returns which pattern output
module diplayNumber(userMinTens, userMinOnes, userSecTens, userSecOnes, minTens, minOnes, secTens, secOnes, C1, C2, C3, C4, C5, C6, C7, C8);
    input [3:0] userMinTens, userMinOnes, userSecTens, userSecOnes, minTens, minOnes, secTens, secOnes;
    output [6:0]  C1, C2, C3, C4, C5, C6, C7, C8;
    
    display7Seg first(userMinTens,C1);
    display7Seg second(userMinOnes,C2);
    display7Seg third(userSecTens,C3);
    display7Seg fourth(userSecOnes,C4);
    display7Seg fifth(minTens,C5);
    display7Seg sixth(minOnes,C6);
    display7Seg seventh(secTens,C7);
    display7Seg eighth(secOnes,C8);
endmodule

module display7Seg(segNumber, Cseg);
    input [3:0] segNumber;
    output reg [6:0] Cseg;
    
    always@(segNumber)begin
        case(segNumber)
            0: Cseg = 7'b1000000; //0
            1: Cseg = 7'b1111001; //1
            2: Cseg = 7'b0100100; //2
            3: Cseg = 7'b0110000; //3
            4: Cseg = 7'b0011001; //4
            5: Cseg = 7'b0010010; //5
            6: Cseg = 7'b0000010; //6
            7: Cseg = 7'b1111000; //7
            8: Cseg = 7'b0000000; //8
            9: Cseg = 7'b0010000; //9 
            default: Cseg = 7'b1111111;
        endcase
    end  
endmodule