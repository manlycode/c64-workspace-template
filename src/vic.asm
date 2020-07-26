!address {
	; register addresses
	vic_xs0		= $d000
	vic_ys0		= $d001
	vic_xs1		= $d002
	vic_ys1		= $d003
	vic_xs2		= $d004
	vic_ys2		= $d005
	vic_xs3		= $d006
	vic_ys3		= $d007
	vic_xs4		= $d008
	vic_ys4		= $d009
	vic_xs5		= $d00a
	vic_ys5		= $d00b
	vic_xs6		= $d00c
	vic_ys6		= $d00d
	vic_xs7		= $d00e
	vic_ys7		= $d00f
	vic_msb_xs	= $d010
	vic_controlv	= $d011	; vertical control (and much other stuff)
	vic_line	= $d012	; raster line
	vic_xlp		= $d013	; light pen coordinates
	vic_ylp		= $d014
	vic_sactive	= $d015	; sprites: active
	vic_controlh	= $d016	; horizontal control (and much other stuff)
	vic_sdy		= $d017	; sprites: double height
	vic_ram		= $d018	; RAM pointer
	vic_irq		= $d019
	vic_irqmask	= $d01a
	vic_sback	= $d01b	; sprites: background mode
	vic_smc		= $d01c	; sprites: multi color mode
	vic_sdx		= $d01d	; sprites: double width
	vic_ss_collided	= $d01e	; sprite-sprite collision detect
	vic_sd_collided	= $d01f	; sprite-data collision detect
	; color registers
	vic_cborder	= $d020	; border color
	vic_cbg		= $d021	; general background color
	vic_cbg0	= $d021
	vic_cbg1	= $d022	; background color 1 (for EBC and MC text mode)
	vic_cbg2	= $d023	; background color 2 (for EBC and MC text mode)
	vic_cbg3	= $d024	; background color 3 (for EBC mode)
	vic_sc01	= $d025	; sprite color for MC-bitpattern %01
	vic_sc11	= $d026	; sprite color for MC-bitpattern %11
	vic_cs0		= $d027	; sprite colors
	vic_cs1		= $d028
	vic_cs2		= $d029
	vic_cs3		= $d02a
	vic_cs4		= $d02b
	vic_cs5		= $d02c
	vic_cs6		= $d02d
	vic_cs7		= $d02e
}
; See <cbm/c128/vic.a> for the C128's two additional registers at $d02f/$d030.
; They are accessible even in C64 mode and $d030 can garble the video output,
; so be careful not to write to it accidentally in a C64 program!

!macro vicSelectBank .bankNum {
	+_selectBank .bankNum, $dd02, $dd00
}

!macro _selectBank .bankNum, .cia_data_direction, .cia_pra  {
	lda .cia_data_direction
	ora #$03
	sta .cia_data_direction
	lda .cia_pra
	and %11111100
	ora #3-.bankNum
	sta .cia_pra
}

;========================================================================
; Screen Memory pg. 102
;========================================================================
!macro vicSelectScreenMemory .idx {
	+_vicSelectScreenMemory .idx, vic_ram
}

!macro _vicSelectScreenMemory .idx, .vic_ram_register {
	lda .vic_ram_register
	and #%00001111	; clear high bits
	ora #16*.idx
	sta .vic_ram_register
}
;========================================================================
; Character Memory pg. 103 - 106
;========================================================================
!macro vicSelectCharMemory .idx {
	+_vicSelectCharMemory .idx, vic_ram
}

!macro _vicSelectCharMemory .idx, .vic_ram_register {
	lda .vic_ram_register
	and #%11110001	; clear bits 3-1
	ora #2*.idx
	sta .vic_ram_register
}

;========================================================================
; Multi-color Mode pg. 115
;========================================================================
!macro vicSetMultiColorMode {
	lda vic_controlh
	ora #%00010000
	sta vic_controlh
}

!macro vicSetStandardCharacterMode {
	lda vic_controlh
	and #%11101111
	sta vic_controlh
}