include c:\Irvine\Irvine32.inc
include c:\Irvine\Macros.inc
includelib c:\Irvine\Irvine32.lib
includelib c:\Irvine\Kernel32.lib
includelib c:\Irvine\user32.lib
INCLUDE atan2.inc

BUFFER_SIZE = 1000
.data
buffer BYTE BUFFER_SIZE DUP(?)
filename BYTE "C:\Users\Joseph16\Desktop\input_data.txt"
fileHandle  HANDLE ?

.code
ReadFile PROC
;open the file
mov edx, OFFSET filename
mov ecx, SIZEOF filename
CALL OpenInputFile
mov fileHandle, eax

;read the file into a buffer
mov edx,OFFSET buffer
mov ecx, BUFFER_SIZE
call ReadFromFile

;buf_size_ok
 mov buffer[eax],0        ; insert null terminator

; Display the buffer.
    mov edx, OFFSET buffer    ; display the buffer
    call WriteString
    call Crlf

;close_file
mov eax,fileHandle
call CloseFile

ReadFile ENDP
END 