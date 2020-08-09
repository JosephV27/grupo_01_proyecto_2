include c:\Irvine\Irvine32.inc
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

;x DWORD -714
;y DWORD 8161

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
xor eax, eax
xor ebx, ebx
xor ecx, ecx 
xor edx, edx


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
;-----------------move vars to registers
mov eax, abs_x
mov ebx, x
mov edx, y
;-----------------0 degrees
cmp ebx, 0 ; x > 0
JL P1
cmp edx, 0 ; y == 0
JNE P1
mov eax, 0
mov theta, eax
;-----------------First octant
P1:
	cmp eax, abs_y ; abs_x > abx_y
	JLE P2
	cmp ebx, 0 ; x > 0
	JL P2
	cmp edx, 0 ; y > 0
	JL P2
	mov eax, numerator
	mov ebx, denominatorI
	xor edx, edx
	idiv ebx
	mov theta, eax	
;-----------------45 degrees
P2:
	cmp eax, abs_y ; abx_x == abx_y
	JNE P3
	cmp ebx, 0 ; x > 0
	JL P3
	cmp edx, 0 ; y > 0
	JL P3
	mov eax, PI_CUARTOS
	mov theta, eax
;-----------------Second octant
P3:
	cmp eax, abs_y ; abs_x < abs_y
	JGE P4
	cmp ebx, 0 ; x > 0
	JLE P4
	cmp edx, 0 ; y > 0
	JLE P4
	mov eax, numerator
	mov ebx, denominatorQ
	xor edx, edx
	idiv ebx
	mov edx, PI_MEDIOS 
	sub edx, eax
	mov theta, edx
;-----------------90 Degrees
P4:
	cmp ebx, 0
	JNE P5
	cmp edx, 0 ; y > 0
	JL P5
	mov eax, PI_MEDIOS
	mov theta, eax
;-----------------Third octant
P5:
	cmp eax, abs_y ; abs_x < abs_y
	JGE P6
	cmp ebx, 0 ; x < 0
	JGE P6
	cmp edx, 0 ; y > 0
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
;-----------------135 Degrees
P6:
	cmp eax, abs_y ; abx_x == abx_y
	JNE P7
	cmp ebx, 0 ; x < 0
	JGE P7
	cmp edx, 0 ; y > 0
	JLE P7
	mov eax, TRES_PI_CUARTOS
	mov theta, eax
;-----------------Fourth octant
P7:
	cmp eax, abs_y ; abs_x > abx_y
	JLE P8
	cmp ebx, 0 ; x < 0
	JGE P8
	cmp edx, 0 ; y > 0
	JLE P8
	mov eax, numerator
	mov ebx, denominatorI
	xor edx, edx
	idiv ebx
	mov edx, PI
	add edx, eax
	mov theta, edx
;-----------------Fifth octant
P8:
	cmp eax, abs_y ; abs_x > abx_y
	JLE P9
	cmp ebx, 0 ; x < 0
	JGE P9
	cmp edx, 0 ; y < 0
	JGE P9
	mov eax, numerator
	mov ebx, denominatorI
	xor edx, edx
	idiv ebx
	mov edx, PI
	sub eax, edx ; revisar
	mov theta, eax
;----------------- -135 Degrees
P9:
	cmp eax, abs_y ; abx_x == abx_y
	JNE P10
	cmp ebx, 0 ; x < 0
	JGE P10
	cmp edx, 0 ; y < 0
	JGE P10
	mov eax, TRES_PI_CUARTOS
	neg eax
	mov theta, eax
;-----------------Sixth octant
P10:
	cmp eax, abs_y ; abs_x < abs_y
	JGE P11
	cmp ebx, 0 ; x < 0
	JGE P11
	cmp edx, 0 ; y < 0
	JGE P11
	mov eax, numerator
	mov ebx, denominatorQ
	xor edx, edx
	idiv ebx
	mov edx, PI_MEDIOS 
	neg edx
	sub edx, eax
	mov theta, edx
;----------------- -90 Degrees	
P11:
	cmp ebx, 0 ; x == 0
	JNE P12
	cmp edx, 0 ; y < 0
	JGE P12
	mov eax, PI_MEDIOS
	neg eax 
	mov theta, eax
;-----------------Seventh octant
P12:
	cmp eax, abs_y ; abs_x < abs_y
	JGE P13
	cmp ebx, 0 ; x > 0
	JLE P13
	cmp edx, 0 ; y < 0
	JGE P13
	mov eax, numerator
	mov ebx, denominatorQ
	xor edx, edx
	idiv ebx
	mov edx, PI_MEDIOS 
	neg edx
	sub edx, eax
	mov theta, edx
;----------------- -45 Degrees	
P13:
	cmp eax, abs_y ; abx_x == abx_y
	JNE P14
	cmp ebx, 0 ; x > 0
	JLE P14
	cmp edx, 0 ; y < 0
	JGE P14
	mov eax, PI_CUARTOS
	neg eax
	mov theta, eax
;-----------------eighth octant
P14:
	cmp eax, abs_y ; abs_x > abx_y
	JLE P15
	cmp ebx, 0 ; x > 0
	JLE P15
	cmp edx, 0 ; y < 0
	JGE P15
	mov eax, numerator
	mov ebx, denominatorI
	xor edx, edx
	idiv ebx
	mov theta, eax	
;-----------------180 Degrees
P15:
	cmp ebx, 0 ; x < 0
	JGE P16 
	cmp edx, 0 ; y == 0
	JNE P16
	mov eax, PI
	mov theta, eax

P16:
	NOP

ret
ac_atan2 ENDP
END 