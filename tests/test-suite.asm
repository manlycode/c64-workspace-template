
		!zone testsuite
	!cpu 6510

	; Include c64unit
	!src "vendor/c64unit/cross-assemblers/acme/core2000.asm"

	; Init
	+c64unit
	
	; Examine test cases
	+examineTest testSumToAccumulator

	; If this point is reached, there were no assertion fails
	+c64unitExit
	
	; Include domain logic, i.e. classes, methods and tables
	!src "../src/sum-to-accumulator.asm"
	
	; Testsuite with all test cases
	!src "test-cases/sum-to-accumulator/test.asm"
