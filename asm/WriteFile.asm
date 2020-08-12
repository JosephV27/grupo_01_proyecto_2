include c:\Irvine\Irvine32.inc
include c:\Irvine\Macros.inc
includelib c:\Irvine\Irvine32.lib
includelib c:\Irvine\Kernel32.lib
includelib c:\Irvine\user32.lib
INCLUDE atan2.inc

.data
fileName DB 'output_data.txt',0
FileHandle DD ?
number DWORD ?
numberBytes DD ?
numberstring db 16 DUP (0)
numberChar DD 0
fmt db "%d",0
counter DWORD 0
newLine byte "\r\n"

.code 
Write_Values PROC
push esi

    ;create file
    push NULL
    push FILE_ATTRIBUTE_NORMAL
    push CREATE_ALWAYS
    push NULL
    push 0
    push GENERIC_WRITE
    push offset fileName
    call CreateFileA
    mov FileHandle,eax

    xor ecx, ecx
    xor edx, edx
    xor ebx, ebx
    mov ebx, 73


loopArray:
    mov edx, counter
    mov eax, [esi+edx]
    add edx, 4
    mov counter, edx
    call WriteInt
    mov number, eax
    
     ;convert number to string
    push number                     ; Argument for format string
    push offset fmt                 ; Pointer to format string ("%d")
    push offset numberstring        ; Pointer to buffer for output
    call wsprintf                   ; Irvine32.inc / SmallWin.inc / User32.lib / User32.dll
    call dumpregs
    mov numberChar, eax             ; Length of the stored string
    add esp, (3*4)  ; CCALL calling function! Adjust the stack.

    ;write
    push NULL
    push offset numberBytes
    push numberChar
    push offset numberstring
    push FileHandle
    call WriteFile

    dec ebx
    cmp ebx, 0
    JNE loopArray

    pop esi

;close file
push FileHandle
call CloseHandle

ret
Write_Values ENDP
end