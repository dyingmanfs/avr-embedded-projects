.INCLUDE "M128DEF.INC"

; ------------------ Vektör Tablolarý ------------------
.ORG 0x0000
	JMP M

.ORG 0x0006		; INT3 için kesme vektörü
	JMP EX3_ISR

; ------------------ Ana Baþlangýç ------------------
M:
	; Stack ayarlarý
	LDI R20, HIGH(RAMEND)
	OUT SPH, R20
	LDI R20, LOW(RAMEND)
	OUT SPL, R20

	; Gerekli pinler çýkýþ olarak ayarlanýyor
	SBI DDRC, 4		; PC4 çýkýþ
	SBI DDRC, 2		; PC2 çýkýþ
	SBI DDRC, 3		; PC3 çýkýþ
	SBI DDRD, 0		; PD0 çýkýþ (kontrol için kullanýlabilir)

; ------------------ Ana Döngü ------------------
BEGIN:
	SBI PORTD, 0					; PD0 HIGH

	; INT3 aktif ediliyor
	LDI R20, (1 << INT3)     
	OUT EIMSK, R20

	; INT3 için rising edge tetikleme ayarý
	LDI R20, (1 << ISC31) | (1 << ISC30)
	OUT EICRB, R20

	SEI								; Global interrupt enable

	SBI PORTC, 4					; PC4 HIGH (LED ON)
	RCALL DELAY_15s
	CBI PORTC, 4					; PC4 LOW (LED OFF)

	SBI PORTC, 2					; PC2 HIGH
	RCALL DELAY_3s
	CBI PORTC, 2					; PC2 LOW

	SBI PORTC, 3					; PC3 HIGH
	RCALL DELAY_15s
	CBI PORTC, 3					; PC3 LOW

	RJMP BEGIN

; ------------------ INT3 ISR ------------------
EX3_ISR:
	CBI PORTC, 2					; PC2 LOW
	CBI PORTC, 4					; PC4 LOW
	SBI PORTC, 3					; PC3 HIGH
	RCALL DELAY_1s
	CBI PORTC, 3					; PC3 LOW
	RCALL DELAY_1s
	SBI PORTC, 3					; PC3 HIGH
	RCALL DELAY_1s
	CBI PORTC, 3					; PC3 LOW
	RETI

; ------------------ 1 Saniye Gecikme ------------------
DELAY_1s:
	LDI R18, 4				; 4 x 250ms = 1s
DELAY_LOOP1:
	RCALL DELAY_250ms
	DEC R18
	BRNE DELAY_LOOP1
	RET

; ------------------ 3 Saniye Gecikme ------------------
DELAY_3s:
	LDI R18, 12				; 12 x 250ms = 3s
DELAY_LOOP2:
	RCALL DELAY_250ms
	DEC R18
	BRNE DELAY_LOOP2
	RET

; ------------------ 15 Saniye Gecikme ------------------
DELAY_15s:
	LDI R18, 60				; 60 x 250ms = 15s
DELAY_LOOP3:
	RCALL DELAY_250ms
	DEC R18
	BRNE DELAY_LOOP3
	RET

; ------------------ 250ms Gecikme (CTC Mode - Timer1) ------------------
DELAY_250ms:
	; OCR1A = 243 (1 MHz ve 1024 prescaler için 250ms)
	LDI R20, HIGH(243)
	OUT OCR1AH, R20
	LDI R20, LOW(243)
	OUT OCR1AL, R20

	; Sayacý sýfýrla
	LDI R20, 0x00
	OUT TCNT1H, R20
	OUT TCNT1L, R20

	; Timer1 CTC mode (WGM12 = 1), Prescaler = 1024 (CS12=1, CS10=1)
	LDI R20, 0x00
	OUT TCCR1A, R20
	LDI R20, (1 << WGM12) | (1 << CS12) | (1 << CS10)
	OUT TCCR1B, R20

WAIT_CTC:
	IN R20, TIFR
	SBRS R20, OCF1A
	RJMP WAIT_CTC

	; OCF1A bayraðýný temizle
	LDI R20, (1 << OCF1A)
	OUT TIFR, R20

	; Timer1 durdur
	LDI R20, 0x00
	OUT TCCR1B, R20
	OUT TCCR1A, R20
	RET