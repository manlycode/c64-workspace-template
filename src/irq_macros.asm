!ifdef irq_macros_asm !eof
irq_macros_asm = 1

; Args:
;       @param .irq - address of subroutine for interrupt
;       @param .row - row at which to trigger subroutine
!macro addRasterInterrupt .irq, .row {
        ; Set Interrupt Request Mask
        lda #$01                ; set mask to enable by raster beam
        sta vic_irqmask           ; VIC_IRQEN
        lda #<.irq               ; Point the system routine to our new irq
        ldx #>.irq
        sta BASIC_ISR_ADDR
        stx BASIC_ISR_ADDR+1

        lda #.row                ; trigger first interrupt at row 0
        sta vic_line          ; VIC_RSTCMP
        lda vic_controlv        ; VIC_CR1 - Bit 7 is 9th bit of $d012 - Needs to be set to 0 as well
        and #$7f
        sta vic_controlv

}