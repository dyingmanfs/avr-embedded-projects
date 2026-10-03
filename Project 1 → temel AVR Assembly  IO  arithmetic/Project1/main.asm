.include "m128def.inc"     
.cseg                      
.org 0x00   
Start: 
 LDI R16, 0x00;
 LDI R17, 0xFF;
 OUT DDRD, R17;
 OUT DDRA, R16;
 OUT DDRB, R16;
 OUT DDRC, R16;

 IN R16, PINA; Load input from PORTA
 IN R17, PINB;Load input from PORTB
 IN R18, PINC; Operation selector

 CPI R18, 2;
 BREQ opSUB;
  CPI R18, 1;
 BREQ Addition;

   CPI R18, 3;
 BREQ Multiplication;

    CPI R18, 4;
 BREQ opDIV;

default:
 SBI PORTD, 0       ; Set error bit
RJMP Start ; Go back to the beginning if no operation matches

 opSUB:
 SUB R16,R17;
 STS 0x0121, R16;
 jmp Start;

 Addition:
 ADD R16, R17
 STS 0x0120, R16;
 jmp Start

 Multiplication:
 Mul R16, R17
 STS 0x123, R0 ; Store low byte
 STS  0x122 ,R1; Store high byte
 jmp Start;

 opDIV:
 LDI R19,0
 cp R16,R17
 BRCC L1 
 jmp diverror
L1:	
    INC	R19
	SUB	R16, R17
    BRCC L1			; branch if C is zero R16>R17
	Add R16, R17   
	DEC R19
    STS 0x124, R19    ; Store QUOTIENT
    STS 0x125, R16    ; Store REMAINDER
    RJMP Start
diverror:
    SBI PORTD, 0       ; Set error bit
    RJMP Start