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
    MOVE.W D2,D1
    AND.W (MULS_VALUE),D1
    CMP.W MULS_VALUE,D1
    BNE DONE_MULS_CHECK
    MOVE.W D2,D1
    AND.W #$0038,D1      
    LSR #3,D1
    CMP #1,D1
    BEQ DONE_MULS_CHECK
    CMP #7,D1
    BNE SKIP_MULS_ADD_REG_CHECK
    MOVE.W D2,D1
    AND.W #$0007,D1
    CMP #4,D2
    BGT DONE_MULS_CHECK
SKIP_MULS_ADD_REG_CHECK
    MOVE #1,D7
    MOVE.W D2,D1
    JSR PRINTING_MULS   
DONE_MULS_CHECK    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
EOR_OR_CMP_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    AND.W (EOR_OR_CMP_VALUE),D1
    CMP.W EOR_OR_CMP_VALUE,D1
    BNE DONE_CMP_OR_EOR_CHECK    
    MOVE.W D2,D1
    LSL #7,D1
    LSR #7,D1
    LSR #6,D1
    CMP #3,D1
    BGT EOR_CHECK
    MOVE.W D2,D1
    AND.W #0038,D1
    LSR #3,D1
    CMP #7,D1
    BNE SKIP_CMP_ADD_REG_CHECK
    MOVE.W D2,D1
    AND.W #$0007,D1
    CMP #4,D2
    BGT DONE_CMP_OR_EOR_CHECK

    BRA SKIP_CMP_ADD_REG_CHECK
EOR_CHECK
    MOVE.W D2,D1
    AND.W #$01C0,D1
    LSR #6,D1
    CMP #7,D1
    BEQ DONE_CMP_OR_EOR_CHECK
    MOVE.W D2,D1
    AND.W #$0038,D1
    LSR #3,D1
    CMP #1,D1
    BEQ DONE_CMP_OR_EOR_CHECK
    CMP #7,D1
    BNE SKIP_EOR_ADD_REG_CHECK
    MOVE.W D2,D1
    AND.W #$0007,D1
    CMP #4,D2
    BGT DONE_CMP_OR_EOR_CHECK
    BRA SKIP_EOR_ADD_REG_CHECK
SKIP_EOR_ADD_REG_CHECK
    MOVE.W #1,D7
    JSR PRINTING_EOR 
    BRA DONE_CMP_OR_EOR_CHECK
SKIP_CMP_ADD_REG_CHECK 
    MOVE.W #1,D7
    JSR PRINTING_CMP 
    BRA DONE_CMP_OR_EOR_CHECK
DONE_CMP_OR_EOR_CHECK    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
SUB_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    AND.W (SUB_VALUE),D1
    CMP.W SUB_VALUE,D1
    BNE DONE_SUB_CHECK
    MOVE.W D2,D1
    LSl #7,D1
    LSR #7,D1
    LSR #6,D1
    CMP #7,D1
    BEQ DONE_SUB_CHECK
    CMP #3,D1
    BGT SUB_D_TO_EA_EA_CHECK
    MOVE.W D2,D1
    AND.W #$0038,D1
    LSR #3,D1
    CMP #7,D1
    BNE GOOD_EA_TO_D_SUB
    MOVE.W D2,D1
    AND.W #$0007,D1
    CMP #3,D1
    BGT DONE_SUB_CHECK
SUB_D_TO_EA_EA_CHECK
    MOVE.W D2,D1
    AND.W #$0038,D1
    LSR #3,D1
    CMP #0,D1
    BEQ DONE_SUB_CHECK
    CMP #1,D1
    BEQ DONE_SUB_CHECK
    CMP #7,D1
    BNE GOOD_D_TO_EA_SUB
    MOVE.W D2,D1
    AND.W #$0007,D1
    CMP #3,D1
    BGT DONE_SUB_CHECK    
GOOD_EA_TO_D_SUB
    MOVE.W D2,D1
    MOVE.W #1,D7
    JSR PRINTING_SUB_EA_TO_D
    BRA DONE_SUB_CHECK
GOOD_D_TO_EA_SUB
    MOVE.W D2,D1
    MOVE.W D1,D7
    JSR PRINTING_SUB_D_TO_EA
    BRA DONE_SUB_CHECK
