;----------------------------------------------------------
; Name: Samuel Villarreal
; Login: svill017
; Email: svill017@ucr.edu
; Assignment: assn1
; Secion: 023
; TA: Aditaya Tammewar 
;
; I attest that this code was totally given to me and that 
; I didn't come up with any of it
;--------------------------------

;-------------------------------------------------------------------------
;REG VALUES	R0	R1	R2	R3	R4	R5 	R6	R7
;-------------------------------------------------------------------------
;Pre-loop	0	6	12	0	0	0	0	1168
;Iteration 01	0	5	12	0	0	0	12	1168
;iteration 02	0	4	12	0	0	0	24	1168
;Iteration 03	0	3	12	0	0	0	36	1168
;Iteration 05	0	2	12	0	0	0	48	1168
;Iteration 06	0	1	12	0	0	0	60	1168
;End of Program 0	0	12	0	0	0	72	DEC_0
;
;----------------------------------------------------------
.orig x3000
;-----------------
;Instuctions
;-----------------
LD R1, DEC_6
LD R2, DEC_12
LD R6, DEC_0

DO_WHILE
	ADD R3, R3 , R2
	ADD R1, R1, #-1
	BRp DO_WHILE
HALT

;----------
; Data
;----------
DEC_0	.fill #0
DEC_6	.fill #6
DEC_12	.fill #12
.end

