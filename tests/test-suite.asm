; from_suite = 1

	!zone testsuite
	!cpu 6510
	; Set the flag to true so that we don't re-include what we don't need

	; Include c64unit
	!src "vendor/c64unit/cross-assemblers/acme/core2000.asm"

	; Init
	+c64unit
	
	; Examine test cases
	+examineTest testSumToAccumulator
	+examineTest testSavePointer
	; +examineTest testCopyMap

	; If this point is reached, there were no assertion fails
	+c64unitExit
	
	; Include domain logic, i.e. classes, methods and tables
	!src "src/memory.asm"
	!src "src/sum-to-accumulator.asm"
	!src "src/pointer-macros.asm"
	; !src "src/vic.asm"
	
	; Testsuite with all test cases
	!src "tests/test-cases/sum-to-accumulator/test.asm"
	!src "tests/test-cases/pointer-macros/save-pointer-test.asm"
