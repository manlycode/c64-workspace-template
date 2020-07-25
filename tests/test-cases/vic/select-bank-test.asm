!ifndef from_suite { 
	!src "src/vic.asm"
	!src "vendor/c64unit/cross-assemblers/acme/core2000.asm"
	+c64unit
	
	; Examine test cases
	+examineTest testSelectBank

	; If this point is reached, there were no assertion fails
	+c64unitExit
}

!zone testSelectBank

cia2_pra
	!byte $0
cia2_ddra
	!byte $0


; @access public
; @return void
testSelectBank
	lda $0
	+_selectBank 1, cia2_ddra, cia2_pra

	lda cia2_ddra
	+assertEqualToA %00000011

	lda cia2_pra
	+assertEqualToA %00000010

	+_selectBank 2, cia2_ddra, cia2_pra

	lda cia2_ddra
	+assertEqualToA %00000011

	lda cia2_pra
	+assertEqualToA %00000001

	+_selectBank 3, cia2_ddra, cia2_pra

	lda cia2_ddra
	+assertEqualToA %00000011

	lda cia2_pra
	+assertEqualToA %00000000

	+_selectBank 0, cia2_ddra, cia2_pra

	lda cia2_ddra
	+assertEqualToA %00000011

	lda cia2_pra
	+assertEqualToA %00000011
	
	rts
