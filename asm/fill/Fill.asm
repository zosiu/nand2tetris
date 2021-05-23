// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(INIT)
    @screen_color
    M = 0

    @8192
    D = A
    @num_of_pixels
    M = D

(MAIN_LOOP)
    @KBD
    D = M

    @BLACK_SCREEN
    D; JGT

    @WHITE_SCREEN
    0; JMP

(WHITE_SCREEN)
    @screen_color
    M = 0
    @FILL_SCREEN
    0; JMP

(BLACK_SCREEN)
    @screen_color
    M = -1
    @FILL_SCREEN
    0; JMP

(FILL_SCREEN)
    @i
    M = 0

    @SCREEN
    D = A
    @pixel
    M = D

    (FILL)
        @i
        D = M
        @num_of_pixels
        D = D - M
        @FILL_DONE
        D; JGE

        @screen_color
        D = M
        @pixel
        A = M
        M = D

        @i
        M = M + 1

        @pixel
        M = M + 1

        @FILL
        0; JMP

    (FILL_DONE)
        @MAIN_LOOP
        0; JMP
