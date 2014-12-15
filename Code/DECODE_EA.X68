*-----------------------------------------------------------
* Title      : Decode EA
* Written by : Brad Minogue
* Date       : 12/12/14
* Description: Decodes EA, assumes correct OP code is passed
*into D2
*-----------------------------------------------------------
DECODE_AS_SOURCE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
*mask anything except the source data in the OP code
    AND.W #$003F,D2
*branch to general decoding function
    JSR DECODE_EA
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
DECODE_AS_DESTINATION:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
*Here we are going to mask and then flip the destination
*EA to mimic that of a source
    AND.W #$01C0,D1
    LSR.W #3,D1
    MOVE.W D1,D3
    MOVE.W D2,D1
    AND.W #$0E00,D1
    LSR.W #8,D1
    LSR.W #1,D1
*adding the imput in this puts the mode then the register
    ADD.W D1,D3
    MOVE.W D1,D2
    JSR DECODE_EA    
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
DECODE_EA:
*here we will loop threw testing functions similar
*to how we test for OP code
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    LEA EA_MODE_ARRAY,A3
*as this moment the last function to test which decodes Immediate mode
*is broken, so don't do that till it is fixed (to change change number to 9
    MOVE.B #8, D4
    CLR D3
    CLR D7
EA_DECODING_LOOP
*increment and then test to see if we reached the end of the array
    ADD #1,D3
    CMP D4,D3
    BEQ EA_DONE
*move in the current function and then move on to the next for the next loop
    MOVEA.L (A3)+,A2
    JSR (A2)
*D7 will be set if we decoded EA
    CMP #0,D7
    BNE EA_DONE
    BRA EA_DECODING_LOOP
EA_DONE    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
*These functions take D2 as input
*and give D7 to say if they decoded
EA_DATA_REG_MODE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on 
    MOVE.W D2,D1
*test to see what EA mode we are and if we are this one  
    LSR.W #3,D1
    CMP EA_DATA_REG_VALUE,D1  
    BNE DONE_EA_DATA
    MOVE.W D2,D1
*set our success bit then print out the register
    MOVE.B #1,D7
    JSR PRINT_REG
    JSR PRINT_D1
DONE_EA_DATA    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS  

EA_ADD_REG_MODE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
*test to see what EA mode we are and if we are this one 
    LSR.W #3,D1
    CMP EA_ADD_REG_VALUE,D1
    BNE DONE_ADD_REG_MODE
*set our success bit then print out the register
    MOVE.B #1,D7
    MOVE.W D2,D1
    
    JSR PRINT_ADD_REG
    JSR PRINT_D1
DONE_ADD_REG_MODE 
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS  
EA_DER_ADD_MODE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    LSR.W #3,D1
*test to see what EA mode we are and if we are this one     
    CMP EA_DER_ADD_VALUE,D1
    BNE DONE_DER_ADD_MODE
    MOVE.W D2,D1
*set our success bit then print out thre reg
    AND.W #$0007,D1
    MOVE.B #1,D7
    JSR PRINT_DER_ADD
DONE_DER_ADD_MODE    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS  
EA_DER_ADD_INC_MODE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
*test to see what EA mode we are and if we are this one 
    LSR.W #3,D1
    CMP EA_DER_ADD_INC_VALUE,D1
    BNE DONE_INC_DER_ADD_MODE
    MOVE.W D2,D1
*set our success bit then print out thre reg
    AND.W #$0007,D1
    MOVE.B #1,D7
    JSR PRINT_INC_DER_ADD
DONE_INC_DER_ADD_MODE    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
EA_DER_ADD_DEC_MODE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    LSR.W #3,D1
*test to see what EA mode we are and if we are this one 
    CMP EA_DER_ADD_DEC_VALUE,D1
    BNE DONE_EA_DER_ADD_DEC_MODE
    MOVE.W D2,D1
*set our success bit then print out thre reg
    AND.W #$0007,D1
    MOVE.B #1,D7
    JSR PRINT_DEC_DER_ADD
DONE_EA_DER_ADD_DEC_MODE    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS  
EA_16_ADD_MODE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    LSR.W #3,D1
*test to see what EA mode we are and if we are this one 
    CMP EA_16_ADD_VALUE,D1 
    BNE DONE_EA_16_ADD_MODE
    MOVE.B #1,D7 
*set our success bit then let everyone know this mode is not
*currently supported by this deocmpiler
    JSR PRINT_UNSUPPORTED_EA
