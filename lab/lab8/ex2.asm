;
; Villarreal, Samuel
; 861-02-1551
; Login: svill017
; Section: 023
; TA: Aditaya Tammewar 
; Email: svill017@ucr.edu
; Lab 08
.orig x3000
	LD R6, PRINT_OPCODES
	JSRR R6

	HALT
;data
PRINT_OPCODES .fill x3200

.orig x3200
;-------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODES
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;                         and corresponding opcode in the following format:
;                         ADD = 0001
;                         AND = 0101
;                         BR = 0000
;                         … Return Value: None
;------------------------------------------------------------------------------

;store
	ST R7, R7BU

;logic
	LD R1, CODES
	LD R2, NAME

PRINTN
	LDR R0, R2, #0
	ADD R3, R0, #1
	BRz end
	ADD R3, R0, #0
	BRz PRINTC
	OUT
	ADD R2, R2, x1
	BR PRINTN
	

PRINTC
	LD R0, SP
	OUT
	LD R0, EQ
	OUT
	LD R0, SP
	OUT
;jsrr
	LD R6, PR
	JSRR R6
	ADD R1, R1, x1
	LD R0, LINE
	OUT
	ADD R2, R2, x1
	BR PRINTN
	
end
	LD R7, R7BU
	RET

;data
TEMP .blkw #1
R7BU .blkw #1
PR .fill x3300
CODES .fill x3400
NAME .fill x3500
LINE .fill xA
EQ .fill #61
SP .fill #32
CON .fill #48
;
.orig x3300
;print binary number
;params: r1 contains the number ptr to the arr1
;post value printed
;store
	ST R7, BU
;logic 
	LDR R6, R1, #0
	LD R3, VAL
	LD R0, ZZ
	ADD R7, R3, R6
	BRn CONT
	ADD R6, R3, R6
	ADD R0, R0, #1

CONT
	OUT
	LD R0, ZZ
	LD R3, VAL1
	ADD R7, R3, R6
	BRn CONT2
	ADD R6, R3, R6
	ADD R0, R0, #1

CONT2
	OUT
	LD R0, ZZ
	LD R3, VAL2
	ADD R7, R3, R6
	BRn CONT3
	ADD R6, R3, R6
	ADD R0, R0 , #1

CONT3
	OUT 
	LD R0, ZZ
	LD R3, VAL3
	ADD R7, R3, R6
	BRn ENDP
	ADD R6, R3, R6
	ADD R0, R0, #1

ENDP
	OUT
	LD R7, BU
	RET


;data
BU .blkw #1
VAL .fill #-8
VAL1 .fill #-4
VAL2 .fill #-2
VAL3 .fill #-1	
ZZ .fill #48

;----------------------------------------------------------------------------
;ARRAY 1
.orig x3400
.fill #1
.fill #5
.fill #0
.fill #12
.fill #4
.fill #4
.fill #2
.fill #10
.fill #6
.fill #14
.fill #9 
.fill #12
.fill #8
.fill #3
.fill #11
.fill #7
.fill #15

;------------------------------------------------------------------------------
.orig x3500
.STRINGZ "ADD"
.STRINGZ "AND"
.STRINGZ "BR"
.STRINGZ "JMP"
.STRINGZ "JSR"
.STRINGZ "JSSR"
.STRINGZ "LD"
.STRINGZ "LDI"
.STRINGZ "LDR"
.STRINGZ "LEA"
.STRINGZ "NOT"
.STRINGZ "RET"
.STRINGZ "RTI"
.STRINGZ "ST"
.STRINGZ "STI"
.STRINGZ "STR"
.STRINGZ "TRAP"
.FILL #-1

.end
