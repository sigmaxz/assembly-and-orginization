;=================================================
; 
; Name: Villarreal, Samuel
; Login id: svill017
; 
; Assignment name: <assn 8>
; Lab section: <023>
; TA: tammewar
; 
; I hereby certify that the contents of this file
; are ENTIRELY my own original work. 
;
;=================================================

.orig x3000
loop ; to keep the program running
	LD R6, MENU 
	JSRR R6 ; goes off to menu subroutine
	ADD R6, R1, #-7 ; checks for exit condition
	BRz ENDL ;exits if condition met
	ADD R6, R1, #-1
	BRnp RCAMBL ; if choice was not 1 skips option
; option 1
	LD R6, ALL_MACHINES_BUSY 
	JSRR R6 ; goes off to all_machines_busy subroutine
	ADD R2, R2, #0
	BRp ALLBUSY ; checks return value to decide which message to print
	LEA R0, AMBN
	PUTS ; all machines are not busy
	BR RCAMB
ALLBUSY
	LEA R0, AMBY ; messag for all are busy
	PUTS
RCAMB ; end of choice 1
	BR loop
RCAMBL
	ADD R6, R1, #-2
	BRnp RCAMFL
; option 2
	LD R6, ALL_MACHINES_FREE 
	JSRR R6 ; goes off to all_machines_free subroutine
	ADD R2, R2, #0
	BRp ALLFREE ; checks return value to decide which message to print
	LEA R0, AMFN
	PUTS ; all machines are not busy
	BR RCAMF
ALLFREE
	LEA R0, AMFY ; messag for all are busy
	PUTS
RCAMF ; end of choice 2
	BR loop
RCAMFL
; check for next case
	ADD R6, R1, #-3 ;checking if 3rd option was requested
	BRnp RCNBML
; option 3
	LD R6, NUM_BUSY_MACHINES
	JSRR R6 ; goes off to num_busy_machines subroutine
	LEA R0, THERE
	PUTS
	ADD R6, R2, #-9 ; checking if R2 was greater than 9
	BRnz NORMB
	ADD R2, R2, #-10 ; cutting the number down to printable amount
	LD R0, ONE ; printing the 1 in the number > 9 so its 1x
	OUT
NORMB
	LD R0, CON ; convert to symbol
	ADD R0, R2, R0
	OUT
	LEA R0, BUS
	PUTS
	
	BR loop
RCNBML
; check for next case
	ADD R6, R1, #-4 ; checking if 4th option is requested
	BRnp RCNFML
; option 4
	LD R6, NUM_FREE_MACHINES
	JSRR R6 ; goes off to num_free_machines subroutine
	LEA R0, THERE
	PUTS
	ADD R6, R2, #-9 ; checking if R2 greater than 9
	BRnz NORM
	ADD R2, R2, #-10 ; cutting the number down to print able amount
	LD R0, ONE ; printing the 1 in the number greater then 9 so its 1x
	OUT
NORM	
	LD R0, CON
	ADD R0, R2, R0 ; converting number to symbol to print
	OUT
	LEA R0, FRE
	PUTS
	
	BR loop
RCNFML
	ADD R6, R1, #-5
	BRnp RCMS
; option 5
	LD R6, VALID ; get valid input for R1
	JSRR R6
	LD R6, MACHINE_STATUS
	JSRR R6 ; go to machine status
	ADD R6, R1, #-9 ; checking if R1 was greater than 9
	BRnz NORMMS
	ADD R1, R1, #-10 ; cutting the number down to printable amount
	LD R0, ONE ; printing the 1 in the number > 9 so its 1x
	OUT
NORMMS
	LD R0, CON ; convert to symbol
	ADD R0, R1, R0
	OUT
	ADD R2, R2, #0 ; checking R2 for 0 
	BRz MSB
	LEA R0, IF ; is free messg
	PUTS
	BR loop
MSB
	LEA R0, IB ; is busy messg
	PUTS
	BR loop
