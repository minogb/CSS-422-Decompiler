*-----------------------------------------------------------
* Title      : Print OP
* Written by : Brad Minogue
* Date       : 12/12/14
* Description: Prints out formated operation, assumes it has
*varified already, new line at every function call
*takes D2 as input
*-----------------------------------------------------------
FPRINT_SHIFT_REGISTER:
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
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
DONE_PRINT_SHIFT    MOVEM.L (SP)+,D0-D7/A0-A6                   ;back up any data we might step on   
    RTS
PRINT_SHIFT_MEMORY:
    MOVEM.L D0-D7/A0-A6,-(SP)                   ;back up any data we might step on   
    ;determine which type we are
    JSR DECODE_AS_SOURCE
    MOVEM.L (SP)+,D0-D7/A0-A6                   ;back up any data we might step on   
    RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
