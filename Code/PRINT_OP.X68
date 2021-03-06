*-----------------------------------------------------------
* Title      : Print OP
* Written by : Brad Minogue
* Date       : 12/12/14
* Description: Prints out formated operation, assumes it has
*varified already, new line at every function call
*takes D2 as input
*-----------------------------------------------------------
FPRINT_SHIFT_REGISTER:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    MOVE.B D2,D1
    
    LSL #8,D1
    LSL #3,D1
    LSR #8,D1
    LSR #6,D1
    
    CMP #0,D1
    BEQ PRINTING_AS
    CMP #1,D1
    BEQ PRINTING_LS 
    JSR PRINT_RO
    JSR GET_SHIFT_DIR
    BRA SHIFT_SIZE
PRINTING_AS
    JSR PRINT_AS
    JSR GET_SHIFT_DIR
    BRA SHIFT_SIZE
PRINTING_LS
    JSR  PRINT_LS
    JSR GET_SHIFT_DIR                           
    BRA SHIFT_SIZE
SHIFT_SIZE
    MOVE.W D2,D1
    LSL #8,D1
    LSR #8,D1
    LSR #6,D1  
*Note size 3 is resevered to tell us if this
*is shifting memory
    CMP #0,D1
    BEQ SHIFT_BYTE
    CMP #1,D1
    BEQ SHIFT_WORD
    CMP #2,D1
    BEQ SHIFT_LONG 
GET_SHIFT_DIR:
    MOVE.W D2,D1
    LSL #7,D1
    LSR #7,D1
    LSR #8,D1
    CMP #0,D1
    BEQ PRINT_SHIFT_RIGHT
    JSR PRINT_LEFT
    RTS
PRINT_SHIFT_RIGHT
    JSR PRINT_RIGHT
    RTS
 
SHIFT_BYTE
    JSR PRINT_BYTE
    JSR PRINT_SPACE
    BRA PRINTING_COUNT_OR_SOURCE
SHIFT_LONG
    JSR PRINT_LONG
    JSR PRINT_SPACE
    BRA PRINTING_COUNT_OR_SOURCE
SHIFT_WORD
    JSR PRINT_WORD
    JSR PRINT_SPACE
    BRA PRINTING_COUNT_OR_SOURCE
    
PRINTING_COUNT_OR_SOURCE
*Note I/R value (in bit 5) will tell us if we 
*are using a register or not to get shift value
    MOVE.W D2,D1
    LSL #8,D1
    LSL #2,D1
    LSR #8,D1
    LSR #7,D1
    JSR PRINT_SPACE
    CMP #0,D1
    BEQ SHIFT_IMMEDIATE
    JSR PRINT_REG
    JSR PRINT_SHIFT_SIZE
    JSR PRINT_SHIFT_DEST
    BRA DONE_PRINT_SHIFT
SHIFT_IMMEDIATE
    JSR PRINT_VALUE
    JSR PRINT_SHIFT_SIZE
    JSR PRINT_SHIFT_DEST
    BRA DONE_PRINT_SHIFT
PRINT_SHIFT_SIZE:
    MOVE.W D2,D1
    LSL #4,D1
    LSR #5,D1
    LSR #8,D1
    JSR PRINT_D1
    RTS
PRINT_SHIFT_DEST
    JSR PRINT_COMMA
    JSR PRINT_REG
    MOVE.W D2,D1
    AND.W #$0003,D1
    JSR PRINT_D1
    RTS
DONE_PRINT_SHIFT    
    MOVEM.L (SP)+,D0-D6/A0-A4/A6                   ;back up any data we might step on   
    RTS
PRINT_SHIFT_MEMORY:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    
    LSL #5,D1
    LSR #5,D1
    LSR #8,D1
    LSR #1,D1
    
    CMP #0,D1
    BEQ PRINTING_AS_MEM
    CMP #1,D1
    BEQ PRINTING_AS_MEM
    MOVE.W D2,D1
    JSR PRINT_RO
    JSR GET_SHIFT_DIR
SHIFT_MEM_EA
    JSR PRINT_SPACE
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
    
PRINTING_AS_MEM
    MOVE.W D2,D1
    JSR PRINT_AS
    JSR GET_SHIFT_DIR
    BRA SHIFT_MEM_EA
PRINTING_LS_MEM
    MOVE.W D2,D1
    JSR  PRINT_LS
    JSR GET_SHIFT_DIR                           
    BRA SHIFT_MEM_EA



