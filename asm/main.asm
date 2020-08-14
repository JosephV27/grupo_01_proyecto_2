include c:\Irvine\Irvine32.inc
include c:\Irvine\Macros.inc
includelib c:\Irvine\Irvine32.lib
includelib c:\Irvine\Kernel32.lib
includelib c:\Irvine\user32.lib
include ac_atan2.inc
; ------------------------------------------------------
; Students: 
;				Joseph Valenciano
;				Erick Blanco 
;				Emmanuel Murillo 
;				Josue Chaves
; ------------------------------------------------------

TITLE Programa principal

.data

.code 
main PROC 
xor eax, eax
xor ebx, ebx
xor ecx, ecx 
xor edx, edx


INVOKE Read_Values
INVOKE ExitProcess, 0

main ENDP 
END main 