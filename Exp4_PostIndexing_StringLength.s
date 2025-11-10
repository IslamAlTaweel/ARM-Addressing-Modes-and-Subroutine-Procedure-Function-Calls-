;  ARM Assembly Using Post-Indexing Addressing Mode

        PRESERVE8
        THUMB
        AREA  RESET, DATA, READONLY
        EXPORT __Vectors
__Vectors
        DCD 0x20001000 
        DCD Reset_Handler
        ALIGN
string1 DCB "Hello world!",0
    AREA    MYRAM, DATA, READWRITE 
SUM  DCD 0 
        AREA MYCODE, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler
Reset_Handler
    LDR   R0, = string1 ;Load the address of string1 R0 = 0x8
    MOV R1, #0   ; Initialize the counter for length of string1 
loopCount 
    LDRB R2, [R0], #1  ; Load the char from address in R0 
    CBZ R2, countDone   ; If it is zero... null terminated..
    ADD R1, #1          ; increment the counter for length 
    B loopCount 
countDone  B countDone 
    END

