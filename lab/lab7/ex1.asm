;
; Villarreal, Samuel
; 861-02-1551
; Login: svill017
; Section: 023
; TA: Aditaya Tammewar 
; Email: svill017@ucr.edu
; Lab 07

.orig x3000
	LEA R0, PROMPT
	PUTS
	LD R0, PTR
	LD R6, SUB_GET
	JSRR R6
		
	PUTS

	HALT
;data
SUB_GET .fill x3200
PTR .fill x4000
PROMPT .STRINGZ "Hi, please enter your string and end with <enter>"
LINE .fill xA

.orig x3200
;-------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R0): The address of where to start storing the string
; Postcondition: The subroutine has allowed the user to input a string,
;terminated by the [ENTER] key, and has stored it in an array
;that starts at (R0) and is NULL-terminated.
; Return Value: R5  The number of non-sentinel characters read from the user
;------------------------------------------------------------------------------

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
;data
R7SUBGET .blkw #1
SUBP .fill x4000
R0SUBGET .blkw #1
Z .fill #0
SPACEN .fill #-32
LINEN .fill -xA
LINE .fill xA

;-------------------------
;array data
.orig x4000
	.blkw #20
.end
