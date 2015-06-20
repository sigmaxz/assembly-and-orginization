;----------------------------------------------------------
; Name: Samuel Villarreal
; Login: svill017
; Email: svill017@ucr.edu
; Assignment: assn4
; Secion: 023
; TA: Aditaya Tammewar 
;
; I hereby certify that this homework submission is entirely my own work
;--------------------------------
.orig x3000

RESET ; if invalid input sent back
	LEA R0, INTRO
	PUTS
	LD R0, LINE
	OUT
	LD R3, SENT
	LD R1, ZERO ; sets up 0 in R1
	LD R5, ZERO ; sets up 0 in R5
	GETC
	OUT
	LD R4, SYMN
	ADD R2, R0, R4; checks -
	BRz NEG
	LD R4, SYMP
	ADD R2, R0, R4;checks +
	BRz MAIN
	LEA R6, EPROMPT
	JMP R6

NEG ; set sentinal for negative
	ADD R5, R1, #-1
	
MAIN ; the processing of the numbers;
	GETC
	OUT
	LD R4, SYM9
	ADD R2, R0, R4 ;checks for symbole after 9
	BRp EPROMPT
	LD R4, SYMZ
	ADD R2, R0, R4 ;checks for symbol before 0
	BRn EPROMPT
	LEA R6, MULTI
	JMP R6

RETURN ;gets back from MULTI10
	LD R4, SYMZ
	ADD R2, R0, R4
	ADD R1, R1, R2
	ADD R3, R3, #-1; check sentinal 
	BRp MAIN 
	ADD R5, R5, #0 ; check for negative sign sentinal
	BRn CONVERT
END
	HALT

CONVERT
	NOT R1, R1
	ADD R1, R1, #1
	BR END
	
EPROMPT; gives the error message and starts over
	LD R0, LINE
	OUT
	LEA R0, ERR
	PUTS
	LD R0, LINE
	OUT
	LEA R6, RESET
	JMP R6

MULTI; multiples number by 10
	LD R4, MSENT
	ADD R2, R1, #0
AGAIN ; for loop to iterate
	ADD R1, R1, R2
	ADD R4, R4, #-1
	BRz RETURN
	BR AGAIN
	

;data
INTRO .STRINGZ "Welcome, please give a 5 digit decimal number preceded by (+/-), followed by enter:"
ERR .STRINGZ " input error resetting ";
SENT .fill #5
MSENT .fill #9
LINE .fill xA
; symboles value subtraction ready values
ZERO .fill #0
SYMN .fill #-45 ; negative conversion
SYMP .fill #-43 ; positive coversion
SYMZ .fill #-48 ; zero sym conversion
SYM9 .fill #-57 ; 9 sym conversion

.end
