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
    GETC ;because operation symbols dont need to be converted to text
RET

CALC
    ;condition checking for +
    LD R4, PLUS
    NOT R4, R4
    ADD R4, R4, #1
    ADD R4, R2, R4
    BRz ADDITION

    ;condition checking for -
    LD R4, MINUS
    NOT R4, R4
    ADD R4, R4, #1
    ADD R4, R2, R4
    BRz SUBTRACTION

    ;else
    BR MULTIPLICATION

    ADDITION ;simply to add
        ADD R0, R1, R3
    RET

    SUBTRACTION ;2's complement and add
        NOT R3, R3
        ADD R3, R3, #1
        ADD R0, R1, R3
    RET

    MULTIPLICATION ;add multiple times
        AND R0, R0, #0
        MULTIPLY_LOOP
            ADD R0, R0, R1
            ADD R3, R3, #-1
            BRp MULTIPLY_LOOP
    RET
RET

DISPLAY
RET




FOURTYEIGHT
    .FILL #-48

PLUS
    .FILL #43

MINUS
    .FILL #45







.END

