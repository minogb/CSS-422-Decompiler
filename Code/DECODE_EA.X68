*-----------------------------------------------------------
* Title      : Decode EA
* Written by : Brad Minogue
* Date       : 12/12/14
* Description: Decodes EA, assumes correct OP code is passed
*into D2
*-----------------------------------------------------------
DECODE_AS_SOURCE:
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
    AND.L #$003F,D2
    JSR DECODE_EA
    MOVEM.L (SP)+,D0-D7/A0-A6
    RTS
DECODE_AS_DESTINATION:
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
    AND.L #$0FC0,D2
    LSR.W #6,D2
    JSR DECODE_EA    
    MOVEM.L (SP)+,D0-D7/A0-A6
    RTS
DECODE_EA:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
*These functions take D2 as input
*and give D7 to say if they decoded
EA_DATA_REG_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS  
EA_REG_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_ADD_REG_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_DER_ADD_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_DER_ADD_INC_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_DER_ADD_DEC_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS    
EA_16_ADD_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_8_ADD_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_IM_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_WORD_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_LONG_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_IM_DATA_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_16_PC_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS
EA_8_PC_MODE:
    MOVEM.L D0-D6/A0-A6,-(SP)                   ;back up any data we might step on   
    
    MOVEM.L (SP)+,D0-D6/A0-A6
    RTS   
    
*------------------------------------------------------------
*EA VALUES
*------------------------------------------------------------   
EA_DATA_REG_VALUE DC.B      %000
EA_ADD_REG_VALUE DC.B       %001
EA_DER_ADD_VALUE DC.B       %010
EA_DER_ADD_INC_VALUE DC.B   %011
EA_DER_ADD_DEC_VALUE DC.B   %100
EA_16_ADD_VALUE DC.B        %101
EA_8_ADD_VALUE DC.B         %110
EA_IMMEDIATE_VALUE DC.B     %111

EA_WORD_VALUE DC.B          %000
EA_LONG_VALUE DC.B          %001
EA_IM_DATA_VALUE DC.B       %100
EA_16_PC_VALUE DC.B         %010
EA_8_PC_VALUE DC.B          %011

*8
EA_VALUE_ARRAY DC.L EA_DATA_REG_VALUE, EA_ADD_REG_VALUE, EA_DER_ADD_VALUE
    DC.L EA_DER_ADD_INC_VALUE, EA_DER_ADD_DEC_VALUE,EA_16_ADD_VALUE
    DC.L EA_8_ADD_VALUE, EA_IMMEDIATE_VALUE

EA_MODE_ARRAY DC.L EA_DATA_REG_MODE, EA_ADD_REG_MODE, EA_DER_ADD_MODE
    DC.L EA_DER_ADD_INC_MODE, EA_DER_ADD_DEC_MODE,EA_16_ADD_MODE
    DC.L EA_8_ADD_MODE, EA_IM_MODE
    
*5  
EA_REG_TYPE_ARRAY DC.L EA_WORD_VALUE, EA_LONG_VALUE, EA_IM_DATA_VALUE
    DC.L  EA_16_PC_VALUE, EA_8_PC_VALUE
    
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
