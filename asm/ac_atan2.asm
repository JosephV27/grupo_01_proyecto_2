include c:\Irvine\Irvine32.inc
include c:\Irvine\Macros.inc
includelib c:\Irvine\Irvine32.lib
includelib c:\Irvine\Kernel32.lib
includelib c:\Irvine\user32.lib
INCLUDE atan2.inc

.data
;constants
PI DWORD 102944
PI_MEDIOS DWORD 51472
PI_CUARTOS DWORD 25736
TRES_PI_CUARTOS DWORD 77208

arreglo DWORD 73 DUP(?)
count DWORD 4

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
ac_atan2 PROC, x:DWORD, y:DWORD
push esi
xor esi, esi
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
;-----------------0 degrees
mov eax, abs_x
cmp x, 0 ; x > 0
JL P1
cmp y, 0 ; y == 0
JNE P1
mov eax, 0
;mov theta, eax
mov esi, offset arreglo
mov [esi], eax
;mov eax, [esi]
;call writeint
;-----------------First octant
P1:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x > abx_y
	JLE P2
	cmp x, 0 ; x > 0
	JL P2
	cmp y, 0 ; y > 0
	JLE P2
	mov eax, numerator
	mov ebx, denominatorI
	xor edx, edx
	idiv ebx
	;mov theta, eax
	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------45 degrees
P2:
	mov eax, abs_x
	cmp eax, abs_y ; abx_x == abx_y
	JNE P3
	cmp x, 0 ; x > 0
	JL P3
	cmp y, 0 ; y > 0
	JL P3
	mov eax, PI_CUARTOS
	;mov theta, eax

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------Second octant
P3:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x < abs_y
	JGE P4
	cmp x, 0 ; x > 0
	JLE P4
	cmp y, 0 ; y > 0
	JLE P4
	mov eax, numerator
	mov ebx, denominatorQ
	xor edx, edx
	idiv ebx
	mov edx, PI_MEDIOS 
	sub edx, eax
	mov theta, edx
	mov eax, edx

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------90 Degrees
P4:
	mov eax, abs_x
	cmp x, 0 ;x==0
	JNE P5
	cmp y, 0 ; y > 0
	JL P5
	mov eax, PI_MEDIOS
	;mov theta, eax
	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------Third octant
P5:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x < abs_y
	JGE P6
	cmp x, 0 ; x < 0
	JGE P6
	cmp y, 0 ; y > 0
	JLE P6
	mov eax, numerator
	neg eax
	mov ebx, denominatorQ
	xor edx, edx
	idiv ebx
	neg eax
	mov edx, PI_MEDIOS 
	sub edx, eax
	mov theta, edx
	mov eax, edx

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------135 Degrees
P6:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x == abx_y
	JNE P7
	cmp x, 0 ; x < 0
	JGE P7
	cmp y, 0 ; y > 0
	JLE P7
	mov eax, TRES_PI_CUARTOS
	;mov theta, eax

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------Fourth octant
P7:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x > abx_y
	JLE P8
	cmp x, 0 ; x < 0
	JGE P8
	cmp y, 0 ; y > 0
	JLE P8
	mov eax, numerator
	neg eax
	mov ebx, denominatorI
	xor edx, edx
	idiv ebx
	neg eax
	mov edx, PI
	add edx, eax
	mov theta, edx
	mov eax, edx

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------Fifth octant
P8:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x > abx_y
	JLE P9
	cmp x, 0 ; x < 0
	JGE P9
	cmp y, 0 ; y < 0
	JGE P9
	mov eax, numerator
	mov ebx, denominatorI
	xor edx, edx
	idiv ebx
	mov edx, PI
	sub eax, edx
	;mov theta, eax

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;----------------- -135 Degrees
P9:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x == abx_y
	JNE P10
	cmp x, 0 ; x < 0
	JGE P10
	cmp y, 0 ; y < 0
	JGE P10
	mov eax, TRES_PI_CUARTOS
	neg eax
	;mov theta, eax

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------Sixth octant
P10:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x < abs_y
	JGE P11
	cmp x, 0 ; x < 0
	JGE P11
	cmp y, 0 ; y < 0
	JGE P11
	mov eax, numerator
	mov ebx, denominatorQ
	xor edx, edx
	idiv ebx
	mov edx, PI_MEDIOS 
	neg edx
	sub edx, eax
	mov theta, edx
	mov eax, edx

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;----------------- -90 Degrees	
P11:
	mov eax, abs_x
	cmp x, 0 ; x == 0
	JNE P12
	cmp y, 0 ; y < 0
	JGE P12
	mov eax, PI_MEDIOS
	neg eax 
	;mov theta, eax

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------Seventh octant
P12:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x < abs_y
	JGE P13
	cmp x, 0 ; x > 0
	JLE P13
	cmp y, 0 ; y < 0
	JGE P13
	mov eax, numerator
	neg eax
	mov ebx, denominatorQ
	xor edx, edx
	idiv ebx
	neg eax
	mov edx, PI_MEDIOS 
	neg edx
	sub edx, eax
	mov theta, edx
	mov eax, edx

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;----------------- -45 Degrees	
P13:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x == abx_y
	JNE P14
	cmp x, 0 ; x > 0
	JLE P14
	cmp y, 0 ; y < 0
	JGE P14
	mov eax, PI_CUARTOS
	neg eax
	;mov theta, eax

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------eighth octant
P14:
	mov eax, abs_x
	cmp eax, abs_y ; abs_x > abx_y
	JLE P15
	cmp x, 0 ; x > 0
	JLE P15
	cmp y, 0 ; y < 0
	JGE P15
	mov eax, numerator
	neg eax
	mov ebx, denominatorI
	xor edx, edx
	idiv ebx
	neg eax
	;mov theta, eax	

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint
;-----------------180 Degrees
P15:
	mov eax, abs_x
	cmp x, 0 ; x < 0
	JGE P16 
	cmp y, 0 ; y == 0
	JNE P16
	mov eax, PI
	;mov theta, eax

	mov esi, offset arreglo
	mov edx, count
	mov [esi+edx], eax
	;mov eax, [esi+edx]
	add edx, 4
	mov count, edx
	;call writeint

P16:
	NOP

cmp ecx, 1
jne P17

mov esi, offset arreglo
INVOKE Write_Values

pop esi
xor ecx, ecx

P17:
	NOP




ret
ac_atan2 ENDP
END 