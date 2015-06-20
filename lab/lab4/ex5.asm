;----------------------------------------------------------
; Name: Samuel Villarreal
; Login: svill017
; Email: svill017@ucr.edu
; Assignment: assn3
; Secion: 023
; TA: Aditaya Tammewar 
;
; I hereby certify that this homework submission is entirely my own work
;--------------------------------

.orig x3000
	LD R4, PTR
	LD R1, SENT
	LD R2 , START
LOOP
	STR R2, R4, #0
	LEA R6, PRINT
	JMP R6
BACK
	LDR R2, R4, #0
	ADD R4, R4, #1
	ADD R2, R2, R2
	ADD R1, R1, #-1
	BRp LOOP

	LD R4, PTR
	ADD R4, R4, #6
	LDR R2, R4, #0
	HALT

;
;data
PTR .fill x4000
SENT .fill #10
START .fill #1

PRINT
		;asn code

	LD R3, SENT1
	ADD R2, R2, #0
	BRn NEG
	BR POS

TOP
	ADD R3, R3, #-1
	BRz END
	ADD R2, R2, R2
	BRzp POS
	BRn NEG
	

POS
	LD R0, ZERO ;putting sym 0 to print
	OUT
	BR TOP

NEG
	LD R0, ONE ; putting sym 1 to print
	OUT
	BR TOP

END
	LD R0, LINE
	OUT
	LEA R6, BACK
	JMP R6
;end of asn code 

	
;data
SENT1 .fill #16 ; counter for loop
ZERO .fill #48 ; 0 symbol
ONE .fill #49 ; 1 symbol
HI .fill x3006
LINE .fill xA



.orig x4000
	.BLKW #10
.end
