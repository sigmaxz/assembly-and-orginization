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
	IN
	LD R0, mptr
	PUTS
HALT
;data
mptr	.fill x4000
.orig x4000
	.STRINGZ	"HELLO"
.end
