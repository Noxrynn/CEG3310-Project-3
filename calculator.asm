.ORIG x3000

START
BR START

GETNUM
; Get first digit
GETC
ADD R1, R0, #0

; Turn ASCII into a number
LD R2, fourtyEight
ADD R1, R1, R2

; Get second digit
GETC

; Turn ASCII into a number
LD R2, fourtyEight
ADD R0, R0, R2

; Multiply first digit by 10 to take it to tens place
ADD R2, R1, R1
ADD R2, R2, R2
ADD R2, R2, R2
ADD R2, R2, R1
ADD R2, R2, R1

; Add second digit
ADD R0, R2, R0
RET

GETOP
RET

CALC
RET

DISPLAY
RET




FOURTYEIGHT
    .FILL #-48
.END