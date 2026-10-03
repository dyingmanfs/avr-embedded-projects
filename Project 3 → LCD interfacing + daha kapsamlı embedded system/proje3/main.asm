.INCLUDE "M128DEF.INC"
.CSEG
.ORG 0x0000
JMP M                         ; Jump to main program

.ORG 0x002	; External INT0
JMP EX0_ISR                   ; INT0 interrupt vector
.ORG 0x004
JMP EX0_ISR                   ; Redundant INT0 vector (safety)

; ------------------ Stack and Initial Setup ------------------
M:
LDI R20, HIGH(RAMEND)         ; Load high byte of stack pointer
OUT SPH, R20
LDI R20, LOW(RAMEND)          ; Load low byte of stack pointer
OUT SPL, R20

; ------------------ Port Direction Settings ------------------
SBI DDRB, 3                   ; PC0 as output
SBI DDRB, 4                   ; PC1 as output
SBI DDRB, 5                   ; PC2 as output
SBI DDRB, 6                   ; PC1 as output
SBI DDRB, 7                   ; PC2 as output
SBI DDRD, 0                   ; PD0 as output
SBI DDRD, 1                   ; PD1 as output
SBI DDRB, 0                   ; PB0 as output
SBI DDRB, 1                   ; PB1 as output
SBI DDRB, 2                   ; PB2 as output
SBI DDRA, 0                   ; PA0 as output
SBI DDRA, 1                   ; PA1 as output
SBI DDRA, 2                   ; PA2 as output
SBI DDRA, 3                   ; PA3 as output
SBI DDRA, 4                   ; PA4 as output
SBI DDRA, 5                   ; PA5 as output
SBI DDRA, 7                   ; PA5 as output
LDI R21,0xFF
OUT DDRC, R21
LDI R20, 0xFF
OUT DDRE, R20                 ; Port E as output for 7-segment display

; ------------------ Main Loop ------------------
BEGIN:
SBI PORTD, 0                  ; INT0 initially inactive
SBI PORTD, 1                  ; INT0 initially inactive

LDI R20, 0x00
OUT EIMSK, R20                ; Disable INT0 initially

SEI                           ; Enable global interrupts



Scenario1:
    ; LCD 4-bit modda baþlatýlýyor
    LDI R16, 0x33
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x32
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x28
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x0E
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x01
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x06
    CALL CMNDWRT
	CALL DELAY_100us

; 1. Satýr
LDI R16, 'W'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, '/'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'A'
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, ' '
CALL DATAWRT
LDI R16, 'G'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT

; 2. Satýra Geç
LDI R16, 0xC0
CALL CMNDWRT

; 2. Satýr
LDI R16, 'N'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT
LDI R16, 'R'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, 'H'
CALL DATAWRT
LDI R16, '1'
CALL DATAWRT
LDI R16, '/'
CALL DATAWRT
LDI R16, '2'
CALL DATAWRT
LDI R16, ' '
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT
LDI R16, 'P'
CALL DATAWRT



    SBI PORTB, 2
    SBI PORTB, 5
    SBI PORTA, 2
    SBI PORTA, 5
    CALL DELAY_15s
    CBI PORTB, 2
    CBI PORTB, 5
    CBI PORTA, 2
    CBI PORTA, 5


Scenario2:
    LDI R16, 0x33
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x32
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x28
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x0E
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x01
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x06
    CALL CMNDWRT
	CALL DELAY_100us
; 1. Satýr
LDI R16, 'W'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, '/'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'A'
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, ' '
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'L'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT
LDI R16, 'W'
CALL DATAWRT

; 2. Satýra Geç
LDI R16, 0xC0
CALL CMNDWRT

; 2. Satýr
LDI R16, 'N'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT
LDI R16, 'R'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, 'H'
CALL DATAWRT
LDI R16, '1'
CALL DATAWRT
LDI R16, '/'
CALL DATAWRT
LDI R16, '2'
CALL DATAWRT
LDI R16, ' '
CALL DATAWRT
LDI R16, 'R'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'A'
CALL DATAWRT
LDI R16, 'D'
CALL DATAWRT
LDI R16, 'Y'
CALL DATAWRT

    SBI PORTB, 1
    SBI PORTB, 4
    SBI PORTA, 1
    SBI PORTA, 4
    CALL DELAY_3s
    CBI PORTB, 1
    CBI PORTB, 4
    CBI PORTA, 1
    CBI PORTA, 4
	
