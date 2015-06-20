;
; Villarreal, Samuel
; 861-02-1551
; Login: svill017
; Section: 023
; TA: Aditaya Tammewar 
; Email: svill017@ucr.edu
; Lab 09

.orig x3000

	LD R1, PTR
	LD R2, PTR
	LD R3, CAPACITY
	LD R6, POLCAL
	JSRR R6

	
	HALT
;data
POLCAL .fill x3600
PTR .fill x4400
CAPACITY .fill #3

.orig x3200
;------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R1): stack_addr: A pointer to the beginning of the stack
; Parameter (R2): top: A pointer to the next place to PUSH an item
; Parameter (R3): capacity: The number of additional items the stack can hol
; Postcondition: The subroutine has pushed (R0) onto the stack. If an overflo
;                occurred, the subroutine has printed an overflow error mess
;                          and terminated.
; Return Value: R2  updated top value
;                         R3  updated capacity value
;------------------------------------------------------------------------------
;store
	ST R7, BUR7SP
	ST R1, BUR1
;logic
	ADD R4, R3, #-1
	BRn EROV	; checks if adding goes over capacity 
	ADD R3, R3, #-1 ; decrements before storing
	STR R0, R2, #0 ; storing 
	ADD R2, R2, #1 ; incrementing to next slot

ENDSP
	LD R7, BUR7SP
	LD R1, BUR1
	RET

EROV
	LEA R0, ERROV
	PUTS
	BR ENDSP


;data
BUR7SP .blkw #1
BUR1 .blkw #1
ERROV .STRINGZ "OVERFLOW EVENT "

.orig x3400
;-------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R1): stack_addr: A pointer to the beginning of the stack
; Parameter (R2): top: A pointer to the item to POP
; Parameter (R3): capacity: The # of additional items the stack can hold
; Postcondition: The subroutine has popped MEM[top] off of the stack.
; If an underflow occurred, the subroutine has printed an
; underflow error message and terminated.
; Return Value: R0  value popped off of the stack
; R2  updated top value
; R3  updated capacity value
;-------------------------------------------------------------------------------
;store
	ST R7, BU734
	ST R4, BU434
;logic
	NOT R4, R1
	ADD R4, R4, #1
	ADD R4, R2, R4
	BRz ERUN
	ADD R3, R3, #1 ; increment capacity
	ADD R2, R2, #-1 ; decrement pointer to pop'd item
	LDR R0, R2, #0 ; popped off value

ENDPO
	LD R7, BU734
	LD R4, BU434
	RET
ERUN
	LEA R0, ERRUN
	PUTS
	BR ENDPO

;data
BU734 .blkw #1
BU434 .blkw #1
ERRUN .STRINGZ "UNDERFLOW EVENT "

.orig x3600
;-------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R1): stack_addr
; Parameter (R2): top
; Parameter (R3): capacity
; Postcondition: The subroutine has popped off the top two values of the st
;                          multiplied them together, and pushed the resulting value b
;                          onto the stack.
; Return Value: R2  updated top value
;                         R3  updated capacity value
;------------------------------------------------------------------------------
;store 
	ST R7, LBUR7
;logic
	IN
	LD R6, STACK_PUSH
	JSRR R6

	IN 
	LD R6, STACK_PUSH
	JSRR R6

	IN 
	LD R6, STACK_PUSH
	JSRR R6
	
	LD R6, STACK_POP
	JSRR R6

	LD R6, STACK_POP
	JSRR R6
	LD R5, CHANGE
	ADD R4, R0, R5
	LD R6, STACK_POP
	JSRR R6
	LD R5, CHANGE
	ADD R5, R0, R5
;multi part
	ST R1, TEMP1
	ADD R2, R4, #0
	ADD R1, R5, #0
	LD R6, MULT
	JSRR R6
	ADD R1, R0, #0
	LD R6, PRIN
	JSRR R6
	
ENDRM
	LD R7, LBUR7
	RET