PRINTING_BCC:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    MOVE.W D2,D1
    LSL #4,D1
    LSR #8,D1
    LSR #4,D1
RA_CON
    CMP.W #0,D1
    BNE CC_CON
    LEA RA_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
CC_CON
    CMP.W #$4,D1
    BNE CS_CON
    LEA CC_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
CS_CON
    CMP.W #$5,D1
    BNE EQ_CON
    LEA CS_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
EQ_CON
    CMP.W #$7,D1
    BNE GE_CON
    LEA EQ_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
GE_CON
    CMP.W #$C,D1
    BNE GT_CON
    LEA GE_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
GT_CON
    CMP.W #$E,D1
    BNE HI_CON
    LEA GE_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
HI_CON
    CMP.W #$2,D1
    BNE LE_CON
    LEA HI_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
LE_CON
    CMP.W #$F,D1
    BNE LS_CON
    LEA LE_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
LS_CON
    CMP.W #$3,D1
    BNE LT_CON
    LEA LS_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
LT_CON
    CMP.W #$D,D1
    BNE MI_CON
    LEA LT_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
MI_CON
    CMP.W #$B,D1
    BNE NE_CON
    LEA MI_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
NE_CON
    CMP.W #$6,D1
    BNE PL_CON
    LEA NE_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
PL_CON
    CMP.W #$A,D1
    BNE PL_CON
    LEA VC_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
VC_CON
    CMP.W #$8,D1
    BNE VS_CON
    LEA VC_TEXT,A1
    BRA PRINTING_LOAED_CONDITION
VS_CON
    LEA VS_TEXT,A1
    BRA PRINTING_LOAED_CONDITION  
PRINTING_LOAED_CONDITION  
    MOVE.B #14,D0
    TRAP #15
PRINTING_DISPLACE_MENT
    JSR PRINT_SPACE
    MOVE.W D2,D1
    AND.W #$00FF,D1
    CMP #$00,D1
    BEQ DIS_MENT_16
    CMP #$FF,D1
    BEQ DIS_MENT_32
    JSR PRINT_D1
    BRA BCC_PRINT_DONE 
    JSR PRINT_D1
DIS_MENT_16
    ADD.L #2,A5
    MOVE.B (A5),D1
    JSR PRINT_D1
    BRA BCC_PRINT_DONE
DIS_MENT_32
    ADD.L #4,A5
    MOVE.B (A5),D1
    JSR PRINT_D1
    BRA BCC_PRINT_DONE
BCC_PRINT_DONE    
    MOVEM.L (SP)+,D0-D6/A0-A4/A6 
    RTS


PRINTING_MULS:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_MULS
    MOVE.W D2,D1
    JSR PRINTING_MULS_OR_DIVS
    MOVEM.L (SP)+,D0-D6/A0-A4/A6 
    RTS
PRINTING_MULS_OR_DIVS:
    JSR PRINT_SPACE
    JSR DECODE_AS_SOURCE
    JSR PRINT_COMMA
    JSR PRINT_SPACE
    LSL #4,D1
    LSR #5,D1
    LSR #8,D1
    JSR PRINT_REG
    JSR PRINT_D1 
    RTS
PRINTING_DIVS
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_DIVS
    MOVE.W D2,D1
    JSR PRINTING_MULS_OR_DIVS
    MOVEM.L (SP)+,D0-D6/A0-A4/A6 
    RTS

PRINTING_CMP:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_CMP
    MOVE.W D2,D1
    LSL #7,D1
    LSR #7,D1
    LSR #6,D1
    CMP #0,D1
    BNE CMP_WORD_PRINT
    JSR PRINT_BYTE
    BRA CMP_REG_PRINT
CMP_WORD_PRINT
    CMP #1,D1
    BNE CMP_LONG_PRINT
    JSR PRINT_WORD
    BRA CMP_REG_PRINT
CMP_LONG_PRINT
    JSR PRINT_LONG
CMP_REG_PRINT
    JSR PRINT_SPACE
    JSR DECODE_AS_SOURCE
    JSR PRINT_COMMA
    MOVE.W D2,D1
    LSL #4,D1
    LSR #5,D1
    LSR #8,D1
    JSR PRINT_REG
    JSR PRINT_D1
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS    

