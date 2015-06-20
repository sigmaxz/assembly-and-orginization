;=================================================
; 
; Name: Villarreal, Samuel
; Login id: svill017
; 
; Assignment name: <assn 7>
; Lab section: <023>
; TA: tammewar
; 
; I hereby certify that the contents of this file
; are ENTIRELY my own original work. 
;
;=================================================

.orig x3000

	LD R1, PTR
	LD R6, INPUT_SENTENCE
	JSRR R6
	LD R6, FIND_LONGEST_WORD
	JSRR R6
	LD R6, PRINT_ANALYSIS
	JSRR R6
	HALT

;data
INPUT_SENTENCE .fill x3200
FIND_LONGEST_WORD .fill x3400
PRINT_ANALYSIS .fill x3600
PTR .fill x4000

.orig x3200
;-------------------------------------------------------------------------------
; Subroutine: INPUT_SENTENCE
; Input (R1): The address of where to store the array of words
; Postcondition: The subroutine has collected an ENTER-terminated string of words from
; the user and stored them in consecutive memory locations, starting at (R1).
; Return Value: None
;------------------------------------------------------------------------------
;store
	ST R7, BU32R7
	ST R1, BU32R1
	LEA R0, PROMPT
	PUTS
;logic
Start ; this is the start of each word
	GETC
	OUT
	LD R6, NLINE ; checks for the routine ending newline
	ADD R6, R6, R0
	BRz ENDIS
	STR R0, R1, #0 ; store
	ADD R1, R1, #1 ; increment the next memory location
LOOP
	GETC
	OUT
	LD R6, NLINE ; checking for then word ending newline
	ADD R6, R6, R0
	BRz WS
	STR R0, R1, #0 ; store
	ADD R1, R1, #1 ; increment the next memory location
	BR LOOP

WS
	LD R0, Z
	STR R0, R1, #0 ; putting the zero to end word
	ADD R1, R1, #1
	BR Start


ENDIS ; loading back for return
	LD R7, BU32R7
	LD R1, BU32R1
	RET	

;data
BU32R7 .blkw #1
BU32R1 .blkw #1
Z .fill #0
PROMPT .STRINGZ "Enter each word followed by an ENTER if you are done pressing ENTER a secound time will end input:"
NLINE .fill -xA	

.orig x3400
;-------------------------------------------------------------------------------
; Subroutine: FIND_LONGEST_WORD
; Input (R1): The address of the array of words
; Postcondition: The subroutine has located and the longest word in the array of words
; Return value (R2): The address of the beginning of the longest word
;-------------------------------------------------------------------------------
;store
	ST R1, BUR134
	ST R7, BUR734
	LD R4, Z2
;logic
STARTF
	LD R3, Z2 ; counter for current check
	LDR R0, R1, #0
	ST R1, TEMPS	
	ADD R1, R1, #1
	LD R6, Z2
	ADD R6, R0, R6 ; checks for the ending 0
	BRz ENDF
	ADD R3, R3, #1
LOOPF
	LDR R0, R1, #0 
	ADD R1, R1, #1
	LD R6, Z2
	ADD R6, R0, R6 ; checks if its the end of the word
	BRz NEXTW
	ADD R3, R3, #1 ; else increment size counter and loop
	BR LOOPF
NEXTW	
	NOT R5, R4
	ADD R5, R5, #1
	ADD R6, R5, R3 ; checking if the new word length is longer than the last
	BRp NEWL
	BR STARTF
NEWL
	LD R2, TEMPS ; loads the address of the new long word
	ADD R4, R3, #0
	BR STARTF
ENDF
	LD R1, BUR134
	LD R7, BUR734
	RET

;data
BUR134 .blkw #1
BUR734 .blkw #1
TEMPS .blkw #1
Z2 .fill #0

.orig x3600
;-------------------------------------------------------------------------------
; Subroutine: PRINT_ANALYSIS
; Input (R1): The address of the beginning of the array of words
; Input (R2): The address of the longest word
; Postcondition: The subroutine has printed out a list of all the words entered as well as the
; longest word in the sentence.
; Return Value: None
;-------------------------------------------------------------------------------
;store
	ST R1, BUR136
	ST R2, BUR236
	ST R7, BUR736
;logic
	LEA R0, PROMPT2
	PUTS
PCHECK
	LD R0, SPACE 
	OUT
	LDR R0, R1, #0
	ADD R1, R1, #1
	ADD R0, R0, #0
	BRz PLONG ; it checks for the exiting 0
	OUT ; else it will print and  continue to loop checking for word end 0
LOOP1
	LDR R0, R1, #0
	ADD R1, R1, #1
	ADD R0, R0, #0
	BRz PCHECK ; checking for end of word
	OUT
	BR LOOP1

PLONG
	LD R0, LINEP ; sets up newline to be output
	OUT
	LEA R0, PROMPT3 ; prompt for long word
	PUTS

LOOPP2 ; simple loop to output just long word from R2
	LDR R0, R2, #0
	ADD R2, R2, #1
	ADD R0, R0, #0
	BRz ENDPA
	OUT
	BR LOOPP2

ENDPA ; load backups and return
	LD R1, BUR136
	LD R2, BUR236
	LD R7, BUR736
	RET

;data
BUR136 .blkw #1
BUR236 .blkw #1
BUR736 .blkw #1
PROMPT2 .STRINGZ "The list of words contain: "
PROMPT3 .STRINGZ "The longest word is: "
LINEP .fill xA
SPACE .fill #32
.end