Scenario3:
    LDI R16, 0x33
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x32
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x28
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x0E
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x01
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x06
    CALL CMNDWRT
	CALL DELAY_100us
; 1. Satýr
LDI R16, 'W'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, '/'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'A'
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, ' '
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT
LDI R16, 'P'
CALL DATAWRT

; 2. Satýra Geç
LDI R16, 0xC0
CALL CMNDWRT

; 2. Satýr
LDI R16, 'N'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT
LDI R16, 'R'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, 'H'
CALL DATAWRT
LDI R16, '1'
CALL DATAWRT
LDI R16, '/'
CALL DATAWRT
LDI R16, '2'
CALL DATAWRT
LDI R16, ' '
CALL DATAWRT
LDI R16, 'G'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT

    LDI R20, (1 << INT0)| (1<<INT1)
    OUT EIMSK, R20            ; Enable INT0

    SBI PORTB, 0
    SBI PORTB, 3
    SBI PORTA, 0
    SBI PORTA, 3
    CALL DELAY_15s
    CBI PORTB, 0
    CBI PORTB, 3
    CBI PORTA, 0
    CBI PORTA, 3

    LDI R20, 0x00
    OUT EIMSK, R20            ; Disable INT0 again

Scenario4:
    LDI R16, 0x33
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x32
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x28
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x0E
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x01
    CALL CMNDWRT
	CALL DELAY_100us
    LDI R16, 0x06
    CALL CMNDWRT
	CALL DELAY_100us
; 1. Satýr
LDI R16, 'W'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, '/'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'A'
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, ' '
LDI R16, ' '
CALL DATAWRT
LDI R16, 'R'
CALL DATAWRT
LDI R16, 'E'
CALL DATAWRT
LDI R16, 'A'
CALL DATAWRT
LDI R16, 'D'
CALL DATAWRT
LDI R16, 'Y'
CALL DATAWRT

; 2. Satýra Geç
LDI R16, 0xC0
CALL CMNDWRT

; 2. Satýr
LDI R16, 'N'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT
LDI R16, 'R'
CALL DATAWRT
LDI R16, 'T'
CALL DATAWRT
LDI R16, 'H'
CALL DATAWRT
LDI R16, '1'
CALL DATAWRT
LDI R16, '/'
CALL DATAWRT
LDI R16, '2'
CALL DATAWRT
LDI R16, ' '
CALL DATAWRT
LDI R16, 'S'
CALL DATAWRT
LDI R16, 'L'
CALL DATAWRT
LDI R16, 'O'
CALL DATAWRT
LDI R16, 'W'
CALL DATAWRT


    SBI PORTB, 1
    SBI PORTB, 4
    SBI PORTA, 1
    SBI PORTA, 4
    CALL DELAY_3s
    CBI PORTB, 1
    CBI PORTB, 4
    CBI PORTA, 1
    CBI PORTA, 4

JMP BEGIN                     ; Infinite loop

; ------------------ Delay Functions ------------------

; 15-second delay
DELAY_15s:
    LDI R18, 60
DELAY_LOOP:
    CALL DELAY_250ms
    DEC R18
    BRNE DELAY_LOOP
    RET

; 3-second delay
DELAY_3s:
    LDI R18, 12
DELAY_LOOP2:
    CALL DELAY_250ms
    DEC R18
    BRNE DELAY_LOOP2
    RET

; 250ms delay using Timer1 CTC Mode
DELAY_250ms:
    LDI R20, HIGH(244)
    OUT OCR1AH, R20
    LDI R20, LOW(244)
    OUT OCR1AL, R20

    LDI R20, 0x00             ; Reset Timer1 count
    OUT TCNT1H, R20
    OUT TCNT1L, R20

    LDI R20, 0x00
    OUT TCCR1A, R20
    LDI R20, (1<<WGM12)|(1<<CS12)|(1<<CS10) ; CTC Mode, Prescaler 1024
    OUT TCCR1B, R20