PRINTING_EOR:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_EOR
    MOVE.W D2,D1
    LSL #7,D1
    LSR #7,D1
    LSR #6,D1
    CMP #4,D1
    BNE EOR_WORD_PRINT
    JSR PRINT_BYTE
    BRA EOR_REG_PRINT
EOR_WORD_PRINT
    CMP #5,D1
    BNE EOR_LONG_PRINT
    JSR PRINT_WORD
    BRA EOR_REG_PRINT
EOR_LONG_PRINT
    JSR PRINT_LONG
EOR_REG_PRINT
    JSR PRINT_SPACE

    MOVE.W D2,D1
    LSL #4,D1
    LSR #5,D1
    LSR #8,D1
    JSR PRINT_REG
    JSR PRINT_D1
    JSR PRINT_COMMA
    MOVE.W D2,D1
    JSR DECODE_AS_SOURCE
    
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS        
    
PRINTING_SUB_EA_TO_D: 
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_SUB
    MOVE.W D2,D1
    LSL #7,D1
    LSR #7,D1
    LSR #6,D1
    CMP #0,D1
    BNE SUB_V1_WORD
    JSR PRINT_BYTE
    BRA SUB_V1_EA
SUB_V1_WORD
    CMP #1,D1
    BNE SUB_V1_LONG
    JSR PRINT_WORD
    BRA SUB_V1_EA
SUB_V1_LONG
    JSR PRINT_LONG
    BRA SUB_V1_EA
SUB_V1_EA
    JSR PRINT_SPACE
    MOVE.W D2,D1
    JSR DECODE_AS_SOURCE
    JSR PRINT_COMMA
    JSR PRINT_REG
    MOVE.W D2,D1
    LSL #4,D1
    LSR #5,D1
    LSR #8,D1
    JSR PRINT_D1
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS     
PRINTING_SUB_D_TO_EA:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_SUB
    MOVE.W D2,D1
    LSL #7,D1
    LSR #7,D1
    LSR #6,D1
    CMP #4,D1
    BNE SUB_V2_WORD
    JSR PRINT_BYTE
    BRA SUB_V2_EA
SUB_V2_WORD
    CMP #5,D1
    BNE SUB_V1_LONG
    JSR PRINT_WORD
    BRA SUB_V2_EA
SUB_V2_LONG
    JSR PRINT_LONG
    BRA SUB_V2_EA
SUB_V2_EA
    JSR PRINT_SPACE
    
    JSR PRINT_REG
    MOVE.W D2,D1
    LSL #4,D1
    LSR #5,D1
    LSR #8,D1
    JSR PRINT_D1
    JSR PRINT_COMMA
    MOVE.W D2,D1
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6 
    RTS   
    
    
PRINTING_OR_EA_TO_D: 
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_OR
    MOVE.W D2,D1
    LSL #7,D1
    LSR #7,D1
    LSR #6,D1
    CMP #0,D1
    BNE OR_V1_WORD
    JSR PRINT_BYTE
    BRA OR_V1_EA
OR_V1_WORD
    CMP #1,D1
    BNE OR_V1_LONG
    JSR PRINT_WORD
    BRA OR_V1_EA
OR_V1_LONG
    JSR PRINT_LONG
    BRA OR_V1_EA
OR_V1_EA
    JSR PRINT_SPACE
    MOVE.W D2,D1
    JSR DECODE_AS_SOURCE
    JSR PRINT_COMMA
    JSR PRINT_REG
    MOVE.W D2,D1
    LSL #4,D1
    LSR #5,D1
    LSR #8,D1
    JSR PRINT_D1
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS     
PRINTING_OR_D_TO_EA:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_OR
    MOVE.W D2,D1
    LSL #7,D1
    LSR #7,D1
    LSR #6,D1
    CMP #4,D1
    BNE OR_V2_WORD
    JSR PRINT_BYTE
    BRA OR_V2_EA
OR_V2_WORD
    CMP #5,D1
    BNE SUB_V1_LONG
    JSR PRINT_WORD
    BRA OR_V2_EA
OR_V2_LONG
    JSR PRINT_LONG
    BRA OR_V2_EA
OR_V2_EA
    JSR PRINT_SPACE
    
    JSR PRINT_REG
    MOVE.W D2,D1
    LSL #4,D1
    LSR #5,D1
    LSR #8,D1
    JSR PRINT_D1
    JSR PRINT_COMMA
    MOVE.W D2,D1
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS   
    
