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
	LDI R3, DEC_65
	LDI R4, HEX_41
	ADD R3, R3, #1
	ADD R4, R4 , #1
	STI R3, DEC_65
	STI R4, HEX_41
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