DONE_EA_16_ADD_MODE    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
EA_8_ADD_MODE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)                   ;back up any data we might step on   
    MOVE.W D2,D1
    LSR.W #3,D1
    CMP EA_8_ADD_VALUE,D1 
    BNE DONE_EA_8_ADD_MODE 
    MOVE.B #1,D7
*set our success bit then let everyone know this mode is not
*currently supported by this deocmpiler
    JSR PRINT_UNSUPPORTED_EA
DONE_EA_8_ADD_MODE    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
*note this function is broken heavily. 
EA_IMMEDIATE_MODE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    MOVE.W D2,D1
*test to see what EA mode we are and if we are this one
    LSR.W #3,D1
    CMP EA_IMMEDIATE_VALUE,D1 
    BNE DONE_IMMEDIATE_EA  
    AND.W #0007,D1
*now we must deside what type of immediate mode we are
    CMP EA_16_PC_VALUE,D1
    BEQ EA_16_PC_MODE 
    CMP EA_8_PC_VALUE,D1
    BEQ EA_8_PC_MODE 
    CMP EA_WORD_VALUE,D1
    BEQ EA_WORD_MODE 
    CMP EA_LONG_VALUE,D1
    BEQ EA_LONG_MODE 
    BRA DONE_IMMEDIATE_EA        
DONE_IMMEDIATE_EA MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
*in the following statements we move the data from the address
*input into d1 and point it to the next information accordingly
*then we print out whatever was shoved into d1
EA_WORD_MODE:
    MOVE.W (A5)+,D1
    JSR PRINT_D1
     MOVE.B #1,D7
    BRA DONE_IMMEDIATE_EA
EA_LONG_MODE: 
    MOVE.L (A5)+,D1
    JSR PRINT_D1
     MOVE.B #1,D7
    BRA DONE_IMMEDIATE_EA
EA_IM_MODE:
    MOVE.B #1,D7
    JSR DECODE_VALUE_IMMEDIATE
    BRA DONE_IMMEDIATE_EA
EA_16_PC_MODE: 
 MOVE.B #1,D7
    MOVE.W (A5)+,D1
    JSR PRINT_D1
    BRA DONE_IMMEDIATE_EA
EA_8_PC_MODE: 
 MOVE.B #1,D7
    MOVE.W (A5)+,D1
    JSR PRINT_D1

    BRA DONE_IMMEDIATE_EA
*print out data in an OP mode
*such as an address $XXXX
DECODE_VALUE_IMMEDIATE:
    MOVEM.L D0-D6/A0-A4/A6,-(SP)
    MOVE.W (A5)+,D1 
    *ADD.W #32,D1
    MOVE #16,D2
    MOVE #15,D0
    TRAP #15
     MOVE.B #1,D7
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS
DONE_VALUE_IMMEDIATE_EA 
    MOVEM.L (SP)+,D0-D6/A0-A4/A6
    RTS

*------------------------------------------------------------
*EA VALUES
*------------------------------------------------------------   
EA_DATA_REG_VALUE DC.W      $0
EA_ADD_REG_VALUE DC.W       $1
EA_DER_ADD_VALUE DC.W       $2
EA_DER_ADD_INC_VALUE DC.W   $3
EA_DER_ADD_DEC_VALUE DC.W   $4
EA_16_ADD_VALUE DC.W        $5
EA_8_ADD_VALUE DC.W         $6
EA_IMMEDIATE_VALUE DC.W     $7
*sub type of EA immediate value
EA_WORD_VALUE DC.W          $0
EA_LONG_VALUE DC.W          $1
EA_IM_DATA_VALUE DC.W       $4
EA_16_PC_VALUE DC.W         $2
EA_8_PC_VALUE DC.W          $3

*8
EA_MODE_ARRAY DC.L EA_DATA_REG_MODE, EA_ADD_REG_MODE, EA_DER_ADD_MODE
    DC.L EA_DER_ADD_INC_MODE, EA_DER_ADD_DEC_MODE,EA_16_ADD_MODE
    DC.L EA_8_ADD_MODE,EA_IM_MODE
    
*5  
EA_REG_TYPE_ARRAY DC.L EA_WORD_VALUE, EA_LONG_VALUE, EA_IM_DATA_VALUE
    DC.L  EA_16_PC_VALUE, EA_8_PC_VALUE
    


















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