PRINTING_SUBQ:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_SUBQ
    MOVE.L D2,D1
    LSL #8,D1
    LSR #8,D1
    LSR #6,D1
    CMP.L #0,D1
    BNE SUBQ_WORD_SEG
    JSR PRINT_BYTE
    BRA SUBQ_DATA_SEG
SUBQ_WORD_SEG
    CMP.L #1,D1
    BNE SUBQ_LONG_SEG
    JSR PRINT_BYTE
    BRA SUBQ_DATA_SEG
SUBQ_LONG_SEG
    JSR PRINT_BYTE
    BRA SUBQ_DATA_SEG
SUBQ_DATA_SEG
    JSR PRINT_SPACE
    JSR PRINT_VALUE
    MOVE.L D2,D1
    LSL #4,D1
    LSR #5,D1
    LSR #8,D1
    JSR PRINT_D1
    JSR PRINT_COMMA
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS  
PRINTING_JSR:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_JSR
    JSR PRINT_SPACE  
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS 
PRINTING_MOVEM_REG_TO_MEM:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_MOVEM
    MOVE.W D2,D1
    AND.W #$0040,D1
    CMP #0,D1
    BNE P_M_R_M_L
    JSR PRINT_WORD
    BRA MOVEM_M_R_EA
P_M_R_M_L
    JSR PRINT_LONG
    BRA MOVEM_M_R_EA
MOVEM_R_M_EA
    JSR PRINT_SPACE  
    JSR DECODE_AS_SOURCE
    JSR PRINT_COMMA
    JSR PRINT_LIST
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS 

PRINTING_MOVEM_MEM_TO_REG:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_MOVEM
    MOVE.W D2,D1
    AND.W #$0040,D1
    CMP #0,D1
    BNE P_M_R_M_L
    JSR PRINT_WORD
    BRA MOVEM_M_R_EA
P_M_M_R_L
    JSR PRINT_LONG
    BRA MOVEM_M_R_EA
MOVEM_M_R_EA
    JSR PRINT_SPACE  
    JSR PRINT_LIST
    JSR PRINT_COMMA
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS 
PRINTING_NEG:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_NEG
    LSL #8,D1
    LSR #8,D1
    LSR #6,D1
    CMP #0,D1
    BNE NEG_WORD_PRINT
    JSR PRINT_BYTE
    BRA NEG_EA_PRINT
NEG_WORD_PRINT
    CMP #1,D1
    JSR PRINT_WORD
    BNE NEG_LONG_PRINT
    BRA NEG_EA_PRINT
NEG_LONG_PRINT
    JSR PRINT_LONG
    BRA NEG_EA_PRINT
NEG_EA_PRINT
    JSR PRINT_SPACE
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS

PRINTING_LEA:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_LEA
    JSR PRINT_SPACE
    JSR DECODE_VALUE_IMMEDIATE
    JSR PRINT_COMMA
    JSR PRINT_ADD_REG
    MOVE.W D2,D1
    AND.W #$0E00,D1
    LSR #8,D1
    LSR #1,D1
    JSR PRINT_D1
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS

PRINTING_CMPI
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_CMPI
    MOVE.W D2,D1
    LSL #8,D1
    LSR #8,D1
    LSR #6,D1
    
    CMP #0,D1
    BNE PRINTING_CMPI_WORD
    JSR PRINT_BYTE
    BRA CMPI_EA_SEG
PRINTING_CMPI_WORD
    CMP #1,D1
    BNE PRINTING_CMPI_LONG
    JSR PRINT_WORD
    BRA CMPI_EA_SEG

PRINTING_CMPI_LONG
    JSR PRINT_LONG
    BRA CMPI_EA_SEG
CMPI_EA_SEG
    JSR PRINT_SPACE
    JSR PRINT_VALUE
    JSR PRINT_COMMA
    JSR DECODE_AS_SOURCE
    
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
    
PRINTING_BCLR:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_BCLR
    JSR PRINT_SPACE
    JSR PRINT_REG
    MOVE.W D2,D1
    LSR #8,D1
    LSR #2,D1
    JSR PRINT_D1
    JSR PRINT_COMMA
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS

PRINTING_MOVEA:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_MOVEA
    MOVE.W D2,D1
    LSR #8,D1
    LSR #4,D1
    CMP #2,D1
    BEQ MOVEA_PRINT_LONG
    JSR PRINT_WORD
    JSR PRINT_SPACE
    BRA MOVEA_DONE_PRINTING
