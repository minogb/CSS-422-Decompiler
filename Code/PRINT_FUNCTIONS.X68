*-----------------------------------------------------------
* Title      : Print Functions
* Written by : Brad Minogue
* Date       : 12/12/14
* Description: General use print fuctions
*-----------------------------------------------------------
*----------------------------------------------------------------------
*The functions bellow are callee saved functions that do basic things
*such as print. The idea is to reduce over all code lenght and 
*readability
DATA_PRINT:
    MOVEM.L D0-D2/A0-A1,-(SP)         ;back up any data we might step on
    LEA DATA_TEXT,A1                  ;printing DATA
    MOVE.B #14,D0
    TRAP #15    
    
    JSR PRINT_SPACE                   ;formating YEAS
    
    MOVE.W D2,D1                      ;print out the data stored in D2
    MOVE.B #3,D0
    TRAP #15

    MOVEM.L (SP)+,D0-D2/A0-A1         ;restore any data    
    RTS
PRINT_LONG:                         
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA LONG_TEXT,A1                  ;print out .L
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_WORD:                        
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA WORD_TEXT,A1                  ;print out .W
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_BYTE:                        
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA BYTE_TEXT,A1                  ;print out .B
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_SPACE:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA SPACE_TEXT,A1                 ;print out a SPACE
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_COMMA:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA COMMA_TEXT,A1                 ;print out ,
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_REG:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA REG_TEXT,A1                   ;print out D
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_VALUE:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA VALUE_TEXT,A1                 ;print out #
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_NOP:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA NOP_TEXT,A1                   ;print out NOP
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_JSR:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA JSR_TEXT,A1                   ;print out JSR
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_RTS:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA RTS_TEXT,A1                   ;print out RTS
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_LS:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA LS_TEXT,A1                    ;print out LS
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_AS:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA AS_TEXT,A1                    ;print out AS
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_RO:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA RO_TEXT,A1                    ;print out RO
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_RIGHT:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA RIGHT_TEXT,A1                 ;print out R
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_LEFT:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA LEFT_TEXT,A1                  ;print out L
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_LEA:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA LEA_TEXT,A1                   ;print out LEA
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_CCR:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA CCR_TEXT,A1                   ;print out CCR
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_SR:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA SR_TEXT,A1                    ;print out SR
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_MOVE:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA MOVE_TEXT,A1                  ;print out MOVE
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_MOVEM:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA MOVEM_TEXT,A1                 ;print out MOVEM
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender                               ;return to sender
PRINT_MOVEA:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA MOVEA_TEXT,A1                 ;print out MOVEA
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS 
PRINT_NEG:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA   NEG_TEXT,A1                 ;print out NEG
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_BRA:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA   BRA_TEXT,A1                 ;print out BRA
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_BCC:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA   COMMA_TEXT,A1               ;print out BCC
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_MULS:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA   MULS_TEXT,A1                ;print out MULS
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_DIVS:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA   DIVS_TEXT,A1                ;print out DIVS
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_CMP:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA   CMP_TEXT,A1                 ;print out CMP
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_CMPI:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA  CMPI_TEXT,A1                 ;print out CMPI
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_ORI:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA ORI_TEXT,A1                   ;print out ORI
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_OR:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA  OR_TEXT,A1                   ;print out OR
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_SUB:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA  SUB_TEXT,A1                  ;print out SUB
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                              ;return to sender
PRINT_SUBQ:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA  SUBQ_TEXT,A1                 ;print out SUBQ
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_ADD:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA  ADD_TEXT,A1                  ;print out ADD
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_ADD_REG:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA ADD_REG_TEXT,A1               ;print out A
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS                               ;return to sender
PRINT_D1:                             ;assumes data is in D1, common for printing data in OP CODE
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    MOVE.B #3,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS
PRINT_DER_ADD:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA LEFT_PAR_TEXT,A1
    MOVE.B #14,D0                
    TRAP #15
    
    JSR PRINT_ADD_REG
    JSR PRINT_D1
    
    LEA RIGHT_PAR_TEXT,A1
    MOVE.B #14,D0                
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS
PRINT_INC_DER_ADD:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA LEFT_PAR_TEXT,A1
    MOVE.B #14,D0                
    TRAP #15
    
    JSR PRINT_D1
    
    LEA RIGHT_PAR_TEXT,A1
    MOVE.B #14,D0                
    TRAP #15

    LEA PLUS_TEXT,A1
    MOVE.B #14,D0                
    TRAP #15
    
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS
PRINT_DEC_DER_ADD:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    
    LEA MINUS_TEXT,A1
    MOVE.B #14,D0                
    TRAP #15
    
    LEA LEFT_PAR_TEXT,A1
    MOVE.B #14,D0                
    TRAP #15
    
    JSR PRINT_D1
    
    LEA RIGHT_PAR_TEXT,A1
    MOVE.B #14,D0                
    TRAP #15

    
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS
PRINT_UNSUPPORTED_EA:
    MOVEM.L D0/A0-A1,-(SP)            ;back up any data we might step on
    LEA UNSUPPORTED_EA_TEXT,A1
    MOVE.B #14,D0
    TRAP #15
    MOVEM.L (SP)+,D0/A0-A1            ;restore any data
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
