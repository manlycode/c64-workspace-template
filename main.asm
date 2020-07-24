; !to "main.prg", cbm

;===============================================================================
; Imports
!source "src/hardware.asm"
;===============================================================================
; BASIC Loader

*=$0801 ; 10 SYS (2064)

        !byte $0E, $08, $0A, $00, $9E, $20, $28, $32
        !byte $30, $36, $34, $29, $00, $00, $00

        ; Our code starts at $0810 (2064 decimal)
        ; after the 15 bytes for the BASIC loader

;===============================================================================
init
        ; jsr disableRunStop
        lda #$FC        ; Low byte for pointer to  routine. Result -> $F6FC
        sta $0328
        sei                     ; set interrupt disable flag

        ; jsr clearScreenRam
        lda #0
        sta VIC_BORDER_COL
        ; Disable CIA Timers
        ldy #$7f                ; bit mask
                                ; 7 - Set or Clear the following bits in the mask.
                                ; in this case, we're clearing them
        sty CIA1_ICR               ; CIA1_ICR
        sty CIA2_ICR               ; CIA2_ICR

        ; Clear CIA IRQs by reading the registers
        lda CIA1_ICR            ; CIA1_ICR
        lda CIA2_ICR            ; CIA2_ICR

        ; Set Interrupt Request Mask
        lda #$01                ; set mask to enable by raster beam
        sta VIC_IRQEN           ; VIC_IRQEN

        lda #<irq               ; Point the system routine to our new irq
        ldx #>irq
        sta BASIC_ISR_ADDR
        stx BASIC_ISR_ADDR+1

        lda #$00                ; trigger first interrupt at row 0
        sta VIC_RSTCMP          ; VIC_RSTCMP
        lda VIC_RSTCMP_H        ; VIC_CR1 - Bit 7 is 9th bit of $d012 - Needs to be set to 0 as well
        and #$7f
        sta VIC_RSTCMP_H

        cli                     ; clear interrupt disable flat
        jmp *                   ; infinite loop

irq
        dec $d019
        lda #0
        sta VIC_BORDER_COL
        ; jsr clearScreenRam
        ; jsr clearColorRam
                ; set the sprite color
        lda #1
        sta VIC_SPR_COL
        ; set the sprite mode 
        ; set the sprite x pos
        lda #40
        sta $D000
        ; set the sprite y pos
        lda #40
        sta $D001
        jmp $ea81

; !source "src/init.asm"