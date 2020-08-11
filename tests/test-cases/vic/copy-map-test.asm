!ifndef from_suite { 
	!src "src/vic.asm"
	!src "vendor/c64unit/cross-assemblers/acme/core2000.asm"
	+c64unit
	
	; Examine test cases
	+examineTest testCopyMap

	; If this point is reached, there were no assertion fails
	+c64unitExit

}

.theMapData
	!byte $1, $2, $3, $4, $5
	!byte $6, $7, $8, $9, $a
	!byte $b, $c, $d, $e, $f

.screenData
	!byte $0, $0
	!byte $0, $0

.expectedScreen
	!byte $1, $2
	!byte $6, $7

.expectedParams
	!byte $4, $3, $2, $2

; @access public
; @return void
testCopyMap
	+_vicCopyMap .theMapData, 4, 3, .screenData, 2, 2

	; Assert pointers got set
	lda tempPtr1
	+assertEqualToA <.theMapData
	lda tempPtr1+1
	+assertEqualToA >.theMapData

	lda tempPtr2
	+assertEqualToA <.screenData
	lda tempPtr2+1
	+assertEqualToA >.screenData

	+assertMemoryEqual .expectedParams, tempParam1, 4
	+assertMemoryEqual .expectedScreen, .screenData, 1

	rts
