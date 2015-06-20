;=================================================
; 
; Name: villarreal samuel
; Login id: 861021551
; 
; Assignment name: <assn 5>
; Lab section: <023>
; TA: Aditya Tammewar 
; I hereby certify that the contents of this file
; are ENTIRELY my own original work. 
;
;=================================================

.orig x3000
	LD R6, INTROP
	JSRR R6

	LD R6, CONVER
	JSRR R6

	LD R6, SIZECMP
	JSRR R6

	LD R6, MULT
	JSRR R6

	LD R6, CONVFA
	JSRR R6
	
	HALT

;data
INTROP .fill x3200
CONVER .fill x3400
SIZECMP .fill x3600
MULT .fill x3800
CONVFA .fill x4000


.orig x3200
;INTRO subroutine 
;INPUTS: NONE 
;POST: gets valid input 
	ST R7, R73200
RESET ; if invalid input sent back
	LEA R0, INTRO
	PUTS
	LD R0, LINE
	OUT
	LD R3, SENT
	LD R1, ZERO ; sets up 0 in R1
	LD R5, ARR1 ; sets R5 to array 1
	GETC
	OUT
	STR R0, R5, #0
	ADD R5, R5, #1
	LD R4, SYMN
	ADD R2, R0, R4; checks -
	BRz MAIN
	LD R4, SYMP
	ADD R2, R0, R4;checks +
	BRz MAIN
	LEA R6, EPROMPT
	JMP R6

	
MAIN ; the processing of the numbers;
	GETC
	OUT
MAIN1
	STR R0, R5, #0
	ADD R5, R5, #1
	LD R4, SYM9
	ADD R2, R0, R4 ;checks for symbole after 9
	BRp EPROMPT
	LD R4, SYMZ
	ADD R2, R0, R4 ;checks for symbol before 0
	BRn EPROMPT
	
	GETC
	OUT
	LD R4, NLINE
	ADD R4, R0, R4
	BRz STARTN
	

	ADD R3, R3, #-1; check sentinal 
	BRp MAIN1

STARTN
	LD R0, LINE
	STR R0, R5, #0
	LEA R0, INTRO2
	PUTS
	LD R0, LINE
	OUT
	LD R3, SENT
	LD R1, ZERO ; sets up 0 in R1
	LD R5, ARR2 ; sets R5 to array 2
	GETC
	OUT
	STR R0, R5, #0
	ADD R5, R5, #1
	LD R4, SYMN
	ADD R2, R0, R4; checks -
	BRz MAIN2x
	LD R4, SYMP
	ADD R2, R0, R4;checks +
	BRz MAIN2x
	LEA R6, EPROMPT
	JMP R6

	
MAIN2x ; the processing of the numbers;
	GETC
	OUT
MAIN2
	STR R0, R5, #0
	ADD R5, R5, #1
	LD R4, SYM9
	ADD R2, R0, R4 ;checks for symbole after 9
	BRp EPROMPT
	LD R4, SYMZ
	ADD R2, R0, R4 ;checks for symbol before 0
	BRn EPROMPT

	GETC
	OUT
	LD R4, NLINE
	ADD R4, R0, R4
	BRz END


	ADD R3, R3, #-1; check sentinal 
	BRp MAIN2

END
		LD R0, LINE
	STR R0, R5, #0

	LD R7, R73200
	RET

	
EPROMPT; gives the error message and starts over
	LD R0, LINE
	OUT
	LEA R0, ERR
	PUTS
	LD R0, LINE
	OUT
	LEA R6, RESET
	JMP R6



;dataINTRO
R73200 .blkw #1
INTRO .STRINGZ "Welcome, please give a 5 digit decimal number preceded by (+/-), followed by enter:"
INTRO2 .STRINGZ "input next 5 digit decimal number precded by (+/-)"
ERR .STRINGZ " input error resetting ";
SENT .fill #5
MSENT .fill #9
LINE .fill xA
NLINE .fill -xA
; symboles value subtraction ready values
ZERO .fill #0
SYMN .fill #-45 ; negative conversion
SYMP .fill #-43 ; positive coversion
SYMZ .fill #-48 ; zero sym conversion
SYM9 .fill #-57 ; 9 sym conversion
ARR1 .fill x4100
ARR2 .fill x4200

