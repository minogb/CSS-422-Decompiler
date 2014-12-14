*-----------------------------------------------------------
* Title      : Decompiler
* Written by : Brad Minogue
* Date       : 12/11/14
* Description: Decompiles code in an hardcoded range
*-----------------------------------------------------------
    ORG    $1000
START: 
;hand over to our controller
    BRA MAIN

*-----------------------INCLUDES---------------------------------------
    INCLUDE 'OP_VARIABLES.X68'
    INCLUDE 'OUTPUT_VARIABLES.X68'
    INCLUDE 'OP_CHECK.X68'
    INCLUDE 'PRINT_FUNCTIONS.X68'
    INCLUDE 'VERIFY_EA.X68'
    INCLUDE 'PRINT_OP.X68'
    INCLUDE 'DECODE_EA.X68'
    INCLUDE 'INPUT.X68'
*----------------------------------------------------------------------
MAIN
    LEA.L START_INPUT,A6
    JSR LOOP_INPUT
    SIMHALT             ; halt simulator
    
*----------------------------------------------------------------------
LOOP_INPUT:                         
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on
    ;load up input here
    LEA START_INPUT,A5
    LEA END_INPUT,A6
    JSR PRINT_HEADER
    CLR D4
    MOVE #30,D5
LOOP_INPUTS
    ADD #1,D4
    CMP D5,D4
    BNE CONTINUE_LOOP
   
    CLR D4
    JSR PRINT_END_LINE
    JSR PRINT_HEADER
CONTINUE_LOOP
    CLR.L D1
    MOVE.L A5,D1

    MOVE #16,D2
    MOVE #15,D0
    TRAP #15
    JSR PRINT_SPACE_BETWEEN_ADDR_OP
    MOVE.W (A5)+,D2
    JSR VALID_OP_CHECK                          ;valid op check will print our input correctly
    JSR PRINT_END_LINE
    CMP.W A6,A5
    BGE DONE_INPUT
    BRA LOOP_INPUTS
    ;some kind of input done check
DONE_INPUT
    MOVEM.L (SP)+,D0-D6/A0-A4/A6                    ;restore any data
    RTS
    
*----------------------------------------------------------------------
*checks input for valid OP code
*takes input at D2, jumps to print as data
*if found as invalid automaticaly or prints the OP code
*----------------------------------------------------------------------
VALID_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                  ;back up any data we might step on
    LEA TESTS_ARRAY,A3
    MOVE.B #27,D4                               ;we have 25 inputs to check
    CLR.L D3                                    ;we are going to count up
TESTING_LOOP
    ADD #1,D3
    CMP D4,D3                                   ;test if we looked threw all possible op codes
    BEQ NOTHING_FOUND                           ;if we have print out as data and end the loop
    MOVEA.L (A3)+,A2                            ;otherwise load up the next test
    
    CLR.L D7                                    ;this function call will test and decode op code found in D2
    JSR (A2)                                    ;will set D7 if a OP code was decoded
    CMP #0,D7                                    ;testing if we decoded something
    BNE DONE                                    ;yeap, move on to next input
    BRA TESTING_LOOP                            ;otherwise keep looping
    
NOTHING_FOUND
    JSR DATA_PRINT                              ;we tested every OP, now print as data

;in eiether case of running out of tests or finding a test we need to branch to done
;to restore control to input loop   
DONE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6                  ;restore any data
    RTS
*------------------------------------------------------------------
TESTS_ARRAY DC.L ADDS_OP_CHECK, RO_OP_CHECK, LS_OP_CHECK, AS_OP_CHECK, MULS_OP_CHECK, EOR_OR_CMP_OP_CHECK, SUB_OP_CHECK
    DC.L DIVS_OP_CHECK, OR_OP_CHECK, BCC_OR_BRA_OP_CHECK, SUBQ_OP_CHECK, JSR_OP_CHECK, RTS_OP_CHECK, NOP_OP_CHECK, MOVEM_OP_CHECK
    DC.L NEG_OP_CHECK, LEA_OP_CHECK, MOVE_TO_SR_OP_CHECK, MOVE_TO_CCR_OP_CHECK, MOVE_FM_CCR_OP_CHECK
    DC.L MOVE_FM_SR_OP_CHECK, CMPI_OP_CHECK, BCLR_OP_CHECK, MOVEA_OP_CHECK, MOVE_OP_CHECK, ORI_OP_CHECK
*-------------------------TEMP USE---------------------------------
EA_TEXT DC.B 'EA',0
SAMPLE_INPUT DC.W $5692
    END    START        ; last line of source


















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
