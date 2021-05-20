;name stuff here
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
global Harmonic_mean
segment .data
segment .bss
segment .text
Harmonic_mean:
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
;parameters: an array of doubles and the length of said array (as a long)
                                                        ;preserve the parameters
mov r15, rdi                            ;r15 holds starting address of the array
mov r14, rsi                                 ;r14 holds the length of said array
mov r13, 0                                ;r13 is the counter index for the loop
mov rax, 0                                                  ;initialize sum to 0
cvtsi2sd xmm15, rax                               ;prepare xmm15 for holding sum of reciprocals
mov rax, 1
cvtsi2sd xmm13, rax   ;holds 1 and behaves like our constant of 1
mov rax, 0
;------------------------------------------------------------------------------;
beginloop:
movsd xmm14, [r15 + 8*r13]
movsd xmm12, xmm13 ; copy constant 1 into xmm12
divsd xmm12, xmm14 ; div 1/xmm14 and store into xmm12
addsd xmm15, xmm12 ; add reciprocal to sum of reciprocals
;take the value located at (8 * counter index past the starting address of)
;our array and add the reciprocal to the sum of reciprocals.
inc r13                                             ;increment our counter index
cmp r13, r14                       ;compare counter index to length of the array
je endloop                  ;if we have summed the whole array, jump out of loop
jmp beginloop                                                     ;else continue
;------------------------------------------------------------------------------;
endloop:
;movsd xmm0, xmm15                                  ;prepare for return statement
;return: the sum of all the elements in the given array

;new stuff
;xmm15 holds sum of reciprocals of our array
;r14 holds the number of values
cvtsi2sd xmm12,r14 ; xmm12 holds number of vaules
divsd xmm12, xmm15
movsd xmm0, xmm12 ; prepare to return the harmonic mean

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