.orig x3400
;CONVER subroutine
;inputs:none contains pointer to arrays
; post: converts  numeric array into number and stores in R1 R2

	ST R7, R73400
;logic
	LD R3, ARR1C

MAINC1 ; the processing of the numbers;
	LDR R1, R3, #0
	ADD R3, R3, #1
	LD R6, Z
	LD R7, SYMPC
	ADD R6, R1, R7
	BRz CONTC

NEGC
	ADD R6, R6, #-5
CONTC
	LDR R1, R3, #0
	ADD R3, R3, #1
	LD R2, C
	ADD R1, R2, R1

B2
	LDR R0, R3, #0
	LD R2, NLINE2
	ADD R2, R0, R2
	BRz INTERM
	LD R2, C
	ADD R0, R2, R0
	ADD R3, R3, #1
	BR MULTI
TB
	ADD R1, R0, R1
	BR B2
CONVERTC
	NOT R1, R1
	ADD R1, R1, #1
	BR SOL1
	

MULTI; multiples number by 10
	LD R4, MSENTC
	ADD R2, R1, #0
AGAIN ; for loop to iterate
	ADD R1, R1, R2
	ADD R4, R4, #-1
	BRz TB
	BR AGAIN	
INTERM
	ADD R6, R6, #0
	BRn CONVERTC
SOL1
	ST R1, SOL



;---------------------------------
MAINC2
	LD R3, ARR2C
	LDR R1, R3, #0
	ADD R3, R3, #1
	LD R6, Z
	LD R7, SYMPC
	ADD R6, R1, R7
	BRz CONTC2

NEGC2
	ADD R6, R6, #-5
CONTC2
	LDR R1, R3, #0
	ADD R3, R3, #1
	LD R2, C
	ADD R1, R2, R1

B22
	LDR R0, R3, #0
	LD R2, NLINE2
	ADD R2, R0, R2
	BRz INTERM2
	LD R2, C
	ADD R0, R2, R0
	ADD R3, R3, #1
	BR MULTI2
TB2
	ADD R1, R0, R1
	BR B22

INTERM2
	ADD R6, R6, #0
	BRn CONVERTC2


END2
	LD R2, SOL
	LD R7, R73400
	RET
CONVERTC2
	NOT R1, R1
	ADD R1, R1, #1
	BR END2


;--------------------------
MULTI2; multiples number by 10
	LD R4, MSENTC
	ADD R2, R1, #0
AGAIN2 ; for loop to iterate
	ADD R1, R1, R2
	ADD R4, R4, #-1
	BRz TB2
	BR AGAIN2	

;dataCOVER
R73400 .blkw #1
ARR1C .fill x4100
ARR2C .fill x4200
MSENTC .fill #9
SYMNC .fill #-45 ; negative conversion
SYMPC .fill #-43 ; positive coversion
C .fill #-48
Z .fill #0
NLINE2 .fill -xA
SOL .blkw #1


.orig x3600
;SIZECMP subrou\tine
;inputs: R1, R2 to be compared
;post: puts the bigger value in R1
	ST R7, R73600
	ST R1, R13600
	ST R2, R23600
	
;logic
	LD R5, Z2
	LD R6, Z2
	ADD R1 , R1 , #0
	BRn NEGCMP1
	BR TEST2
NEGCMP1
	ADD R5, R5, #-1
	NOT R1, R1
	ADD R1, R1, #1

TEST2
	ADD R2, R2, #0
	BRn NEGCMP2
	BR SCMP

NEGCMP2
	ADD R6, R6, #-1
	NOT R2, R2
	ADD R1, R1, #1

SCMP
	NOT R1, R1
	ADD R1, R1, #1
	ADD R0, R2, R1
	BRnz BIGR1
	BR BIGR2

