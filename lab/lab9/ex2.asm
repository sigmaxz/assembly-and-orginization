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
	OUT 
	LD R6, STACK_POP
	JSRR R6
	OUT
	LD R6, STACK_POP
	JSRR R6
	OUT

	

	
	HALT
;data
STACK_PUSH .fill x3200
STACK_POP .fill x3400
PTR .fill x4000
CAPACITY .fill #2

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
	ST R7, BUR7
	ST R1, BUR1
;logic
	ADD R4, R3, #-1
	BRn EROV	; checks if adding goes over capacity 
	ADD R3, R3, #-1 ; decrements before storing
	STR R0, R2, #0 ; storing 
	ADD R2, R2, #1 ; incrementing to next slot

ENDSP
	LD R7, BUR7
	LD R1, BUR1
	RET

EROV
	LEA R0, ERROV
	PUTS
	BR ENDSP


;data
BUR7 .blkw #1
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
	RET
ERUN
	LEA R0, ERRUN
	PUTS
	BR ENDPO

;data
BU734 .blkw #1
ERRUN .STRINGZ "UNDERFLOW EVENT "

.orig x4000
	.blkw #5

.end


