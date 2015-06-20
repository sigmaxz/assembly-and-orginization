;
; Villarreal, Samuel
; 861-02-1551
; Login: svill017
; Section: 023
; TA: Aditaya Tammewar 
; Email: svill017@ucr.edu
; Lab 02
;
.orig x3000
	LD R0, date1
	LD R1, date2
loop
	OUT
	ADD R0, R0 , #1
	ADD R1, R1, #-1
	brp loop
endloop

HALT

;
;Data
date1	.fill	x61
date2	.fill 	x1A
.end