RCMS
	ADD R6, R1, #-6
	BRnp loop
; option 6
	LD R6, FIRST_FREE ; fine first free
	JSRR R6
	ADD R6, R2, #-16 ; checks if there is none free
	BRz ERFF
	LEA R0, FAM
	PUTS
	ADD R6, R2, #-9 ; checking if R2 greater than 9
	BRnz NORF
	ADD R2, R2, #-10 ; cutting the number down to print able amount
	LD R0, ONE ; printing the 1 in the number greater then 9 so its 1x
	OUT
NORF
	LD R0, CON
	ADD R0, R2, R0 ; converting number to symbol to print
	OUT
	BR loop

	
ERFF
	LEA R0, EFF
	PUTS
	BR loop
	
ENDL
	LEA R0, GB ;goodby message
	PUTS
	HALT
;data
ONE .fill #49
MENU .fill x3200
LINE .fill xA
CON .fill #48
ALL_MACHINES_BUSY .fill x3400
ALL_MACHINES_FREE .fill x3600
NUM_BUSY_MACHINES .fill x3800
NUM_FREE_MACHINES .fill x4000
MACHINE_STATUS .fill x4200
FIRST_FREE .fill x4400
VALID .fill x4600
AMBY .STRINGZ "All machines are busy"
AMBN .STRINGZ "ALL machines are not busy"
AMFY .STRINGZ "All machines are free"
AMFN .STRINGZ "All machines are not free"
THERE .STRINGZ "There are "
BUS .STRINGZ " Busy machines "
FRE .STRINGZ " Free machines "
IB .STRINGZ " is busy"
IF .STRINGZ " is free"
FAM .STRINGZ "first available machine #:"
EFF .STRINGZ "no machine available"
GB .STRINGZ " GOODBYE!"

.orig x3200
;-------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
; user to select an option, and returned the selected option.
; Return Value (R1): The option selected: #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-------------------------------------------------------------------------------
;store
	ST R7, MENUR7
;logic
	LD R0, MENULINE
	OUT
	LEA R0, MENU1 ; print out the menu 
	PUTS
	LD R0, MENULINE
	OUT
	LEA R0, MENU2
	PUTS
	LD R0, MENULINE
	OUT
	LEA R0, MENU3
	PUTS
	LD R0, MENULINE
	OUT
	LEA R0, MENU4
	PUTS
	LD R0, MENULINE
	OUT
	LEA R0, MENU5
	PUTS
	LD R0, MENULINE
	OUT
	LEA R0, MENU6
	PUTS
	LD R0, MENULINE
	OUT
	LD R0, PTRM7
	PUTS
	LD R0, MENULINE
	OUT
	LEA R0, MENU8
	PUTS
	LD R0, MENULINE
	OUT ; done printing out the stringz

	LEA R0, MENU9
	PUTS

	GETC
	OUT
	LD R6, CONVERT
	ADD R1, R0, R6
	LD R0, MENULINE
	OUT

;return
	LD R7, MENUR7 
	RET

;data
MENULINE .fill xA
CONVERT .fill #-48
MENUR7 .blkw #1
PTRM7 .fill x3350
MENU1 .STRINGZ "The Busyness SERVER~"
MENU2 .STRINGZ "1. Check to see whether all machines are busy"
MENU3 .STRINGZ "2. Check to see whether all machines are free"
MENU8 .STRINGZ "7. Quit"
MENU9 .STRINGZ "Please give input now :"
MENU4 .STRINGZ "3. Report the number of busy machines"
MENU5 .STRINGZ "4. Report the number of free machines"
MENU6 .STRINGZ "5. Report the status of machine n"

.orig x3350
MENU7 .STRINGZ "6. Report the number of the first available machine"
.orig x3400
;-----------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy and i chose to print results here
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-------------------------------------------------------------------------------
;store
	ST R7, AMBR7
