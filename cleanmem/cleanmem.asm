	processor 6502

	seg code
	org $F000		; set code origin to $F000

Start:

	sei					; disable interrupts
	cld					; disable decimal mode
	ldx #$FF		; load X register with #$FF
	txs					; transfer X to stack pointer

; clean Page Zero region ($00 to $FF)
; meaning the entire RAM and TIA registers

	lda #0			; A = 0
	ldx #$FF		; X = #$FF
	sta $FF			; make sure $FF is set to zero before the loop

MemLoop:

	dex					; X--
	sta $0,X		; store the value of A at memory address $0 + X
	bne MemLoop	; loop until X is zero (Z flag is set)

; fill ROM size to exactly 4kB

	org $FFFC		; set code origin to $F000
	.word Start	; reset vector at $FFFC (where the program starts)
	.word Start ; interrupt vector at $FFFE (not used in the VCS)

