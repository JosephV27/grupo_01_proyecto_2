include c:\Irvine\Irvine32.inc
includelib c:\Irvine\Irvine32.lib
includelib c:\Irvine\Kernel32.lib
includelib c:\Irvine\user32.lib
include atan2.inc

.data
x DWORD ?
y DWORD ?

.code 
main PROC 
xor eax, eax
xor ebx, ebx
xor ecx, ecx 
xor edx, edx

mov eax, -1423
mov x, eax
mov ebx, 8068
mov y, ebx

INVOKE ac_atan2, x, y
INVOKE ExitProcess, 0

main ENDP 
END main 