;data
LBUR7 .blkw #1
TEMP1 .blkw #1
MULT .fill x3800
STACK_PUSH .fill x3200
STACK_POP .fill x3400
PRIN .fill x4000
CHANGE .fill #-48

.orig x3800
;MULT subroutine
;inputs: R1, R2 to be multiplied 
;post: puts the final value in r0
	ST R7, R73800
;logic
	LD R5, Z3
	LD R6, Z3
	ADD R1, R1, #0
	BRn NEGM1
	BR CM1

NEGM1
	ADD R5, R5, #-1
	NOT R1, R1
	ADD R1, R1, #1

CM1
	ADD R2, R2, #0
	BRn NEGM2
	BRz ZFAIL
	BR MMULT

NEGM2
	ADD R6, R6, #-1
	NOT R2, R2
	ADD R2, R2, #1

MMULT
	ADD R3, R2, #0
	LD R0, Z3
LOOPM
	ADD R0, R0, R1
	ADD R4, R0, #0
	BRn EMULT
	ADD R3, R3, #-1
	BRz ENDMULT
	BR LOOPM



ENDMULT
	ADD R6, R5, R6
	ADD R6, R6, #1
	BRz CN
RENDM
	LD R7, R73800
	RET
ZFAIL
	LD R0, Z3
	BR RENDM
EMULT
	ADD R7, R5, R6
	ADD R7, R7, #1
	BRz EMULT2
	LEA R0, ERM
	PUTS
	HALT

EMULT2
	LEA R0, ERM2
	PUTS
	HALT

CN
	NOT R0, R0
	ADD R0, R0, #1
	BR RENDM
	

;dataMULT
R73800 .blkw #1
ERM .STRINGZ "OVER FLOW" 
ERM2 .STRINGZ "UNDER FLOW"
Z3 .fill #0

.orig x4000
;subroutine :print
;Input: R1 contains value wished to be printed as decimal 
;Postcondition: printed out decimal to console
;STORE:
	ST R7, R7_BACKUP
	ST R1, R1_BACKUP
;LOGIC
	ADD R1, R1 , #0
	BRzp POSPP
NEGP 
	LD R0, SYMNN
	OUT
	NOT R1, R1
	ADD R1, R1, #1

POSPP
	LD R3, VAL1
	LD R6, PTRC
	JSRR R6
	
	LD R3, VAL2
	JSRR R6

	LD R3, VAL3
	JSRR R6

	LD R3, VAL4
	JSRR R6

	LD R3, VAL5
	JSRR R6

	LD R1, R1_BACKUP
	

	HALT

;data
SENTP .fill #5
PTRC .FILL x4200
SYMNN .fill x2D
VAL1 .FILL #-10000
VAL2 .FILL #-1000
VAL3 .FILL #-100
VAL4 .FILL #-10
VAL5 .FILL #-1
R7_BACKUP .blkw #1
R1_BACKUP .blkw #1

.ORIG x4200
;SUB COUNTER
;INPUT TAKES IN R2 VALUE AND R3 COMPARISION VALUE
;POST: DOES THE ACTUALY ARITHMATIC 

	ST R7, R7_BACKUP_36

ZEROP ;RESETS R0
	LD R0, Z36
LOOPP ; LOOP TO DETERMINE DEGREE OF DECIMAL 
	ADD R1 , R1 , R3
	BRzp POSP
	BRn NEXTP

POSP
	ADD R0, R0, #1
	BR LOOPP

NEXTP
	NOT R3, R3
	ADD R3, R3, #1
	ADD R1, R1, R3 ; UNDO NEG
	LD R5, CONVDEC
	ADD R0, R0, R5 ; ASCII VAL
	OUT

	LD R7, R7_BACKUP_36
	RET

;DATA 
R7_BACKUP_36 .BLKW #1
Z36 .FILL #0
CONVDEC .fill #48

.orig x4400
	.blkw #5

.end



