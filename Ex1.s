;ARM Assembly Using Post-Indexing Addressing Mode
    PRESERVE8
    THUMB
    AREA  RESET, DATA, READONLY
    EXPORT __Vectors
__Vectors
    DCD 0x20001000 
    DCD Reset_Handler
    ALIGN
SUMP    DCD SUM 
N  DCD 5 
NUM1  DCD 3, -7, 2, -2, 10 
POINTER DCD NUM1 
    AREA    MYRAM, DATA, READWRITE 
SUM  DCD 0 
    AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler
Reset_Handler
    LDR R1, N           ; load size of array  = 5  
   LDR R2, POINTER      ; load base pointer of array  R2 = 0x00000010 
   MOV R0, #0           ; initialize accumulator 
LOOP   
    LDR R3, [R2], #4    ; load value, then increments to next word  
    ADD R0, R0, R3      ; add value from array to accumulator 
    SUBS R1, R1, #1     ; decrement work counter 
    BGT LOOP            ; keep looping until counter is zero 
    LDR R4, SUMP        ; memory address to store sum R4=0x20000000
    STR R0, [R4]        ; store answer  = 6
    LDR R6, [R4]        ; Check the value in the SUM = 6
STOP B STOP
    END

