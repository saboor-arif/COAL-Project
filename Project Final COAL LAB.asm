.model small
.stack 100h
.data
    msg db "Hello$"
    newline db 13, 10, "$"
    delay_var dw 10
.code
main proc 
    mov ax, @data          ; Load address of data segment into AX
    mov ds, ax             ; Initialize DS with data segment address
    
    mov cx, 10             ; CX = number of animation lines to print
    mov bl, 0              ; BL = number of spaces before HELLO (starts from 0)
             
print_Loop:

    mov bh, bl             ; Copy BL into BH to use as space counter

space_Loop:
    cmp bh, 0              ; Check if all required spaces are printed
    je print_bracket       ; If yes, go to printing [HELLO]

    mov dl, " "            ; Load a space character into DL
    mov ah, 02h            ; DOS function to display a character
    int 21h                ; Print space on screen

    dec bh                 ; Decrease space counter
    jmp space_Loop         ; Repeat space printing
    
print_bracket:
    mov dl, "["            ; Load '[' character
    mov ah, 02h
    int 21h                ; Print '['
    
    lea dx, msg            ; Load address of "Hello$"
    mov ah, 09h            ; DOS function to print string
    int 21h                ; Print Hello
    
    mov dl, "]"            ; Load ']' character
    mov ah, 02h
    int 21h                ; Print ']'
    
    mov ah, 09h
    lea dx, newline        ; Load newline characters (CR/LF)
    int 21h                ; Move to next line
    
    inc bl                 ; Increase number of spaces for next animation line

delay: 
     mov dx, delay_var     ; Load delay counter into DX
delay_loop:
     dec dx                ; Decrease delay value
     jnz delay_loop        ; Keep looping until DX becomes zero
   
    loop print_Loop        ; Decrease CX and repeat animation loop
    
    mov ah, 4Ch            ; DOS terminate program function
    int 21h                ; Exit program
    
main endp
end main  