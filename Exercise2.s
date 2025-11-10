;Solution to Experiment 5,  Exercise 2 in ARM Assembly

        PRESERVE8
        THUMB
        AREA RESET, DATA, READONLY
        EXPORT __Vectors
__Vectors
        DCD     0x20001000          ; Initial Stack Pointer
        DCD     Reset_Handler       ; Reset Handler
        ALIGN
N           DCD     5               ; Number to compute factorial

        AREA MYDATA, DATA, READWRITE
RESULT      DCD     0               ; Memory location to store result

        AREA MYCODE, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler
        EXPORT Factorial


Factorial PROC
        PUSH    {LR}            ; Save return address
        MOV     R0, #1         
Loop
        CMP     R1, #1          ; If R1 <= 1, exit loop
        BLT     Done
        MUL     R0, R0, R1      ; R0 = R0 * R1
        SUB     R1, R1, #1     
        B       Loop
Done
        POP     {PC}            ; Return
        ENDP


Reset_Handler
        LDR     R1,=N         
        LDR     R1, [R1]        ; Load value into R1
        BL      Factorial       ; Call Factorial
        LDR     R3, =RESULT    
        STR     R0, [R3]        ; Store result
STOP
        B       STOP            ; Infinite loop
        END
