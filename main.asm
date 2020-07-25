; ===============================================================================
; Imports
!src "src/hardware.asm"
!src "src/irq_macros.asm"
!src "src/vic.asm"
!src "src/cia.asm"

;========================================================================
; Zero Page
;========================================================================
*=$000
!src "src/memory.asm"

;========================================================================
; Basic Loader
;========================================================================
*=$0801 ; 10 SYS (2064)

        !byte $0E, $08, $0A, $00, $9E, $20, $28, $32
        !byte $30, $36, $34, $29, $00, $00, $00

        ; Our code starts at $0810 (2064 decimal)
        ; after the 15 bytes for the BASIC loader


;========================================================================
; Entry Point
;========================================================================
init
        
        jsr disableRunStop        
        sei

        +vicSelectScreenMemory 3

        jsr clearScreenRam
        
        ; lda #0
        ; sta vic_cborder
        ; Disable CIA Timers
        ldy #$7f                ; bit mask
                                ; 7 - Set or Clear the following bits in the mask.
                                ; in this case, we're clearing them
        sty cia1_icr               ; CIA1_ICR
        sty cia2_icr               ; CIA2_ICR

        ; Clear CIA IRQs by reading the registers
        lda cia1_icr            ; CIA1_ICR
        lda cia2_icr            ; CIA2_ICR

addRasterCall
        +addRasterInterrupt irq, 0
        cli                     ; clear interrupt disable flat
        jmp *                   ; infinite loop

irq
        dec $d019

        lda #0
        sta vic_cborder
        sta vic_cbg
        jsr clearScreenRam
        jsr clearColorRam

        jmp $ea81

!src "src/init.asm"