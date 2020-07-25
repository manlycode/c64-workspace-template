;========================================================================
; $00-$FF Zero Page 
;------------------------------------------------------------------------
; Video Bank 0 $0000 - $3fff (16K)
;------------------------------------------------------------------------
        ; $00-$01   Reserved for IO
*=$02
temp    !byte $00
        ; $03-$8F   Reserved for BASIC
*=$90

;========================================================================
; $0100 - $10ff         Stack
;========================================================================

;========================================================================
; $0200 - $9FFF         RAM 40K
;========================================================================

        ; $0801 is where code starts

;------------------------------------------------------------------------
; Video Bank 1 $4000 - $7fff (16K)
;------------------------------------------------------------------------

;------------------------------------------------------------------------
; Video Bank 2 $8000 - $bfff (16K)
;------------------------------------------------------------------------

;========================================================================
; $a000-$bfff           Basic ROM (8K)
;========================================================================

;========================================================================
; $c000-$cfff           RAM (4k)
;========================================================================
; Video Bank 3 $c000 - $ffff (16K)
;------------------------------------------------------------------------

;========================================================================
; $d000-$dfff           IO (4k)
;========================================================================

;========================================================================
; $e000-$ffff           Kernal Rom
;========================================================================