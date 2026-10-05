.ORIG x3000

START
BR START

GETNUM
    ;Get first digit
    GETC
    ADD R1, R0, #0

    ;Turn ASCII into a number
    LD R2, fourtyEight
    ADD R1, R1, R2

    ;Get second digit
    GETC

    ;Turn ASCII into a number
    ADD R0, R0, R2

    ;Multiply first digit by 10 to take it to tens place
    ADD R2, R1, R1
    ADD R2, R2, R2
    ADD R2, R2, R2
    ADD R2, R2, R1
    ADD R2, R2, R1

    ;Add second digit
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

DISPLAY ;basically going to seperate thousands hundreds tens and ones by counting the number of itirations while subtracting 1000 100 10 and 1(dont need to) until the number turns negative

    ;Save the number
    ADD R1, R0, #0

    ;Check if negative
    ADD R1, R1, #0
    BRzp POSITIVE

    ;Print minus sign
    LD R0, MINUS
    OUT

    ;Make number positive
    NOT R1, R1
    ADD R1, R1, #1

    POSITIVE
        ;THOUSANDS -----------
        AND R2, R2, #0
        LD R3, NEG1000

        LOOP1000
            ADD R1, R1, R3
            BRn DONE1000

            ADD R2, R2, #1
            BR LOOP1000

        DONE1000
            LD R3, POS1000
            ADD R1, R1, R3

            LD R3, fourtyEight
            ADD R0, R2, R3
            OUT


        ;HUNDREDS ----------------
        AND R2, R2, #0
        LD R3, NEG100

        LOOP100
            ADD R1, R1, R3
            BRn DONE100

            ADD R2, R2, #1
            BR LOOP100

        DONE100
            LD R3, POS100
            ADD R1, R1, R3

            LD R3, fourtyEight
            ADD R0, R2, R3
            OUT


        ;TENS ------------------
        AND R2, R2, #0
        LD R3, NEG10

        LOOP10
            ADD R1, R1, R3
            BRn DONE10

            ADD R2, R2, #1
            BR LOOP10

        DONE10
            LD R3, POS10
            ADD R1, R1, R3

            LD R3, fourtyEight
            ADD R0, R2, R3
            OUT


        ;ONES ---------------------

        LD R3, fourtyEight
        ADD R0, R1, R3
        OUT

RET




fourtyEight
    .FILL #-48

PLUS
    .FILL #43

MINUS
    .FILL #45

NEG1000
    .FILL #-1000

POS1000
    .FILL #1000

NEG100
    .FILL #-100

POS100
    .FILL #100

NEG10
    .FILL #-10

POS10
    .FILL #10






.END

