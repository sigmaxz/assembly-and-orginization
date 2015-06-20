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
	LD R1, NUM
	LD R2, SENT
	ADD R1, R1, #0
	BRn NEG
	BR POS

TOP
	ADD R2, R2, #-1
	BRz END
	ADD R1, R1, R1
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
	HALT

;
;data
NUM .fill #1024 ; hard coded value
SENT .fill #16 ; counter for loop
ZERO .fill #48 ; 0 symbol
ONE .fill #49 ; 1 symbol
