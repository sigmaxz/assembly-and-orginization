;
; Villarreal, Samuel
; 861-02-1551
; Login: svill017
; Section: 023
; TA: Aditaya Tammewar 
; Email: svill017@ucr.edu
; Lab 03
;
.orig x3000
	LD R1, DATAptr
	LD R2, SentCount

For
	IN
	STR R0, R1, 0
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRp For

	LD R1, DATAptr
	LD R2, SentCount
For2
	LDR R0, R1, 0
	OUT
	LD R0, Line
	OUT
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRp For2

	HALT


;data
DATAptr .fill x4000
Line .fill xA

SentCount .fill #10
;
.orig x4000
Array	.BLKW #10

.end
