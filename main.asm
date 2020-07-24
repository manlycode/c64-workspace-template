!to "main.prg", cbm

;===============================================================================
; Imports
!source "src/hardware.acme"
;===============================================================================
; BASIC Loader

*=$0801 ; 10 SYS (2064)

        !byte $0E, $08, $0A, $00, $9E, $20, $28, $32
        !byte $30, $36, $34, $29, $00, $00, $00

        ; Our code starts at $0810 (2064 decimal)
        ; after the 15 bytes for the BASIC loader

;===============================================================================

init
        ; Disable run/stop + restore buttons
        lda #$FC        ; Low byte for pointer to  routine. Result -> $F6FC
        sta $0328

        sei                     ; set interrupt disable flag

loadColors
        ldx #0
.loopColors
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
        rts