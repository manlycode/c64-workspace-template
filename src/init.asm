disableRunStop
          ; Disable run/stop + restore buttons
        lda #$FC        ; Low byte for pointer to  routine. Result -> $F6FC
        sta $0328
	rts

clearScreenRam
        ; Clear screen ram
        ldx #0
        lda #$20                 ; Space petscii	lda #0
.clearScreenRamLoop
        sta $0400,x
        sta $0500,x
        sta $0600,x
        sta $0700,x
        inx
        bne .clearScreenRamLoop        ; x will eventually roll over to 0
	rts

clearColorRam
	ldx #0
.clearColorRamLoop
        sta $D800,x
        sta $D900,x
        sta $DA00,x
        sta $DB00,x
        inx
        bne .clearColorRamLoop
	rts     