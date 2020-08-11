!ifndef from_suite { 
	!src "src/pointer-macros.asm"
	!src "vendor/c64unit/cross-assemblers/acme/core2000.asm"
	+c64unit
	
	; Examine test cases
	+examineTest testSavePointer

	; If this point is reached, there were no assertion fails
	+c64unitExit
}

!zone testSavePointer

target !byte $0, $0
!address{
source = $beef
source2
	!byte $ff
}


; @access public
; @return void
testSavePointer
	lda $0
	+savePointer source, target

	lda target
	+assertEqualToA $ef ; 239
	lda target+1
	+assertEqualToA $be ; 190

	+savePointer source2, target
	lda target
	+assertEqualToA <source2
	lda target
	+assertEqualToA <source2
	
	rts
