!ifndef from_suite { 
	!src "src/vic.asm"
	!src "vendor/c64unit/cross-assemblers/acme/core2000.asm"
	+c64unit
	
	; Examine test cases
	+examineTest testSelectScreenMemory

	; If this point is reached, there were no assertion fails
	+c64unitExit
}

!zone testSelectScreenMemory

vic_ram_register
	!byte $F0

; @access public
; @return void
testSelectScreenMemory
	lda #$FF
	sta vic_ram_register

	+_vicSelectScreenMemory 0, vic_ram_register
	+assertEqual %00001111, vic_ram_register

	lda #$FF
	sta vic_ram_register
	+_vicSelectScreenMemory 1, vic_ram_register
	+assertEqual %00011111, vic_ram_register

	lda #$FF
	sta vic_ram_register
	+_vicSelectScreenMemory 2, vic_ram_register
	+assertEqual %00101111, vic_ram_register

	lda #$FF
	sta vic_ram_register
	+_vicSelectScreenMemory 3, vic_ram_register
	+assertEqual %00111111, vic_ram_register

	lda #$FF
	sta vic_ram_register
	+_vicSelectScreenMemory 4, vic_ram_register
	+assertEqual %01001111, vic_ram_register

	lda #$FF
	sta vic_ram_register
	+_vicSelectScreenMemory 5, vic_ram_register
	+assertEqual %01011111, vic_ram_register

	lda #$FF
	sta vic_ram_register
	+_vicSelectScreenMemory 6, vic_ram_register
	+assertEqual %01101111, vic_ram_register

	lda #$FF
	sta vic_ram_register
	+_vicSelectScreenMemory 15, vic_ram_register
	+assertEqual %11111111, vic_ram_register

	rts
