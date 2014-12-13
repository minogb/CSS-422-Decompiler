*-----------------------------------------------------------
* Title      : Operation check functions
* Written by : Brad Minogue
* Date       : 12/12/14
* Description: Functions that check what OP type we are
*-----------------------------------------------------------
SET EQU $1
BCLR_IMMEDIATE_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
RO_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    CLR D7                                      ;clear our return value, default 0
    MOVE.W D2,D1                                ;copy data
    AND.W (RO_VALUE),D1                         ;bitmask with RO's value
    CMP.W RO_VALUE,D1                           ;compare bitmasked value and RO
    BNE DONE_RO_CHECK                           ;if we are not RO end this test
    JSR VERIFY_RO                               ;make sure we are a valid RO OP

DONE_RO_CHECK     MOVEM.L (SP)+,D0-D6/A0-A6     ;restore any data
    RTS
VERIFY_RO:
    MOVE.W D2,D1                                ;copy data
    LSL.W #8,D1                                 ;Depending on our size
    LSR.W #8,D1                                 ;we are using memeory shift
    LSR.W #6,D1                                 ;or register shift
    CMP.W #3,D1
    BNE GOOD_VER_RO                             ;if we are reg shift we know we are good here
    ;this section decodes the memory shift mode
    JSR VERIFY_SHIFT_EA                         ;call a generic SHIFT verification function
    CMP #0,D7                                   ;to see if we have a valid EA mode
    BEQ DONE_VER_RO                             ;the function has the same return as this so if it is not set, we are not RO
    ;call function to decode ls memory shift mode
    MOVE.B #1,D7
    JSR FPRINT_SHIFT_REGISTER
DONE_VER_RO
    RTS
GOOD_VER_RO
    MOVE.B #1,D7
    ;call ls register shift function
    JSR FPRINT_SHIFT_REGISTER
    BRA DONE_VER_RO

*-----------------------------------------------
LS_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    CLR D7
    MOVE.W D2,D1
    AND.W (LS_VALUE),D1
    CMP.W LS_VALUE,D1
    BNE DONE_LS_CHECK
    JSR VERIFY_LS
DONE_LS_CHECK     MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
VERIFY_LS:
    MOVE.W D2,D1                                ;copy data
    LSL.W #8,D1                                 ;Depending on our size
    LSR.W #8,D1                                 ;we are using memeory shift
    LSR.W #6,D1                                 ;or register shift
    CMP.W #3,D1
    BNE GOOD_VER_LS                             ;if we are reg shift we know we are good here
    ;this section decodes the memory shift mode
    JSR VERIFY_SHIFT_EA                         ;call a generic SHIFT verification function
    CMP #0,D7                                   ;to see if we have a valid EA mode
    BEQ DONE_VER_LS                             ;the function has the same return as this so if it is not set, we are not LS
    ;call function to decode ls memory shift mode
    MOVE.B #1,D7
    JSR FPRINT_SHIFT_REGISTER

DONE_VER_LS
    RTS
GOOD_VER_LS
    MOVE.B #1,D7
    ;call ls register shift function
    JSR FPRINT_SHIFT_REGISTER
    BRA DONE_VER_LS
*-----------------------------------------------
AS_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    CLR D7
    MOVE.W D2,D1
    AND.W (AS_VALUE),D1
    CMP.W AS_VALUE,D1
    BNE DONE_AS_CHECK
    JSR VERIFY_AS
DONE_AS_CHECK     MOVEM.L (SP)+,D0-D6/A0-A6     ;restore any data
    RTS
VERIFY_AS:
    MOVE.W D2,D1                                ;copy data
    LSL.W #8,D1                                 ;Depending on our size
    LSR.W #8,D1                                 ;we are using memeory shift
    LSR.W #6,D1                                 ;or register shift
    CMP.W #3,D1
    BNE GOOD_VER_AS                             ;if we are reg shift we know we are good here
    ;this section decodes the memory shift mode
    JSR VERIFY_SHIFT_EA                         ;call a generic SHIFT verification function
    CMP #0,D7                                   ;to see if we have a valid EA mode
    BEQ DONE_VER_AS                             ;the function has the same return as this so if it is not set, we are not AS
    ;call function to decode ls memory shift mode
    MOVE.B #1,D7
    JSR PRINT_SHIFT_MEMORY
DONE_VER_AS
    RTS
GOOD_VER_AS
    MOVE.B #1,D7
    ;call ls register shift function
    JSR FPRINT_SHIFT_REGISTER
    BRA DONE_VER_AS
    
MULS_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
EOR_OR_CMP_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
SUB_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
DIVS_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
OR_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
BCC_OR_BRA_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
SUBQ_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
JSR_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
RTS_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
MOVEM_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
NEG_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
LEA_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
MOVE_TO_SR_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
MOVE_TO_CCR_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
MOVE_FM_CCR_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
MOVE_FM_SR_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
CMPI_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
BCLR_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
MOVEA_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
ORI_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
MOVE_OP_CHECK   
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
