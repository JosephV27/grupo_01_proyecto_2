include c:\Irvine\Irvine32.inc
include c:\Irvine\Macros.inc
includelib c:\Irvine\Irvine32.lib
includelib c:\Irvine\Kernel32.lib
includelib c:\Irvine\user32.lib
INCLUDE ac_atan2.inc
; ------------------------------------------------------
; Students: 
;				Joseph Valenciano
;				Erick Blanco 
;				Emmanuel Murillo 
;				Josue Chaves
; ------------------------------------------------------

TITLE Programa para leer y escribir archivos

BUFFER_SIZE = 1000
.data
buffer BYTE BUFFER_SIZE DUP(?)
filename BYTE "input_data.txt",0
fileHandle  HANDLE ?
x DWORD ?
y DWORD ?

outputFile DB "output_data.txt",0
out_FileHandle DD ?
number DWORD ?
numberBytes DD ?
numberstring db 16 DUP (0)
numberChar DD 0
fmt db "%d",0
counter DWORD 0
NewLine db " ",13,10,0
last_number db "0",0

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

;---------------------------- convert ascii to decimal

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
    je move_x

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
    je move_neg_x
    
    ;Convert from ASCII to decimal 
    sub esi, 48             
    imul eax, 10            
    add eax, esi            
    jmp convert_neg_x

move_x:
	mov x, eax ;move the coord to x
	jmp clear_y

move_neg_x:
    neg eax ; negative coord
	mov x, eax ;move the coord to x
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
    je move_y

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
    je move_neg_y
    
    ; Convert from ASCII to decimal 
    sub esi, 48              
    imul eax, 10            
    add eax, esi           
    jmp convert_neg_y

move_y:
    cmp ecx, 1 ;last y
    je last_num
    inc edi ; Get the next character
    mov y, eax ;mov the coord to y
    inc edi ; Get the next character
    INVOKE ac_atan2, x, y
    dec ecx
    jmp clear_x 

move_neg_y:
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
    jmp clear_x 

quit:
    NOP

ret
Read_Values ENDP

Write_Values PROC
push esi ;save array from ac_atan2
    
    ;create file
    lea edx, outputFile
    call CreateOutputFile
    mov out_FileHandle, eax

    ;clear the registers
    xor ecx, ecx
    xor edx, edx
    xor ebx, ebx
    mov ebx, 73 ;count

;loop to write numbers in file
loopArray:
    mov edx, counter
    mov eax, [esi+edx]
    add edx, 4
    mov counter, edx
    mov number, eax
    
    ;convert number to string
    push number                     ; Argument for format string
    push offset fmt                 ; Pointer to format string ("%d")
    push offset numberstring        ; Pointer to buffer for output
    call wsprintf                  
    call dumpregs
    mov numberChar, eax             ; Length of the stored string
    add esp, (3*4)  

    ;last_num verification
    cmp ebx, 1
    JE fin

    ;write the number into the file
    mov eax, out_FileHandle  
    lea edx, offset numberstring 
    mov ecx, 10
    call WriteToFile

    ;write the new line
    mov eax, out_FileHandle
    lea edx, NewLine
    mov ecx, 3
    call WriteToFile

fin:
    dec ebx
    cmp ebx, 0
    JNE loopArray

    ;write the last_num
    mov eax, FileHandle
    lea edx, last_number 
    mov ecx, 2
    call WriteToFile


;close file
mov eax, out_FileHandle
call CloseFile

xor ecx, ecx
pop esi

ret
Write_Values ENDP
end

END 