WAIT_CTC:
    IN R20, TIFR
    SBRS R20, OCF1A           ; Wait for compare match
    JMP WAIT_CTC

    LDI R20, (1<<OCF1A)       ; Clear compare flag
    OUT TIFR, R20

    LDI R20, 0x00             ; Stop Timer1
    OUT TCCR1B, R20
    OUT TCCR1A, R20
    RET
	CMNDWRT:
    MOV R27,R16
    ANDI R27,0xF0
    OUT PORTC,R27           ; Send high nibble
    CBI PORTA,7             ; RS = 0
    CBI PORTB,7             ; RW = 0
    SBI PORTB,6          ; EN = 1
	CALL SDELAY
    CBI PORTB,6             ; EN = 0
	CALL DELAY_100us

    MOV R27,R16
    SWAP R27
    ANDI R27,0xF0
    OUT PORTC,R27           ; Send low nibble
    SBI PORTB,6             ; EN = 1
	CALL SDELAY
    CBI PORTB,6             ; EN = 0
	CALL DELAY_100us
    RET
	DATAWRT:
    MOV R27,R16
    ANDI R27,0xF0
    OUT PORTC,R27           ; Send high nibble
    SBI PORTA,7             ; RS = 1
    CBI PORTB,7             ; RW = 0
    SBI PORTB,6            ; EN = 1
	CALL SDELAY
    CBI PORTB,6            ; EN = 0
		CALL DELAY_100us
    MOV R27,R16
    SWAP R27
    ANDI R27,0xF0
    OUT PORTC,R27           ; Send low nibble
    SBI PORTB,6             ; EN = 1
    CALL DELAY_1s
		CALL SDELAY
    CBI PORTB,6             ; EN = 0
	Call DELAY_100us
	 CBI PORTA,7 
    RET
DELAY_2ms:
    PUSH R17
    LDI R17, 20
LDR0:
    CALL DELAY_100us
    DEC R17
    BRNE LDR0
    POP R17
    RET

DELAY_100us:
    PUSH R17
    LDI R17, 60
DR0:
    CALL SDELAY
    DEC R17
    BRNE DR0
    POP R17
    RET
	SDELAY:
	NOP
	NOP
	RET

; ------------------ External Interrupt (INT0) ISR ------------------

EX0_ISR:

	LDI R16, HIGH(RAMEND) 
    OUT SPH, R16 
    LDI R16, LOW(RAMEND) 
    OUT SPL, R16 

    ; Blink green lights (PA0, PA3) 3 times
    CBI PORTA, 3
    CBI PORTA, 0
    CALL A
    SBI PORTA, 3
    SBI PORTA, 0
    CALL A
    CBI PORTA, 3
    CBI PORTA, 0
    CALL A
    SBI PORTA, 3
    SBI PORTA, 0
    CALL A
    CBI PORTA, 3
    CBI PORTA, 0
    SBI PORTA, 3
    SBI PORTA, 0
    CBI PORTA, 3
    CBI PORTA, 0

    ; Activate red lights (PA2, PA5)
    SBI PORTA, 2
    SBI PORTA, 5

    ; 7-segment countdown
    LDI R20, 0xFF
    OUT DDRE, R20
    LDI R20, 0x67
    OUT PORTE, R20
    CALL DELAY_1s
    LDI R20, 0xFF
    OUT PORTE, R20
    CALL DELAY_1s
    LDI R20, 0x07
    OUT PORTE, R20
    CALL DELAY_1s
    LDI R20, 0x7C
    OUT PORTE, R20
    CALL DELAY_1s
    LDI R20, 0x6D
    OUT PORTE, R20
    CALL DELAY_1s
    LDI R20, 0x66
    OUT PORTE, R20
    CALL DELAY_1s
    LDI R20, 0x4F
    OUT PORTE, R20
    CALL DELAY_1s
    LDI R20, 0x5B
    OUT PORTE, R20
    CALL DELAY_1s
    LDI R20, 0x06
    OUT PORTE, R20
    CALL DELAY_1s
    LDI R20,  0x3F
    OUT PORTE, R20
    CALL DELAY_1s

    LDI R20, 0x00
    OUT PORTE, R20            ; Clear 7-segment

    ; Turn off green and red lights
    CBI PORTA, 2
    CBI PORTA, 5
    CBI PORTB, 0
    CBI PORTB, 5

    RETI

; ------------------ Helper Delay ------------------

DELAY_1s:
    CALL A
    CALL A
    CALL A
    CALL A

; Short software delay (~250ms)
A: 
    LDI R16,12 
    OUT TCNT0, R16 
    LDI R16,7 
    OUT TCCR0, R16 
WAIT: 
    IN R22, TIFR 
    SBRS R22, TOV0 
    RJMP WAIT 
    LDI R16,4 
    OUT TCCR0, R16 
    LDI R16,1 
    OUT TIFR, R16 
    RET