DONE_SUB_CHECK    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
DIVS_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    AND.W (DIVS_VALUE),D1
    CMP.W DIVS_VALUE,D1
    BNE DONE_DIVS_CHECK
    MOVE.W D2,D1
    AND.W #$0038,D1      
    LSR #3,D1
    CMP #1,D1
    BEQ DONE_DIVS_CHECK
    CMP #7,D1
    BNE SKIP_DIVS_ADD_REG_CHECK
    MOVE.W D2,D1
    CMP #7,D1
    AND.W #$0007,D1
    CMP #4,D2
    BGT DONE_DIVS_CHECK
SKIP_DIVS_ADD_REG_CHECK
    MOVE #1,D7
    MOVE.W D2,D1
    JSR PRINTING_DIVS                      
DONE_DIVS_CHECK    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
OR_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    AND.W (OR_VALUE),D1
    CMP.W OR_VALUE,D1
    BNE DONE_OR_CHECK
    MOVE.W D2,D1
    LSl #7,D1
    LSR #7,D1
    LSR #6,D1
    CMP #7,D1
    BEQ DONE_OR_CHECK
    CMP #3,D1
    BGT OR_D_TO_EA_EA_CHECK
    MOVE.W D2,D1
    AND.W #$0038,D1
    LSR #3,D1
    CMP #7,D1
    BNE GOOD_EA_TO_D_OR
    MOVE.W D2,D1
    AND.W #$0007,D1
    CMP #3,D1
    BGT DONE_OR_CHECK
OR_D_TO_EA_EA_CHECK
    MOVE.W D2,D1
    AND.W #$0038,D1
    LSR #3,D1
    CMP #0,D1
    BEQ DONE_OR_CHECK
    CMP #1,D1
    BEQ DONE_OR_CHECK
    CMP #7,D1
    BNE GOOD_D_TO_EA_OR
    MOVE.W D2,D1
    AND.W #$0007,D1
    CMP #3,D1
    BGT DONE_OR_CHECK    
GOOD_EA_TO_D_OR
    MOVE.W D2,D1
    MOVE.W #1,D7
    JSR PRINTING_OR_EA_TO_D
    BRA DONE_OR_CHECK
GOOD_D_TO_EA_OR
    MOVE.W D2,D1
    MOVE.W D1,D7
    JSR PRINTING_OR_D_TO_EA
    BRA DONE_OR_CHECK
DONE_OR_CHECK    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
BCC_OR_BRA_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    AND.W (BCC_OR_BRA_VALUE),D1
    CMP.W BCC_OR_BRA_VALUE,D1
    BNE BCC_OR_BRA_DONE  
    MOVE.W D2,D1
    CMP.W #$6000,D1
    JSR PRINT_BCC
    ;print out conditions
    JSR PRINTING_BCC  
    MOVE.B #1,D7
    BRA BCC_OR_BRA_DONE
BCC_OR_BRA_DONE    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
SUBQ_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    AND.W (SUBQ_VALUE),D1
    CMP.W SUBQ_VALUE,D1
    BNE SUBQ_CHECK_DONE 
    MOVE.W D2,D1
    AND.W #$0038, D1
    LSR #3, D1
    CMP #7, D1
    BNE SUBQ_GOOD_CHECK
    MOVE.W D2,D1
    AND.W #$0007,D1
    CMP #1,D1
    BGT SUBQ_CHECK_DONE
    BRA SUBQ_GOOD_CHECK
SUBQ_GOOD_CHECK
    MOVE.W #1,D7
    JSR PRINTING_SUBQ
SUBQ_CHECK_DONE    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
JSR_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
RTS_OP_CHECK:                         
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    CMP.L RTS_VALUE,D2
    BNE RTS_DONE 
    MOVE #1,D7   
    JSR PRINT_RTS
RTS_DONE    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
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
NOP_OP_CHECK   
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    CMP.W NOP_VALUE,D2
    BNE NOP_DONE   
    MOVE.B #1,D7
    JSR PRINT_NOP              
NOP_DONE    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS
ADDS_OP_CHECK   
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
                     
    MOVEM.L (SP)+,D0-D6/A0-A6                   ;restore any data
    RTS












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
