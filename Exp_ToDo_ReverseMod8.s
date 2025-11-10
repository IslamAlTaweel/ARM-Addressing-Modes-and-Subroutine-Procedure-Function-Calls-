;ARM Assembly Language Code implementing the ToDo Task

      PRESERVE8 
       THUMB
        AREA  RESET, DATA, READONLY
        EXPORT __Vectors

__Vectors
        DCD 0x20001000         ; Initial stack pointer
        DCD Reset_Handler      ; Reset handler address
        ALIGN

arr     DCD 11, 15, 17, 19, 20 ; Input array
N       DCB 5                  ; Number of elements

        AREA MYDATA, DATA, READWRITE
rev_arr SPACE 5                ; Output array (byte-sized)

        AREA MYCODE, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler

; Reverse array with MOD_8 operation on each element
REVERSE PROC
        PUSH {LR}              ; Save return address

ARR_LOOP
        CBZ R1, STORE_LOOP     ; If R1 == 0, done reading
        LDR R5, [R0], #4       ; Load next element, post-increment
        BL MOD_8               ; Modify value (MOD_8 or MOD_4)
        PUSH {R5}              ; Push modified value to stack
        SUB R1, R1, #1         ; Decrement loop counter
        B ARR_LOOP

STORE_LOOP
        CBZ R2, EXIT           ; If R2 == 0, done storing
        POP {R5}               ; Pop from stack (reversed order)
        STRB R5, [R3], #1      ; Store byte to rev_arr
        SUB R2, R2, #1         ; Decrement store counter
        B STORE_LOOP

EXIT
        POP {PC}               ; Return from REVERSE
        ENDP

; Apply MOD 8 (AND with 7)
MOD_8 PROC
        PUSH {LR}
        AND R5, R5, #7         ; R5 = R5 % 8
        POP {PC}
        ENDP

; Program entry point
Reset_Handler
        LDR R0, =arr           ; R0 = address of arr
        LDR R1, =N             
        LDRB R1, [R1]          ; R1 = N (number of elements)
        MOV R2, R1             ; R2 = copy of N for store loop
        LDR R3, =rev_arr       ; R3 = destination buffer
        BL REVERSE             ; Call reverse function

STOP    B STOP                 ; Infinite loop after finish
        END          ; Infinite loop to end program
