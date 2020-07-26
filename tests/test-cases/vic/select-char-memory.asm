!ifndef from_suite { 
	!src "src/vic.asm"
	!src "vendor/c64unit/cross-assemblers/acme/core2000.asm"
	+c64unit
	
	; Examine test cases
	+examineTest testSelectCharMemory

	; If this point is reached, there were no assertion fails
	+c64unitExit
}

!zone testSelectCharMemory

vic_ram_register
	!byte $FF

; @access public
; @return void
testSelectCharMemory
	lda #$FF
	sta vic_ram_register

	+_vicSelectCharMemory 0, vic_ram_register
	+assertEqual %11110001, vic_ram_register	; 241

	lda #$FF
	sta vic_ram_register
	+_vicSelectCharMemory 1, vic_ram_register	
	+assertEqual %11110011, vic_ram_register	; 243

	lda #$FF
	sta vic_ram_register
	+_vicSelectCharMemory 2, vic_ram_register	
	+assertEqual %11110101, vic_ram_register	; 245

	lda #$FF
	sta vic_ram_register
	+_vicSelectCharMemory 3, vic_ram_register
	+assertEqual %11110111, vic_ram_register	; 247

	lda #$FF
	sta vic_ram_register
	sta vic_ram_register
	+_vicSelectCharMemory 4, vic_ram_register
	+assertEqual %11111001, vic_ram_register	; 249
	
	lda #$FF
	sta vic_ram_register
	sta vic_ram_register
	+_vicSelectCharMemory 5, vic_ram_register
	+assertEqual %11111011, vic_ram_register	; 251

	lda #$FF
	sta vic_ram_register
	sta vic_ram_register
	+_vicSelectCharMemory 6, vic_ram_register
	+assertEqual %11111101, vic_ram_register	; 253

	lda #$FF
	sta vic_ram_register
	sta vic_ram_register
	+_vicSelectCharMemory 7, vic_ram_register
	+assertEqual %11111111, vic_ram_register	; 255

	; Shouldn't clobber the lowest 4 bits
	lda #$FF
	sta vic_ram_register
	lda #%01010101
	sta vic_ram_register
	+_vicSelectCharMemory 5, vic_ram_register
	+assertEqual %01011011, vic_ram_register	; 91

	rts
