*-----------------------------------------------------------
* Title      : Output Variables
* Written by : Brad Minogue
* Date       : 12/12/14
* Description: A list of all the text writen to the command line
*-----------------------------------------------------------

*-----------------------------------------------------------------
SUB_TEXT DC.B 'SUB',0
SUBQ_TEXT DC.B 'SUBQ',0
*-----------------------------------------------------------------
ADD_TEXT DC.B 'ADD',0
*-----------------------------------------------------------------
ORI_TEXT DC.B 'ORI',0
OR_TEXT DC.B 'OR',0
EOR_TEXT DC.B 'EOR',0
*-----------------------------------------------------------------
CMP_TEXT DC.B 'CMP',0
CMPI_TEXT DC.B 'CMPI',0
*-----------------------------------------------------------------
MULS_TEXT DC.L 'MULS ',0
DIVS_TEXT DC.L 'DIVS ',0
*-----------------------------------------------------------------
BCC_TEXT DC.B 'B',0
CC_TEXT DC.B 'CC',0
CS_TEXT DC.B 'CS',0
EQ_TEXT DC.B 'EQ',0
GE_TEXT DC.B 'GE',0
GT_TEXT DC.B 'GT',0
HI_TEXT DC.B 'HI',0
LE_TEXT DC.B 'LE',0
LT_TEXT DC.B 'LT',0
MI_TEXT DC.B 'MI',0
NE_TEXT DC.B 'NE',0
PL_TEXT DC.B 'PL',0
VC_TEXT DC.B 'VC',0
VS_TEXT DC.B 'VS',0
RA_TEXT DC.B 'RA',0
*-----------------------------------------------------------------
JSR_TEXT DC.B 'JSR',0
RTS_TEXT DC.B 'RTS',0
*-----------------------------------------------------------------
MOVE_TEXT DC.B 'MOVE',0
MOVEM_TEXT DC.B 'MOVEM',0
MOVEA_TEXT DC.B 'MOVEA',0
LIST_TEXT DC.B '<LIST>',0
SR_TEXT DC.B 'SR',0
CCR_TEXT DC.B 'CCR',0
BCLR_TEXT DC.B 'BCLR',0
*-----------------------------------------------------------------
RO_TEXT DC.B 'RO',0
LS_TEXT DC.B 'LS',0
AS_TEXT DC.B 'AS',0
RIGHT_TEXT DC.B 'R',0
LEFT_TEXT DC.B 'L',0
*-----------------------------------------------------------------
NEG_TEXT DC.B 'NEG',0
*-----------------------------------------------------------------
LEA_TEXT DC.B 'LEA',0
*-----------------------------------------------------------------
NOP_TEXT DC.B 'NOP',0
*-----------------------------------------------------------------
LEFT_PAR_TEXT DC.B '(',0
RIGHT_PAR_TEXT DC.B ')',0
MINUS_TEXT DC.B '-',0
PLUS_TEXT DC.B '+',0
UNSUPPORTED_EA_TEXT DC.B 'Unsuported EA Mode',0
*------------------------COMMON VARIABLES-------------------------
DATA_TEXT DC.B 'DATA',0
ADD_REG_TEXT DC.B 'A',0
COMMA_TEXT DC.B ',',0
SPACE_TEXT DC.B ' ',0
VALUE_TEXT DC.B '#',0
REG_TEXT DC.B 'D',0
BYTE_TEXT DC.B '.B',0
LONG_TEXT DC.B '.L',0
WORD_TEXT DC.B '.W',0
NUM_OF_OP DC.B $18,0        ;there are 24 (dec) 0x18 number of OPs












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
