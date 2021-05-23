// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

(INIT)
    @R2
    M = 0

    @R0
    D = M
    @arg_1
    M = D

    @R1
    D = M
    @arg_2
    M = D

    @counter
    M = 0

    @product
    M = 0

(ADD_ARG_2_TO_PRODUCT)
    @counter
    D=M
    @arg_1
    D = M - D

    @DONE
    D; JLE

    @arg_2
    D = M
    @product
    M = M + D

    @counter
    M = M + 1

    @ADD_ARG_2_TO_PRODUCT
    0;JMP

(DONE)
    @product
    D = M
    @R2
    M = D

(HALT)
    @HALT
    0;JMP
