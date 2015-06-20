.orig x3000
	LD R0, PTR
	LD R1, SENT
	LD R2 , START
LOOP
	STR R2, R0, #0
	ADD R0, R0, #1
	ADD R2, R2, R2
	ADD R1, R1, #-1
	BRp LOOP
	HALT

;data
;
PTR .fill x4000
SENT .fill #10
START .fill #1

.orig x4000
	.BLKW #10
.end