;logic
	LD R2, Z
	LDI R0, PTRD
	AND R6, R0, #-1 ; anding with xffff in twos complement is -1
	BRz ABUSY
;if it didn't break at least one machine is not busy
	BR ENDAMB
ABUSY
	ADD R2, R2, #1
ENDAMB
	LD R7, AMBR7
	RET
;data
AMBR7 .blkw #1
PTRD .fill x5000
Z .fill #0
.orig x3600
;-------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;--------------------------------------------------------------------------
;store
	ST R7, AMFR7
;logic
	LD R2, Z2 ;setting R2 to false fromt he start
	LDI R0, PTRF
	ADD R6, R0, #1 ; adding 1 to xFFFF(the value for free) is 0
	BRz AFREE
	BR ENDAMF
AFREE
	ADD R2, R2, #1 ; adding 1 to R2 to make it true if condition met
ENDAMF
	LD R7, AMFR7
	RET
;data
AMFR7 .blkw #1
Z2 .fill #0
PTRF .fill x5000

.orig x3800
;------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------
;store
	ST R7, NBMR7
;logic
	LD R2, Z3
	LDI R0, PTRNUM
	LD R3, SENTB
NUML
	ADD R0, R0, #0
	BRn DONTADD
	ADD R2, R2, #1
DONTADD
	ADD R0, R0, R0
	ADD R3, R3, #-1
	BRz ENDNBM
	BR NUML

ENDNBM
	LD R7, NBMR7
	RET	
;data
PTRNUM .fill x5000
NBMR7 .blkw #1
Z3 .fill #0
SENTB .fill #16

.orig x4000
;-------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free
;-----------------------------------------------------------------------
;store
	ST R7, NFMR7
;logic
	LD R6, NBM
	JSRR R6 ; calling number of busy machines
	LD R6, COUNT
	ADD R2, R2, R6 ; subtracting busy machines by total
	NOT R2, R2 ; making the solution positive 
	ADD R2, R2, #1
;return
	LD R7, NFMR7
	RET

;data
NFMR7 .blkw #1
NBM .fill x3800
COUNT .fill #-16

.orig x4200
;-------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
; by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-------------------------------------------------------------------------------
;store
	ST R7, MSR7
;logic
	LD R2, Z4
	LDI R0, PTRMS
	ADD R6, R1, #-15 ; number of times adding R1 to left shift
	BRz MSCONT ; checking if 16 was requested
MSLOOP
	ADD R0, R0, R0 ; doing shifts
	ADD R6, R6, #1
	BRz MSCONT
	BR MSLOOP
MSCONT
	ADD R0, R0, #0 ; checking last bit
	BRzp ENDMS
	ADD R2, R2, #1
ENDMS
	LD R7, MSR7
	RET
;data
Z4 .fill #0
MSR7 .blkw #1
PTRMS .fill x5000

.orig x4400
;-------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition:
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-------------------------------------------------------------------------------
;store
	ST R7, FFR7
;logic
	LD R2, ZZ
	LDI R0, PTRFF
	AND R6, R0, #1 ; looking at machine 0
	BRz NX
	BR ENDFF

NX
	ADD R2, R2, #1 ; increment
	AND R6, R0, #2 ; looking at machine 1
	BRz NX2
	BR ENDFF
NX2
	ADD R2, R2, #1 ; increment
	AND R6, R0, #4 ; looking at machine 2
	BRz NX3
	BR ENDFF
NX3
	ADD R2, R2, #1; increment
	AND R6, R0, #8 ; lookcing at machine 3
	BRz NX4
	BR ENDFF
NX4
	ADD R2, R2, #1; increment
	LD R6, val1
	AND R6, R0, R6 ; looking at machine 4
	BRz NX5
	BR ENDFF
NX5
	ADD R2, R2, #1; increment
	LD R6, val2
	AND R6, R0, R6 ; looking at machine 5
	BRz NX6
	BR ENDFF
