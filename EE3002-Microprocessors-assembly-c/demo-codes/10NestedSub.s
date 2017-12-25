ram_base EQU 0x40000000
			AREA NestedSub, CODE, READONLY
			ENTRY
main		;compute (x^3 + 1)^4
			LDR sp, =ram_base + 0x100
			MOV r0, #2	;x=2
			BL  func1	;call subroutine func1
stop		B   stop	;return from func1
func1		;computer (func2+1)^4
			STMFD sp!, {lr}	;PUSH lr to stack
			BL	func2		;call subroutine fun
			ADD r2, r2, #1	;return from func2, r2=func2+1
			MUL r3, r2, r2	
			MUL r2, r3, r3	;r2=(func2+1)^4
			LDMFD sp!, {pc}	;return to main	by POP to pc
func2		;computer x^3
			MUL r1, r0, r0	
			MUL r2, r1, r0	;r2=x^3
			MOV pc, lr		;return to func1
			END