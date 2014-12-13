*-----------------------------------------------------------
* Title      : EA Checks
* Written by : Brad Minogue
* Date       : 12/12/14
* Description: Verifies correct EA modes
*-----------------------------------------------------------

VERIFY_SHIFT_EA:
   MOVE.W D2,D1
   AND.W #$0038,D1
   LSR.W #3,D1
   CMP.W #0,D1
   BEQ DONE_VER_EA_SHIFT
   CMP.W #1,D1
   BEQ DONE_VER_EA_SHIFT
   CMP.W #7,D1
   BEQ SHIFT_IMMEDIATE_CHECK
   MOVE.B #1,D7
DONE_VER_EA_SHIFT
    RTS
SHIFT_IMMEDIATE_CHECK
    MOVE.W D2,D1
    AND.W #$0007,D1
    CMP.W #0,D1
    BEQ GOOD_SHIFT_IM
    CMP.W #1,D1
    BEQ GOOD_SHIFT_IM
    BRA DONE_VER_EA_SHIFT
GOOD_SHIFT_IM
    MOVE.B #1,D7
    BRA DONE_VER_EA_SHIFT
 


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
