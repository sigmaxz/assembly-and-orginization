.orig x3000

	LEA R0, INTRO
	PUTS
	GETC
	OUT 
	LD R6, PTR
	JSRR R6
	HALT

;data
INTRO .STRINGZ "INPUT THE SYM:"
PTR .FILL x3200

.orig x3200
;SUB COUNTER
;INPUT: YOU GIVE IT R0 WITH THE VALUE
;Post : prints out the number of 1's 

	ST R7, R7_BACKUP

	ADD R1, R0, #0
	LD R2, SENT
	ADD R5, R2, #-16
	ADD R1, R1, #0
	BRnz NEG
	BR POS

TOP
	ADD R2, R2, #-1
	BRz END
	ADD R1, R1, R1
	BRp POS
	BRnz NEG
	

POS
	;LD R0, ZERO ;putting sym 0 to print
	;OUT
	BR TOP

NEG
	;LD R0, ONE ; putting sym 1 to print
	;OUT
	ADD R5, R5, #1
	BR TOP

END
	LD R0, LINE
	OUT
	LEA R0, MESS
	PUTS
	LD R4, ZERO
	ADD R0,R5,R4
	OUT
	HALT

;
;data
R7_BACKUP .BLKW #1
LINE .FILL xA

NUM .fill #1024 ; hard coded value
SENT .fill #16 ; counter for loop
ZERO .fill #48 ; 0 symbol
ONE .fill #49 ; 1 symbol
MESS .STRINGZ "THE NUMBER OF 1'S ARE "

.end
