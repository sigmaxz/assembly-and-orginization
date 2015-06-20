;----------------------------------------------------------
; Name: Samuel Villarreal
; Login: svill017
; Email: svill017@ucr.edu
; Assignment: assn2
; Secion: 023
; TA: Aditaya Tammewar 
;
; I hereby certify that this homework submission is entirely my own work
;--------------------------------
.ORIG x3000
;
; loads
	LD R1, INVERSE	; conversion factor to deci
	LD R2, REVERT	; converstion back to symbol
  
  IN
	ADD R3, R0, R1; first conversion to deci value
  IN
	ADD R4, R0, R1; secound conversion to deci value
  NOT R4, R4    ; switches to negative
  ADD R4, R4, #1; off set
	ADD R0, R3, R4
  BRzp POS ; checks for negative
  LD R0, NSYM; preparing to output '-'
  OUT
  ADD R0, R3, R4; gets true answer
  Not R0, R0    ; switches to positive 
  ADD R0, R0, #1; off set
POS
  ADD R0, R0, R2; back to symbol
  OUT
	HALT
;
;DATA
;
INVERSE .fill	#-48
REVERT	.fill	#48	
NSYM  .STRINGZ "-"
.end
