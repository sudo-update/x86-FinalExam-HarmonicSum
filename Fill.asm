;name stuff here
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
extern scanf
extern printf
extern isfloat
extern atof

global Fill
segment .data
prompt_for_values db "Please enter the values of the array as floating point", 10
                  db "numbers seperated by whitespace.", 10
                  db "When finished, press <Enter> followed by <Ctrl-D>.", 10, 0
float_format db "%lf", 0
string_format db "%s", 0
segment .bss
segment .text
Fill:
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
;parameters: address of the array to Fill, maximum length of array to fill
mov r15, rdi                            ;r15 holds starting address of the array
mov r13, rsi                              ;r13 holds the max length of the array
sub rsp, 24
mov rdi, string_format                                                       ;%s
mov rsi, prompt_for_values;Please enter the values of the array as floating point
                                               ;numbers seperated by whitespace.
                             ;When finished, press <Enter> followed by <Ctrl-D>.
call printf
add rsp, 24
mov r14, 0                                ;r14 is the counter index for our loop
;------------------------------------------------------------------------------;
beginloop:
sub rsp, 1536
mov rax, 0
mov rdi, string_format ;%s
mov rsi, rsp
call scanf
mov r12, [rsp]  ;preserve the data

cdqe
cmp rax, -1
je endloopbyCTRLD                                ;if Ctrl-D was input, jump out of loop

;check if value on stack is a float
mov rdi, rsp
call isfloat
mov r12, 0
cmp rax, r12
;if value is not a float, jump to invalid_inputs_detected
je invalid_inputs_detected
;else continue. convert string to float and preserve the valid coefficient c
mov rax, 1
mov rdi, rsp
call atof
movsd xmm13, xmm0                   ;xmm13 holds float
add rsp, 1536

; ;movsd xmm0, [rsp]                    ;store (scanned) value from stack into xmm0
movsd [r15 + 8*r14], xmm13
          ;insert xmm13 into 8*counterindex past the starting address of our array
inc r14                                             ;increment our counter index
cmp r14, r13             ;compare our counter index to the max size of the array
je endloop          ;if we have filled every slot in the array, jump out of loop
jmp beginloop
;------------------------------------------------------------------------------;
invalid_inputs_detected:
add rsp, 1536
jmp beginloop
endloop:
;pop rax
;pop rax
mov rax, r14                                       ;prepare for return statement
;return: number of values Filled into the given array (counter index)
jmp restore_registers
endloopbyCTRLD:
add rsp, 1536
;pop rax
;pop rax
mov rax, r14
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
