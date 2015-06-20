;=================================================
; 
; Name: Villarreal, Samuel
; Login id: svill017
; 
; Assignment name: <assn 6>
; Lab section: <023>
; TA: tammewar
; 
; I hereby certify that the contents of this file
; are ENTIRELY my own original work. 
;
;=================================================

.orig x3000
	LD R6, START
	JSRR R6

	LD R6, DEC_TO_HEX
	JSRR R6
	
	HALT
;data
START .fill x3200
DEC_TO_HEX .fill x3400

.orig x3200
;-------------------------------------------------------
;INTRO subroutine 
;INPUTS: NONE 
;POST: gets input and stores value in R1 
;-------------------------------------------------------
;store
	ST R7, R73200
;logic
	LD R0, LINE
	OUT
	LEA R0, INTRO
	PUTS
	LD R0, LINE
	OUT
	LD R3, SENT
	LD R1, ZERO ; sets up 0 in R1

MAIN ; the processing of the numbers;
	GETC
	OUT
	LD R5, NL
	ADD R5, R0, R5
	BRz END ; if newline entered exit
	LEA R6, MULTI
	JMP R6

RETURN ;gets back from MULTI10
	LD R4, SYMZ
	ADD R2, R0, R4
	ADD R1, R1, R2
	ADD R3, R3, #-1; check sentinal 
	BRp MAIN 
	GETC
	OUT
END
	LD R7, R73200
	RET

	

MULTI; multiples number by 10
	LD R4, MSENT
	ADD R2, R1, #0
AGAIN ; for loop to iterate
	ADD R1, R1, R2
	ADD R4, R4, #-1
	BRz RETURN
	BR AGAIN
	

;data
R73200 .blkw #1
INTRO .STRINGZ "Welcome, please give a number 0-65535 followed by enter:"
SENT .fill #5
MSENT .fill #9
LINE .fill xA
NL .fill -xA
; symboles value subtraction ready values
ZERO .fill #0
SYMZ .fill #-48 ; zero sym conversion

.orig x3400
;-------------------------------------------------------
;DEC_TO_HEX subroutine 
;INPUTS: R1 contains DEC value
;POST: takes R1 and Converts to HEX located at x4100 which is
;then printed using puts
;-------------------------------------------------------
;store
	;ST R1, R13400
	ST R7, R73400
;logic
	LD R0, APTR
	LD R3, X
	STR R3, R0, #0
	ADD R0, R0, #1
	LD R6, Z
	LD R4, Z
	LD R5, Z
	LD R2, VAL1
	ADD R1, R1, #0 ;checks if value is neg
	BRn LOOPPN
	BR NORM
;start of neg pre calculations

LOOPPN ; LOOP TO DETERMINE DEGREE OF DECIMAL 
	ADD R1 , R1 , R2
	BRnz POSPN
	BRp PRENORM

POSPN
	ADD R5, R5, #1
	BR LOOPPN
PRENORM
	ADD R5, R5, #1

;end of neg pre calculations
NORM
	LD R2, VAL1 ; to figure out first 
	LD R7, SCPTR
	JSRR R7
	ADD R3, R3, R5
	LD R7, NINE
	ADD R7, R7, R3
	BRp OVER9
UNDER9
	LD R7, UNDER
	ADD R3, R3, R7
	BR STEP2
	
OVER9
	LD R7, OVER
	ADD R3, R3 , R7
STEP2
	STR R3, R0, #0 ;store first value
	ADD R0, R0, #1 

	LD R2, VAL2 ; uses 16^2
	LD R7, SCPTR
	JSRR R7
	LD R7, NINE
	ADD R7, R7, R3
	BRp OVER92
UNDER92
	LD R7, UNDER
	ADD R3, R3, R7
	BR STEP3
	
OVER92
	LD R7, OVER
	ADD R3, R3 , R7
STEP3
	STR R3, R0, #0 ;stores second hex value
	ADD R0, R0, #1

	LD R2, VAL3 ; uses 16
	LD R7, SCPTR
	JSRR R7

	LD R7, NINE
	ADD R7, R7, R3
	BRp OVER93
UNDER93
	LD R7, UNDER
	ADD R3, R3, R7
	BR STEP4
	
OVER93
	LD R7, OVER
	ADD R3, R3 , R7
STEP4

	STR R3, R0, #0 ; stores third hex value
	ADD R0, R0, #1

	LD R2, VAL4 ; uses 1
	LD R7, SCPTR
	JSRR R7

	LD R7, NINE
	ADD R7, R7, R3
	BRp OVER94
UNDER94
	LD R7, UNDER
	ADD R3, R3, R7
	BR STEP5
	
OVER94
	LD R7, OVER
	ADD R3, R3 , R7
STEP5

	STR R3, R0, #0 ;stores 4th value of hex
	ADD R0, R0, #1
	
	LD R3, Z
	STR R3, R0, #0 ; stores the NULL

ENDH
	LD R0, APTR
	PUTS 
	LD R7, R73400
	RET

;data
SCPTR .fill x3600
R73400 .blkw #1
APTR .fill x4000
NINE .fill #-9
UNDER .fill #48
OVER .fill #55
Z .fill #0
X .fill #120
VAL1 .fill #-4096
VAL2 .fill #-256
VAL3 .fill #-16
VAL4 .fill #-1


.ORIG x3600
;---------------------------------------------------
;SUB COUNTER
;INPUT TAKES IN R1 VALUE AND R2 COMPARISION VALUE
;POST: DOES THE ACTUALY ARITHMATIC putting counted val in R3
;--------------------------------------------------
	ST R7, R7_BACKUP_36
	ST R0, R0_BACKUP_36

ZEROP ;RESETS R0
	LD R3, Z36
LOOPP ; LOOP TO DETERMINE DEGREE OF DECIMAL 
	ADD R1 , R1 , R2
	BRzp POSP
	BRn NEXTP

POSP
	ADD R3, R3, #1
	BR LOOPP

NEXTP
	NOT R2, R2
	ADD R2, R2, #1
	ADD R1, R1, R2 ; UNDO last sign neg

	LD R7, R7_BACKUP_36
	LD R0, R0_BACKUP_36
	RET

;DATA 
R7_BACKUP_36 .BLKW #1
R0_BACKUP_36 .BLKW #1
Z36 .FILL #0


.orig x4000
AR1 .blkw #5

.end
