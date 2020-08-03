include c:\Irvine\Irvine32.inc
includelib c:\Irvine\Irvine32.lib
includelib c:\Irvine\Kernel32.lib
includelib c:\Irvine\user32.lib

.data
;constants
PI DWORD 102944
PI_MEDIO DWORD 51472
PI_CUARTOS DWORD 25736
TRES_PI_CUARTOS DWORD 77208

x DWORD 8161
y DWORD 714

numerator DWORD ?
y_square DWORD ?
x_square DWORD ?

op1 DWORD ?
op2 DWORD ?
op3 DWORD ?
op4 DWORD ?

op_denoI DWORD ?
op_denoQ DWORD ?

denominatorI DWORD ?
denominatorQ DWORD ?

abs_x DWORD ?
abs_y DWORD ?

theta DWORD ?
octant DWORD ?


.code 
ac_atan2 PROC 
xor eax, eax
xor ebx, ebx
xor ecx, ecx 
xor edx, edx
call DumpRegs

;-------------numerator
mov eax, x
mov ebx, y
imul ebx
mov numerator, eax
;--------------y_square
mov eax, y
mov ebx, y
imul ebx
mov y_square, eax
;--------------x_square
mov eax, x
mov ebx, x
imul ebx
mov x_square, eax
;--------------op1
mov eax, y_square
SHR eax, 2
mov op1, eax
;--------------op2
mov eax, y_square
SHR eax, 5
mov op2, eax
;--------------op3
mov eax, x_square
SHR eax, 2
mov op3, eax
;--------------op4
mov eax, x_square
SHR eax, 5
mov op4, eax
;--------------op_denoI
mov eax, x_square 
add eax, op1 
add eax, op2 
mov op_denoI, eax
;--------------op_denoQ
mov eax, y_square 
add eax, op3 
add eax, op4 
mov op_denoQ, eax
;---------------denominatorI
mov eax, op_denoI
SHR eax, 15
mov denominatorI, eax
;---------------denominatorQ
mov eax, op_denoQ
SHR eax, 15
mov denominatorQ, eax
;-----------------abs_x
mov eax, x
cmp eax, 0
JNS L2 ;check if the sign flag is not active
L1: 
	neg eax
	mov abs_x, eax
L2: 
	mov abs_x, eax
;-----------------abs_y
mov eax, y
cmp eax, 0
JNS L4 ;check if the sign flag is not active
L3: 
	neg eax
	mov abs_y, eax
L4: 
	mov abs_y, eax
;-----------------first octant
mov eax, abs_x
mov ebx, x
mov edx, y
.IF (eax > abs_y) && (ebx > 0) && (edx > 0)
	mov eax, numerator
	mov ebx, denominatorI
	idiv ebx
	mov theta, eax	
.ENDIF

ret
ac_atan2 ENDP
END ac_atan2 