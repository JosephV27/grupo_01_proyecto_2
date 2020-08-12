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
END include c:\Irvine\Irvine32.inc
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
x DWORD ?
y DWORD ?

.code
Read_Values PROC

;open the file
mov edx, OFFSET filename

;mov ecx, SIZEOF filename
CALL OpenInputFile
mov fileHandle, eax

;read the file into a buffer
mov edx,OFFSET buffer
mov ecx, BUFFER_SIZE
call ReadFromFile

;buffer_size_ok
 mov buffer[eax],0        ; insert null terminator

;close_file
mov eax,fileHandle
call CloseFile

;--------------------------------------------
xor eax, eax
xor ecx, ecx
xor esi, esi            ;clear the registers
xor ebx, ebx
xor edi, edi                                
;--------------------------------------------
mov ecx, 73 ;count

clear_x:
    cmp ecx, 0
    je quit
    xor eax, eax              ; Set 0 to initial
	xor esi, esi

convert_x:
    movzx esi, byte PTR buffer + [edi]   ; Get each character

    cmp esi, 45 ;Check for -
    je convert_neg_x

    cmp esi, 59       ; Check for ;
    je done_x

    ;Convert from ASCII to decimal 
    sub esi, 48             
    imul eax, 10            
    add eax, esi            
    inc edi       ; Get the next character
    jmp convert_x

convert_neg_x:
    inc edi ; Get the next character
    movzx esi, byte PTR buffer + [edi]   ; Get each character
    
    cmp esi, 59       ; Check for ;
    je done_neg_x
    
    ;Convert from ASCII to decimal 
    sub esi, 48             
    imul eax, 10            
    add eax, esi            
    jmp convert_neg_x

done_x:
	mov x, eax ;move the coord to x
	;Call writeint
	jmp clear_y

done_neg_x:
    neg eax ; negative coord
	mov x, eax ;move the coord to x
	;Call writeint
	jmp clear_y

clear_y:
    inc edi ; Get the next character
	xor esi, esi
	xor eax, eax 

convert_y:
    movzx esi, byte PTR buffer + [edi]   ; Get each character
    cmp esi, 45 ;check for -
    je convert_neg_y

    cmp esi, 13        ; Check for car return
    je done_y

    ; Convert from ASCII to decimal 
    sub esi, 48             
    imul eax, 10            
    add eax, esi            
    inc edi                 ; Get the next character
    jmp convert_y

convert_neg_y:
    inc edi ;inc string
    movzx esi, byte PTR buffer + [edi]   ; Get each character

    cmp esi, 13        ; Check for car return
    je done_neg_y
    
    ; Convert from ASCII to decimal 
    sub esi, 48              
    imul eax, 10            
    add eax, esi           
    jmp convert_neg_y

done_y:
    cmp ecx, 1 ;last y
    je last_num
    inc edi ; Get the next character
    mov y, eax ;mov the coord to y
    inc edi ; Get the next character
    INVOKE ac_atan2, x, y
    dec ecx
    jmp clear_x 

done_neg_y:
    inc edi  ; Get the next character
    neg eax  ;-y
    mov y, eax ;mov the coord to y
    inc edi
    INVOKE ac_atan2, x, y
    dec ecx  ; Get the next character
    jmp clear_x 

last_num:
    mov eax, 0
    mov y, eax
   INVOKE ac_atan2, x, y
   ;dec ecx
    jmp clear_x 


quit:
    NOP

ret
Read_Values ENDP
END 
