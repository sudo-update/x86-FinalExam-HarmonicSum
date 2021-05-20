; Sean Javiya     ||     Section: 240-07     ||     seanjaviya@csu.fullerton.edu
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
extern printf
extern scanf
extern Fill
extern display_assembly_array
extern Harmonic_mean
global Control
segment .data
welcome db "Welcome to Harmonic Mean Calculator.", 10
        db "Note: An input of 0.0 will cause 0 to be returned,", 10
        db "      as this calculator cannot divide by 0.", 10, 0
confirm_before_display db "The numbers you entered are as follows:", 10, 0
goodbye db "The harmonic mean of these values is %8.16lf.", 10
        db "The control module will return the harmonic mean to the caller module.", 10, 0
string_format db "%s", 0
empty_array_error db "You have entered an empty array.", 10
                  db "There is no harmonic mean.", 10
                  db "The control module will return 0.0 to the caller module.", 10, 0
segment .bss
asssembly_array resq 100
segment .text
Control:
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;preserve the registers onto the stack
push rbp
mov  rbp,rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                                                                     BEGIN CODE
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
push qword 0
mov rdi, string_format                                                       ;%s
mov rsi, welcome                                           ;Welcome to SumArray.
call printf
pop rax
;------------------------------------------------------------------------------;
mov r13, 100                              ;r13 holds the max length of the array
mov rax, 0
mov rdi, asssembly_array   ;the first parameter is the starting address of array
mov rsi, r13                    ;second parameter is the max length of the array
call Fill
mov r15, rax                               ;r15 holds actual length of the array
;------------------------------------------------------------------------------;
mov r14, 0
cmp r15, r14                                        ;check if the array is empty
je empty_array                     ;if the array is empty, special case handling
;------------------------------------------------------------------------------;
push qword 0
push qword 0
mov rdi, string_format                                                       ;%s
mov rsi, confirm_before_display         ;The numbers you entered are as follows:
call printf
pop rax
pop rax
;------------------------------------------------------------------------------;
mov rax, 0
mov rdi, asssembly_array   ;the first parameter is the starting address of array
mov rsi, r15                 ;second parameter is the actual length of the array
call display_assembly_array
;------------------------------------------------------------------------------;
mov rax, 0
mov rdi, asssembly_array   ;the first parameter is the starting address of array
mov rsi, r15                 ;second parameter is the actual length of the array
call Harmonic_mean
movsd xmm15, xmm0                                ;xmm15 holds the calculated sum
;------------------------------------------------------------------------------;
mov rax, 1
movsd xmm0, xmm15
mov rdi, goodbye                              ;The sum of these values is %6.8lf
                   ;The control module will return the sum to the caller module.
call printf
;------------------------------------------------------------------------------;
movsd xmm0, xmm15                                     ;pepare sum to be returned
jmp restore_registers
;------------------------------------------------------------------------------;
;                            Special Case Handling
;------------------------------------------------------------------------------;
empty_array:    ;The program will arrive here if the user entered an empty array
push qword 0
push qword 0
mov rdi, string_format                                                       ;%s
mov rsi, empty_array_error                     ;You have entered an empty array.
                                       ;The sum of an empty array is 0.00000000.
                       ;The control module will return 0.0 to the caller module.
call printf
pop rax
pop rax
mov r14, 0
cvtsi2sd xmm0, r14                                     ;prepare 0 to be returned
jmp restore_registers
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                                                                       END CODE
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
restore_registers:
;restore the registers from the stack
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp
;------------------------------------------------------------------------------;
;return statement
ret
