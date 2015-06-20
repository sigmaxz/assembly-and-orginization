;
; Villarreal, Samuel
; 861-02-1551
; Login: svill017
; Section: 023
; TA: Aditaya Tammewar 
; Email: svill017@ucr.edu
; Lab 08

.orig x3000
	LEA R0, PROMPT
	PUTS

	LD R0, PTR
	LD R6, SUB_TO_UPPER
	JSRR R6
		
	PUTS

	HALT
;data
SUB_TO_UPPER .fill x3200
PTR .fill x4000
PROMPT .STRINGZ "Hi, please enter your string and end with <enter>"
LINE .fill xA

.orig x3200
;-------------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R0): Address to store a string at
; Postcondition: The subroutine has allowed the user to input a string,
; terminated by the [ENTER] key, has converted the string
; to upper-case, and has stored it in a null-terminated array that
; starts at (R0).
; Return Value: R0 <= The address of the now upper case string.
;-------------------------------------------------------------------------------
;back up
	ST R7, R7SUBGET
	ST R0, R0SUBGET
;logic
	LD R2, R0SUBGET
	LD R5, Z
LOOPSUBG
	GETC
	OUT
	LD R4, LINEN
	ADD R3, R4, R0
	BRz ENDSUBG
	LD R4, LCASE
	ADD R3, R4, R0
	BRzp CASEC
CASEBACK
	STR R0, R2, #0
	ADD R2, R2, #1
	LD R4, SPACEN
	ADD R3, R0, R4
	BRz LOOPSUBG
	BR COUNTER
	
ENDSUBG
	LD R0, Z
	STR R0, R2, #0
	LD R0 , LINE
	OUT

	LD R7, R7SUBGET
	LD R0, R0SUBGET
	RET

COUNTER
	ADD R5, R5, #1
	BR LOOPSUBG
CASEC
	LD R4, LCASE2
	ADD R3, R0, R4
	BRp CASEBACK
	LD R4, CONV
	ADD R0, R0, R4
	BR CASEBACK
;data
R7SUBGET .blkw #1
SUBP .fill x4000
R0SUBGET .blkw #1
Z .fill #0
SPACEN .fill #-32
LINEN .fill -xA
LINE .fill xA
CONV .fill #-32
LCASE .fill #-97
LCASE2 .fill #-122


;-------------------------
;array data
.orig x4000
	.blkw #20
.end
