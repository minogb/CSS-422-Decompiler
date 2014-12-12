*-----------------------------------------------------------
* Title      : Decompiler
* Written by : Brad Minogue
* Date       : 12/11/14
* Description: Decompiles code in an hardcoded range
*-----------------------------------------------------------
    ORG    $1000
START: 
    BRA MAIN
*-----------------------INCLUDES---------------------------------------
    INCLUDE 'OP_VARIABLES.X68'
    INCLUDE 'OUTPUT_VARIABLES.X68'
    INCLUDE 'OP_CHECK.X68'
    INCLUDE 'PRINT_FUNCTIONS.X68'
*----------------------------------------------------------------------
MAIN
    *JSR LOOP_INPUT
    JSR PRINT_JSR
    SIMHALT             ; halt simulator
    
*----------------------------------------------------------------------
LOOP_INPUT:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on
    JSR VALID_OP_CHECK
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
    
*----------------------------------------------------------------------
*checks input for valid OP code
*takes input at D2, jumps to print as data
*if found as invalid automaticaly
*----------------------------------------------------------------------
VALID_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on
    MOVE.B (NUM_OF_OP),D4
    LEA TEST_ARRAY,A3
OP_CHECK_LOOP
    SUBQ #1,D4
    ;Call the comparison here
    JSR (A3)
    ADD.L #1,A3
    
    CMP #0,D4                                   ;once we hit 0 in D4
    *BRA DATA_PRINT                              ;we tested every OP, now print as data
    
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
*----------------------------------------------------------------------
TEST_ARRAY DC.L RO_OP_CHECK, LS_OP_CHECK, AS_OP_CHECK, MULS_OP_CHECK, EOR_OR_CMP_OP_CHECK, SUB_OP_CHECK
    DC.L DIVS_OP_CHECK,OR_OP_CHECK,BCC_OR_BRA_OP_CHECK,SUBQ_OP_CHECK, JSR_OP_CHECK,RTS_OP_CHECK,MOVEM_OP_CHECK
    DC.L NEG_OP_CHECK,LEA_OP_CHECK,MOVE_TO_SR_OP_CHECK, MOVE_TO_CCR_OP_CHECK, MOVE_FM_CCR_OP_CHECK
    DC.L MOVE_FM_SR_OP_CHECK,CMPI_OP_CHECK,BCLR_OP_CHECK,MOVEA_OP_CHECK,ORI_OP_CHECK

*-------------------------TEMP USE---------------------------------
EA_TEXT DC.B 'EA',0
    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
