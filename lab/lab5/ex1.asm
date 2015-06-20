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
	LD R6, SUB_PRINT_3200
	JSRR R6
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
SUB_PRINT_3200 .fill x3200
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;subroutine: print
;INPUT: (R2) : this holds the value that is going to be printed in bin 16bit
;
;Post condition: the subroutine has printed the 16 bits followed by a new line
.orig x3200
;PRINT
;(1)back up
	ST R2, R2_BACKUP_3200
	ST R7, R7_BACKUP_3200

		;asn code (2)

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
;restore (3)
	LD R2, R2_BACKUP_3200
	LD R7, R7_BACKUP_3200
;(4) return
	RET
;end of asn code 

	
;data
SENT1 .fill #16 ; counter for loop
ZERO .fill #48 ; 0 symbol
ONE .fill #49 ; 1 symbol
LINE .fill xA
R2_BACKUP_3200 .BLKW #1
R7_BACKUP_3200 .BLKW #1



.orig x4000
	.BLKW #10
.end
