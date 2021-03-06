*-----------------------------------------------------------
* Title      : INPUT
* Written by : Brad Minogue
* Date       : 12/13/14
* Description: Input for decompiler
*-----------------------------------------------------------

START_INPUT
                        
 *   MOVEM.L D0-D6/A0-A4/A6,-(SP)                  ;back up any data we might step on
    LEA START_INPUT,A3
    MOVE.B #27,D4                               ;we have 25 inputs to check
    CLR.L D3                                    ;we are going to count up
    ADD #1,D3
    CMP D4,D3                                   ;test if we looked threw all possible op codes
    BEQ NOTHING_FOUND                           ;if we have print out as data and end the loop
    MOVEA.L (A3)+,A2                            ;otherwise load up the next test
    
    CLR.L D7                                    ;this function call will test and decode op code found in D2
    JSR (A2)                                    ;will set D7 if a OP code was decoded
    CMP #0,D7                                    ;testing if we decoded something
    BNE DONE                                    ;yeap, move on to next input
    BRA START_INPUT                           ;otherwise keep looping
    

    JSR DATA_PRINT                              ;we tested every OP, now print as data

END_INPUT






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
