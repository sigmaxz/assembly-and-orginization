;
; Villarreal, Samuel
; 861-02-1551
; Login: svill017
; Section: 023
; TA: Aditaya Tammewar 
; Email: svill017@ucr.edu
; Lab 01
;
;
;;hello world

	.ORIG x3000

	LEA R0, message
	PUTS
	HALT

	;;end

message	.STRINGZ	"Hello World!!\n"
	.END
