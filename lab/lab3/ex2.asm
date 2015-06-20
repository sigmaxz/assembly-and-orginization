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
	GETC
	STR R0, R1, 0
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRp For
	HALT


;data
DATAptr .fill x4000

SentCount .fill #10
;
.orig x4000
Array	.BLKW #10

.end

