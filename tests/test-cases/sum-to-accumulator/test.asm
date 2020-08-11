
!ifndef from_suite { 
	!src "vendor/c64unit/cross-assemblers/acme/core2000.asm"
	+c64unit
	
	; Examine test cases
	+examineTest testSumToAccumulator

	; If this point is reached, there were no assertion fails
	+c64unitExit

	!src "src/sum-to-accumulator.asm"
}
; @access public
; @return void
testSumToAccumulator
	; Run function
	ldx #5
	ldy #6
	
	jsr sumToAccumulator
	
	; Assertion
	pha
	+assertEqualToA 11
	pla
	+assertNotEqualToA 0
rts