NX6
	ADD R2, R2, #1; increment
	LD R6, val3
	AND R6, R0, R6 ; looking at machine 6
	BRz NX7
	BR ENDFF
NX7
	ADD R2, R2, #1; increment
	LD R6, val4
	AND R6, R0, R6 ; looking at machine 7
	BRz NX8
	BR ENDFF
NX8
	ADD R2, R2, #1; increment
	LD R6, val5
	AND R6, R0, R6 ; looking at machine 8
	BRz NX9
	BR ENDFF
NX9
	ADD R2, R2, #1; increment
	LD R6, val6
	AND R6, R0, R6 ; looking at machine 9
	BRz NXA
	BR ENDFF
NXA
	ADD R2, R2, #1; increment
	LD R6, val7
	AND R6, R0, R6 ; looking at machine 10
	BRz NXB
	BR ENDFF
NXB
	ADD R2, R2, #1; increment
	LD R6, val8
	AND R6, R0, R6 ; looking at machine 11
	BRz NXC
	BR ENDFF
NXC
	ADD R2, R2, #1; increment
	LD R6, val9
	AND R6, R0, R6 ; looking at machine 12
	BRz NXD
	BR ENDFF
NXD
	ADD R2, R2, #1; increment
	LD R6, val10
	AND R6, R0, R6 ; looking at machine 13
	BRz NXE
	BR ENDFF
NXE
	ADD R2, R2, #1; increment
	LD R6, val11
	AND R6, R0, R6 ; looking at machine 14
	BRz NXF
	BR ENDFF
NXF
	ADD R2, R2, #1
	ADD R0, R0, #0
	BRn ENDFF
	ADD R2, R2, #1

ENDFF
	LD R7, FFR7
	RET
;data
FFR7 .blkw #1
ZZ .fill #0
val1 .fill #16
val2 .fill #32
val3 .fill #64
val4 .fill #128
val5 .fill #256
val6 .fill #512
val7 .fill #1024
val8 .fill #2048
val9 .fill #4096
val10 .fill #8192
val11 .fill #16384
PTRFF .fill x5000
.orig x4600
;------------------------------------------------------------------------------
;Subroutine: valid
;INPUTS : NONE
;Postcondition: R1 will contain a valid machine number
;Return value(R1): the number of machine checked by machine status in #
;------------------------------------------------------------------------------
;store
	ST R7, V7	
;logic
VD
	LEA R0, VMES ; request message
	PUTS
	GETC ; get the input
	OUT
	LD R6, LNUMC 
	ADD R6, R6, R0 ; checks if the value for sym is less then symbol 0
	BRn ERRV
	LD R6, UNUMC
	ADD R6, R6, R0 ; checks if the value is <= 0 but >= 9 symbol
	BRnz GOOD
; now to look for a-f
	LD R6, LCC
	ADD R6, R6, R0 ; checking if value is > 9 but <= a symbol
	BRn ERRV
	LD R6, UCC
	ADD R6, R6, R0 ; checking if value is > = a but <= f
	BRnz GOODC
	BR ERRV
ERRV ; error routine
	LD R0, VLINE
	OUT
	LEA R0, VER
	PUTS
	LD R0, VLINE
	OUT
	BR VD

GOOD ; converts num
	LD R6, LNUMC
	ADD R1, R0, R6
	ADD R3, R1, #0
	BR ENDV
	
GOODC ; converts hex letters
	LD R6, LCC
	ADD R1, R0, R6
	ADD R1, R1, #10
;return 
ENDV
	LD R0, VLINE
	OUT
	LD R7, V7
	RET

;data
LNUMC .fill #-48
UNUMC .fill #-57
LCC .fill #-97
UCC .fill #-102
VLINE .fill xA
V7 .blkw #1
VMES .STRINGZ "Which machine do you want the status of (0-f)? lowercase hex plz:"
VER .STRINGZ "This input was not valid please provide within requested range"

.orig x5000
BUSYNESS .fill x8000

.end
