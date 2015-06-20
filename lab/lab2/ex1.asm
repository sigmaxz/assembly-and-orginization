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
	LD R0, DEC_65
	LD R1, HEX_41
	HALT
;
;data
DEC_65 .fill #65
HEX_41 .fill x41
.end
