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
	LD R5, DEC_65
	LD R6, HEX_41
	LDR R3, R5, 0
	LDR R4, R6, 0
	ADD R3, R3, #1
	ADD R4, R4, #1
	STR R3, R5, 0
	STR R4, R6, 0
	HALT
;
;data
DEC_65 .fill x4000
HEX_41 .fill x4001
;;
;; Remote data
;;
.orig x4000
 .FILL #65
 .FILL x41
.end
