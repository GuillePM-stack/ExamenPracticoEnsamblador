TITLE Add and Subtract, Version 2         (AddSub2.asm)

; This program adds and subtracts 32-bit integers
; and stores the sum in a variable.

INCLUDE C:\irvine\Irvine32.inc
Include c:\irvine\Macros.inc
ShellExecuteA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
 

;--------Macros propias-------------

; 201 205 205 205 206 205 187
; 186                     186
; 186                     186
; 186                     186
; 200 205 205 205 206 205 188

mPrintChar MACRO car:REQ, num:REQ
	push eax
	push ecx

	mov ecx, num
	.Repeat
		mov al, car
		call WriteChar
		dec ecx
	.Until ecx < 1
	pop ecx
	pop eax
ENDM

mSetTextColor MACRO fondo, frente
	PUSHAD
	mov eax, fondo
	mov ebx, 16
	mul ebx
	add eax, frente
	call SetTextColor
	POPAD
ENDM

mPrintVertical MACRO X:REQ, Y:REQ, car:REQ, num:REQ
	push ecx
	mov ecx, Y
	.Repeat
		mGotoXY X, cl
		mPrintChar car, 1
		inc ecx
	.Until ecx == (Y + num)
	pop ecx
ENDM

mDrawSquareChar MACRO car, X1, Y1, X2, Y2
	mGotoXY X1, Y1
	mPrintChar car, (X2-X1)

	mGotoXY X1, Y2
	mPrintChar car, (X2-X1+1)

	mPrintVertical X1, Y1, car, Y2-Y1
	mPrintVertical X2, Y1, car, Y2-Y1
ENDM

mDrawSquare MACRO X1, Y1, X2, Y2
	mGotoXY X1, Y1
	mPrintChar 201, 1
	mPrintChar 205, (X2-X1-1)
	mPrintChar 187, 1

	mPrintVertical X1, Y1+1, 186, Y2-Y1
	mPrintVertical X2, Y1+1, 186, Y2-Y1

	mGotoXY X1, Y2
	mPrintChar 200, 1
	mPrintChar 205, (X2-X1-1)
	mPrintChar 188, 1

ENDM

.data
;Se pusieron varios tipos de aplicaciones (bloc de notas, calculadora, Microsoft Teams, un juego de Steam y el navegador brave)
opcion dword ?
operacion db "open",0
programa01 db "notepad",0
programa02 db "calc",0
programa03 db "ms-teams",0
programa04 db "steam://rungameid/250900",0
programa05 db "brave.exe",0



.code
main PROC
		
		mSetTextColor red, white
		call ClrScr

		mDrawSquare 10,4,70,9
		mDrawSquare 20,12,60,27

		mGotoXY 18,6
		mWriteln "Actividad Examen Práctico en Ensamblador"

		mGotoXY 25,14
		mWriteln "1. NotePad "

		mGotoXY 25,15
		mWriteln "2. Calculadora "

		mGotoXY 25,16
		mWriteln "3. Teams "

		mGotoXY 25,17
		mWriteln "4. The Binding of Isaac Rebirth "

		mGotoXY 25,18
		mWriteln "5. Brave "

		mGotoXY 25,19
		mWriteln "6. Exit "

menu:
		mGotoXY 25,21
		mWriteln "Selecciona la opcion deseada. [ ] "
		mGotoXY 25 + 31, 21 
		call ReadInt
		mov opcion, eax

		;Listado de condiciones para los programas a ejecutar

		.if opcion == 1
		Invoke ShellExecuteA,0,ADDR operacion, ADDR programa01,NULL,NULL, 1
		.elseif opcion == 2
		Invoke ShellExecuteA,0,ADDR operacion, ADDR programa02,NULL,NULL, 1
		.elseif opcion == 3
		Invoke ShellExecuteA,0,ADDR operacion, ADDR programa03,NULL,NULL, 1
		.elseif opcion == 4
		Invoke ShellExecuteA,0,ADDR operacion, ADDR programa04,NULL,NULL, 1
		.elseif opcion == 5
		Invoke ShellExecuteA,0,ADDR operacion, ADDR programa05,NULL,NULL, 1 
		.elseif opcion == 6
			exit
		.endif

		jmp menu


	mGotoXY 1,28
	call WaitMsg
	exit
main ENDP
END main