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
	LEA R0 , START
	PUTS
	GETC
	OUT
	LD R6, BCHECK
	ADD R3, R0, R6
LOOP
	STR R0, R4, #0
	BACK
	ADD R4, R4, #1
	GETC
	OUT
	LD R5, DIF
	ADD R0, R0, R5 
	ADD R1, R1, #-1
	BRp LOOP
	STR R0, R4, #0

	LD R6, SUB_CONVERT_3400
	JSRR R6

	LD R0, MLINE
	OUT
	LD R6, SUB_PRINT_3200
	JSRR R6

	
ENDM
	HALT

;
;data

PTR .fill x4000
MLINE .fill xA
BCHECK .fill #-100
SENT .fill #16
DIF .fill #-48
SUB_PRINT_3200 .fill x3200
SUB_CONVERT_3400 .fill x3400
START .STRINGZ "enter 16 bit binary number 'b' followed by 1's and 0's :"

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

.orig x3400
;convert
	ST R7, R7_BACKUP_3400
	ST R3, R3_BACKUP_3400
	ST R4, R4_BACKUP_3400
	ST R5, R5_BACKUP_3400
	ST R1, R1_BACKUP_3400
;WORK
	LD R4, PTR_3400
	LD R5, CSENT
	LD R3, CNUM
	LD R2, CZERO
	ADD R4, R4, R5
	LDR R1, R4, #0
	ADD R1, R1, #0
	BRp CO
	BRz CZ
	
CLOOP
	ADD R5, R5, #-1
	BRz CEND
	ADD R4, R4, #-1
	LDR R1, R4, #0
	ADD R1, R1, #0
	BRz CZ
	BRp CO
CZ
	ADD R3, R3, R3
	BR CLOOP

CO
	ADD R2 , R2, R3
	ADD R3, R3, R3
	BR CLOOP

CEND
	LD R1, R1_BACKUP_3400
	LD R3, R3_BACKUP_3400
	LD R4, R4_BACKUP_3400
	LD R5, R5_BACKUP_3400
	LD R7, R7_BACKUP_3400
	;ADD R2, R2, #1
	RET
;data
R7_BACKUP_3400 .BLKW #1
R3_BACKUP_3400 .BLKW #1
R4_BACKUP_3400 .BLKW #1
R5_BACKUP_3400 .BLKW #1
R1_BACKUP_3400 .BLKW #1
PTR_3400 .fill x4000
CSENT .FILL #16
CNUM .fill #1
CZERO .fill #0

.orig x4000
	.BLKW #17
.end
