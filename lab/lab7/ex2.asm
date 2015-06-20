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

	LD R6, PAL
	JSRR R6
	
	LD R0, LINE2
	OUT
	
	ADD R4, R4, #0
	BRz NOTP
	BR IP

NOTP
	LEA R0, NPP
	PUTS
	BR ENDM

IP
	LEA R0, IPP
	PUTS

ENDM
	HALT
;data
SUB_GET .fill x3200
PAL .fill x3400
PTR .fill x4000
PROMPT .STRINGZ "Hi, please enter your string and end with <enter>"
NPP .STRINGZ "it is not a palindrome"
IPP .STRINGZ "it is a palindrome"
LINE2 .fill xA

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
	BRz COUNTER
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

.orig x3400
;-------------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R0): The address of a string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R0) is
;a palindrome or not returned a flag indicating such.
;Return Value: R4  {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------------
;store 
	ST R7, R7PAL
	ST R0, R0PAL
	ST R5, R5PAL
;logic
	ADD R5, R5, #-1
	LD R3, ZZ

CLOOP
	ADD R1, R0, R3
	LDR R1, R1, #0
	ADD R2, R0, R5
	LDR R2 , R2, #0
	NOT R4, R5
	ADD R4, R4, #1
	ADD R4, R4, R3
	BRz ISPAL
	NOT R4, R1
	ADD R4, R4, #1
	ADD R4, R4, R2
	BRnp NOTPAL
	BR ITER

ISPAL
	LD R4, ZZ
	ADD R4, R4, #1
	BR ENDPAL

NOTPAL
	LD R4, ZZ

ENDPAL
	LD R7, R7PAL
	LD R0, R0PAL
	LD R5, R5PAL
	RET

ITER
	ADD R3, R3, #1
	ADD R5, R5, #-1	
	BR CLOOP

;data
R7PAL .blkw #1
R0PAL .blkw #1
R5PAL .blkw #1
ZZ .fill #0

;-------------------------
;array data
.orig x4000
	.blkw #30
.end
