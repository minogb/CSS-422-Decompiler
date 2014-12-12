*-----------------------------------------------------------
* Title      : Operation check functions
* Written by : Brad Minogue
* Date       : 12/12/14
* Description: Functions that check what OP type we are
*-----------------------------------------------------------

BCLR_IMMEDIATE_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
RO_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
    LEA JSR_VALUE,A1
    MOVE.B #14,D0
    TRAP #15
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
LS_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
AS_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
MULS_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
EOR_OR_CMP_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
SUB_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
DIVS_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS 
OR_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
BCC_OR_BRA_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
SUBQ_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
JSR_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
RTS_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS 
MOVEM_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
NEG_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
LEA_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
MOVE_TO_SR_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
MOVE_TO_CCR_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
MOVE_FM_CCR_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
MOVE_FM_SR_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
CMPI_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
BCLR_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
MOVEA_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
ORI_OP_CHECK:                         
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
                      
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;restore any data
    RTS
    


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
