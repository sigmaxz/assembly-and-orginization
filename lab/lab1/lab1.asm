;----------------------------------------------------------
; Villarreal, Samuel
; 861-02-1551
; Login: svill017
; Secion: 023
; Email: svill017@ucr.edu
; Lab 01
; TA: Aditaya Tammewar 
;----------------------------------------------------------
.orig x3000
;-----------------
;Instuctions
;-----------------
LD R1, DEC_0
LD R2, DEC_12
LD R6, DEC_6

FOR_LOOP_1
	ADD R1, R1 , R2
	ADD R6, R6, #-1
	BRp FOR_LOOP_1
END_FOR_LOOP_1
HALT

;----------
; Data
;----------
DEC_0	.fill #0
DEC_6	.fill #6
DEC_12	.fill #12
.end

