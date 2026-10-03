.INCLUDE "M128DEF.INC"

; ------------------ Stack Ayarlarý ------------------
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

; ------------------ PC4 Çýkýþ Olarak Ayarlanýyor ------------------
SBI DDRC, 4
; Ek olarak PORTC.2 ve PORTC.3 da çýkýþ olmalý (kodda kullanýldýklarý için)
SBI DDRC, 2
SBI DDRC, 3

; ------------------ Ana Döngü ------------------
BEGIN:
	SBI PORTC, 4			; LED ON (PC4)
	RCALL DELAY_15s
	CBI PORTC, 4			; LED OFF (PC4)

	SBI PORTC, 2			; PC2 HIGH
	RCALL DELAY_3s
	CBI PORTC, 2			; PC2 LOW

	SBI PORTC, 3			; PC3 HIGH
	RCALL DELAY_15s
	CBI PORTC, 3			; PC3 LOW

	RJMP BEGIN

; ------------------ 15 Saniye Gecikme ------------------
DELAY_15s:
	LDI R18, 60				; 60 x 250ms = 15s
DELAY_LOOP:
	RCALL DELAY_250ms
	DEC R18
	BRNE DELAY_LOOP
	RET

; ------------------ 3 Saniye Gecikme ------------------
DELAY_3s:
	LDI R18, 12				; 12 x 250ms = 3s
DELAY_LOOP2:
	RCALL DELAY_250ms
	DEC R18
	BRNE DELAY_LOOP2
	RET

; ------------------ 250ms Gecikme (CTC Mode - Timer1) ------------------
DELAY_250ms:
	; OCR1A = 243 (1 MHz ve 1024 prescaler için)
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