BIGR1
	LD R1, R13600
	LD R2, R23600
	LD R7, R73600
	RET

BIGR2	
	LD R1, R23600	
	LD R2, R13600
	LD R7, R73600
	RET


;dataSIZECMP
R73600 .blkw #1
R13600 .blkw #1
R23600 .blkw #1
Z2 .fill #0

.orig x3800
;MULT subroutine
;inputs: R1, R2 to be multiplied 
;post: puts the final value in r0
	ST R7, R73800
;logic
	LD R5, Z3
	LD R6, Z3
	ADD R1, R1, #0
	BRn NEGM1
	BR CM1

NEGM1
	ADD R5, R5, #-1
	NOT R1, R1
	ADD R1, R1, #1

CM1
	ADD R2, R2, #0
	BRn NEGM2
	BR MMULT

NEGM2
	ADD R6, R6, #-1
	NOT R2, R2
	ADD R2, R2, #1

MMULT
	ADD R3, R2, #0
	LD R0, Z3
LOOPM
	ADD R0, R0, R1
	ADD R4, R0, #0
	BRn EMULT
	ADD R3, R3, #-1
	BRz ENDMULT
	BR LOOPM



ENDMULT
	ADD R6, R5, R6
	ADD R6, R6, #1
	BRz CN
RENDM
	LD R7, R73800
	RET

EMULT
	ADD R7, R5, R6
	ADD R7, R7, #1
	BRz EMULT2
	LEA R0, ERM
	PUTS
	HALT

EMULT2
	LEA R0, ERM2
	PUTS
	HALT

CN
	NOT R0, R0
	ADD R0, R0, #1
	BR RENDM
	

;dataMULT
R73800 .blkw #1
ERM .STRINGZ "OVER FLOW" 
ERM2 .STRINGZ "UNDER FLOW"
Z3 .fill #0

.orig x4000
;CONVFA subroutine
;inputs R0 with answer from the MULT
;post: makes the char array to put number out

	ST R7, R7_BACKUP
	ST R1, R1_BACKUP
;LOGIC
	ADD R1, R0 , #0
	BRzp POSPP
NEGP 
	LD R0, SYMNN
	OUT
	NOT R1, R1
	ADD R1, R1, #1

POSPP
	LD R3, VAL1
	LD R6, PTRC
	JSRR R6
	
	LD R3, VAL2
	JSRR R6

	LD R3, VAL3
	JSRR R6

	LD R3, VAL4
	JSRR R6

	LD R3, VAL5
	JSRR R6

	HALT

;dataCONVFA 
R74000 .blkw #1
SENTP .fill #5
PTRC .FILL x4300
SYMNN .fill x2D
VAL1 .FILL #-10000
VAL2 .FILL #-1000
VAL3 .FILL #-100
VAL4 .FILL #-10
VAL5 .FILL #-1
R7_BACKUP .blkw #1
R1_BACKUP .blkw #1

.orig x4100
	.blkw #7

.orig x4200
	.blkw #7

.orig x4300
;SUB COUNTER
;INPUT TAKES IN R2 VALUE AND R3 COMPARISION VALUE
;POST: DOES THE ACTUALY ARITHMATIC 

	ST R7, R7_BACKUP_36

ZEROP ;RESETS R0
	LD R0, Z36
LOOPP ; LOOP TO DETERMINE DEGREE OF DECIMAL 
	ADD R1 , R1 , R3
	BRzp POSP
	BRn NEXTP

POSP
	ADD R0, R0, #1
	BR LOOPP

NEXTP
	NOT R3, R3
	ADD R3, R3, #1
	ADD R1, R1, R3 ; UNDO NEG
	LD R5, CONVDEC
	ADD R0, R0, R5 ; ASCII VAL
	OUT

	LD R7, R7_BACKUP_36
	RET

;DATA 
R7_BACKUP_36 .BLKW #1
Z36 .FILL #0
CONVDEC .fill #48

.end





