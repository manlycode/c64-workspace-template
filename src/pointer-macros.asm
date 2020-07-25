; @param word .source - address to copy from
; @param word .target - address to copy to
!macro savePointer .source, .target {
        ldx #<.source
        ldy #>.source
        stx .target
        sty .target+1
}