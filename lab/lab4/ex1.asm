.orig x3000
	LD R0, PTR
	LD R1, SENT
	LDI R2 , #0
LOOP
	STR R2, R0, #0
	ADD R0, R0, #1
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp LOOP

	LD R0, PTR
	ADD R0, R0, #6
	LDR R2, R0, 0
	HALT

;data
;
PTR .fill x4000
SENT .fill #10
.orig x4000
	.BLKW #10

.end
