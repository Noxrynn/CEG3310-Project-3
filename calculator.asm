.ORIG x3000

START
    JSR GETNUM
        ADD R1, R0, #0

        JSR GETOP
        ADD R2, R0, #0

        JSR GETNUM
        ADD R3, R0, #0

        JSR CALC

        JSR DISPLAY

        HALT

GETNUM
    ;Save registers because GETNUM uses them
    ST R7, SAVE_R7
    ST R1, SAVE_R1
    ST R2, SAVE_R2

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

    ;Multiply first digit by 10
    ADD R2, R1, R1
    ADD R2, R2, R2
    ADD R2, R2, R2
    ADD R2, R2, R1
    ADD R2, R2, R1

    ;Add second digit
    ADD R0, R2, R0

    ;Restore registers
    LD R1, SAVE_R1
    LD R2, SAVE_R2
    LD R7, SAVE_R7
RET

GETOP
    ST R7, SAVE_R7

    GETC ;because operation symbols dont need to be converted to text

    LD R7, SAVE_R7
    RET
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

    ST R7, SAVE_R7

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

            LD R3, posFortyEight
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

            LD R3, posFortyEight
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

            LD R3, posFortyEight
            ADD R0, R2, R3
            OUT


        ;ONES ---------------------

        LD R3, posFortyEight
        ADD R0, R1, R3
        OUT

    LD R7, SAVE_R7

RET

SAVE_R7
    .BLKW #1

SAVE_R1
    .BLKW #1

SAVE_R2
    .BLKW #1

fourtyEight
    .FILL #-48

posFortyEight
    .FILL #48

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

