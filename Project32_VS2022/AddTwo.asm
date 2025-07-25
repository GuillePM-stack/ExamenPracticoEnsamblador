TITLE Add and Subtract, Version 2         (AddSub2.asm)

; This program adds and subtracts 32-bit integers
; and stores the sum in a variable.

INCLUDE C:\irvine\Irvine32.inc

.data
val1     dword  10000h
val2     dword  40000h
val3     dword  20000h
finalVal dword  ?

.code
main proc

	mov eax, 5
	add eax, 6

	mov	eax,val1			; start with 10000h
	add	eax,val2			; add 40000h
	sub	eax,val3			; subtract 20000h
	mov	finalVal,eax		; store the result (30000h)
	call	DumpRegs			; display the registers

	exit
	;invoke ExitProcess,0
main endp
end main