MOVEA_PRINT_LONG
    JSR PRINT_LONG
    JSR PRINT_SPACE
    BRA MOVEA_DONE_PRINTING
MOVEA_DONE_PRINTING
    MOVE.W D2,D1
    JSR DECODE_AS_SOURCE
    JSR PRINT_COMMA
    JSR PRINT_ADD_REG
    MOVE.W D2,D1
    LSL #4,D1
    LSR #8,D1
    LSR #5,D1
    JSR PRINT_D1
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
    
PRINTING_ORI:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    JSR PRINT_ORI
    MOVE.W D2,D1
    LSR #6,D1
    CMP #0,D1
    BNE ORI_LONG_PRINT
    JSR PRINT_BYTE
    BRA ORI_DATA_SEG
ORI_WORD_PRINT
    CMP #1,D1
    BNE ORI_LONG_PRINT
    JSR PRINT_WORD
    BRA ORI_DATA_SEG
ORI_LONG_PRINT
    JSR PRINT_LONG
    BRA ORI_DATA_SEG
ORI_DATA_SEG
    JSR PRINT_SPACE
    JSR DECODE_AS_DESTINATION
    JSR PRINT_COMMA
    MOVE.W D2,D1
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
PRINTING_MOVE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    MOVE.W D2,D1
    LSR #8,D1
    LSR #4,D1
    JSR PRINT_MOVE
    CMP #1,D1
    BNE MOVE_WORD_PRINT
    JSR PRINT_BYTE
    BRA MOVE_EA_PRINT
MOVE_WORD_PRINT
    CMP #3,D1
    BNE MOVE_LONG_PRINT
    JSR PRINT_WORD
    BRA MOVE_EA_PRINT
MOVE_LONG_PRINT
    JSR PRINT_LONG
    BRA MOVE_EA_PRINT
MOVE_EA_PRINT
    MOVE.W D2,D1
    JSR PRINT_SPACE
    JSR DECODE_AS_SOURCE
    JSR PRINT_COMMA
    MOVE.W D2,D1
    JSR DECODE_AS_DESTINATION
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS

PRINTING_ADD_DEST
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    MOVE.W D2,D1
    JSR PRINT_ADD
    AND.W #0100,D1
    LSR #6,D1
    CMP #4,D1
    BNE ADD_DEST_WORD
    JSR PRINT_BYTE
    BRA ADD_DEST_EA
ADD_DEST_WORD
    CMP #5,D1
    BNE ADD_DEST_LONG
    JSR PRINT_WORD
    BRA ADD_DEST_EA
ADD_DEST_LONG
    JSR PRINT_LONG
    BRA ADD_DEST_EA
ADD_DEST_EA
    MOVE.W D2,D1
    JSR PRINT_SPACE
    JSR PRINT_REG
    AND.W #$0E00,D1
    LSR #8,D1
    LSR #1,D1
    JSR PRINT_D1
    JSR PRINT_COMMA
    MOVE.W D2,D1
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
PRINTING_ADD_SOURCE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    MOVE.W D2,D1
    JSR PRINT_ADD
    AND.W #0100,D1
    LSR #6,D1
    CMP #0,D1
    BNE ADD_SOURCE_WORD
    JSR PRINT_BYTE
    BRA ADD_SOURCE_EA
ADD_SOURCE_WORD
    CMP #1,D1
    BNE ADD_SOURCE_LONG
    JSR PRINT_WORD
    BRA ADD_SOURCE_EA
ADD_SOURCE_LONG
    JSR PRINT_LONG
    BRA ADD_SOURCE_EA
ADD_SOURCE_EA
    JSR PRINT_SPACE
    MOVE.W D2,D1
    JSR DECODE_AS_SOURCE
    MOVE.W D2,D1
    JSR PRINT_COMMA
    JSR PRINT_REG
    AND.W #$0E00,D1
    LSR #8,D1
    LSR #1,D1
    JSR PRINT_D1
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
PRINTING_ADDA
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    MOVE.W D2,D1
    JSR PRINT_ADDA
    JSR PRINT_SPACE
    JSR DECODE_AS_SOURCE
    JSR PRINT_COMMA
    AND.W #$0E00,D1
    LSR #8,D1
    LSR #1,D1
    JSR PRINT_REG
    JSR PRINT_D1
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
