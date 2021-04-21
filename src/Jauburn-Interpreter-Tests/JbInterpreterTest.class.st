Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> testAbsBindingWorksProperly [

	self interpret: 'var x = abs(-3);'.
	self assert: (interpreter environment at: 'x') equals: 3.
	
	self interpret: 'var x = abs(5);'.
	self assert: (interpreter environment at: 'x') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testAddInterpreted [

	self interpret: 'var x = 10 + 3;'.
	self assert: (interpreter environment at: 'x') equals: 13.
	
	self interpret: 'var x = 10 + 0; var y = 3 + 3; var z = x + y;'.
	self assert: (interpreter environment at: 'z') equals: 16.
]

{ #category : #tests }
JbInterpreterTest >> testAssignmentStatementInterpreted [

	self interpret: 'var x = 3; x = 5;'.
	self assert: (interpreter environment at: 'x') equals: 5.
	
	self interpret: 'var y = "hello"; y = "goodbye";'.
	self assert: (interpreter environment at: 'y') equals: 'goodbye'.
]

{ #category : #tests }
JbInterpreterTest >> testConcatBindingWorksProperly [

	interpreter run: 'var result = concat("monkey", "banana");'.
	self assert: (interpreter environment at: 'result') equals: 'monkeybanana'.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testDivideInterpreted [

	self interpret: 'var x = 12 / 3;'.
	self assert: (interpreter environment at: 'x') equals: 4.
	
	self interpret: 'var x = 6 / 4;'.
	self assert: (interpreter environment at: 'x') equals: 3/2.
]

{ #category : #tests }
JbInterpreterTest >> testDivisionInterpreted [

	self interpret: 'var x = 10 / 2;'.
	self assert: (interpreter environment at: 'x') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testEnvironmentVariablesProperlySet [

	self interpret: 'var z = 1; var myFunc = function() { return z == 1; }; var result = myFunc();'.
	self assert: (interpreter environment at: 'result') equals: true. 
]

{ #category : #tests }
JbInterpreterTest >> testEqualityInterpreted [

	self interpret: 'var x = 3; var y = 3; var z = x == y;'.
	self assert: (interpreter environment at: 'z') equals: true.
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCallArgumentsArePassed [

	self interpret: 'var z = 1; var myFunc = function(x, y) { z = x + y; }; myFunc(3,4);'.
	self assert: (interpreter environment at: 'z') equals: 7.
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCallIsExecuted [

	| myFunc |
	self interpret: 'var z = 1; var myFunc = function() { z = 5; }; myFunc();'.
	self assert: (interpreter environment at: 'z') equals: 5
	
"	self assert: (myFunc isMemberOf: JbFunction) equals: true.
	self assert: (myFunc body first isMemberOf: JbReturnStatementNode) equals: true.
"
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCallWithReturnStatement [

	self interpret: 'var myFunc = function(x, y) { return x + y; }; var z = myFunc(3,4);'.
	self assert: (interpreter environment at: 'z') equals: 7.
]

{ #category : #tests }
JbInterpreterTest >> testFunctionClosure [
	self interpret: 'var makeCounter = function() { var count = 0; return function() { count = count + 1; return count; }; };'.
	self interpret: 'var c1 = makeCounter();'.
	self interpret: 'var c2 = makeCounter();'.
	self interpret: 'c1();'. 
	self interpret: 'c1();'.
	self interpret: 'var x = c1();'.
	self interpret: 'var y = c2();'.
	self assert: (interpreter environment at: 'x') equals: 3.	
	self assert: (interpreter environment at: 'y') equals: 1.	
]

{ #category : #tests }
JbInterpreterTest >> testFunctionDefinitionInterpreted [

	| myFunc |
	self interpret: 'var myFunc = function(x) { return x + 3; };'.
	myFunc := interpreter environment at: 'myFunc'.
	
	self assert: (myFunc isMemberOf: JbFunction) equals: true.
	self assert: (myFunc body first isMemberOf: JbReturnStatementNode) equals: true.

]

{ #category : #tests }
JbInterpreterTest >> testGreaterThanInterpreted [

	self interpret: 'var x = 10 > 3;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 > 7;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 > 3;'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testGreaterThanOrEqualToInterpreted [

	self interpret: 'var x = 10 >= 3;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 >= 7;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 >= 3;'.
	self assert: (interpreter environment at: 'x') equals: true.
]

{ #category : #tests }
JbInterpreterTest >> testIfElseInterpreted [

	self interpret: 'var x = 0; var myFunc = function(a,b,c) { if (0 == 1) { x = a + b + c; } else { x = "monkey"; } }; myFunc(2,3,4);'.
	"x should be assigned to monkey"
	self assert: (interpreter environment at: 'x') equals: 'monkey'.
	
	self interpret: 'var x = 0; var myFunc = function(a,b,c) { if (0 < 1) { x = a + b + c; } else { x = "monkey"; } }; myFunc(2,3,4);'.
	"x should be reassigned to 9"
	self assert: (interpreter environment at: 'x') equals: 9.
]

{ #category : #tests }
JbInterpreterTest >> testIfInterpreted [

	self interpret: 'var x = 0; var myFunc = function(a,b,c) { if (0 == 1) { x = a + b + c; } }; myFunc(2,3,4);'.
	"x should remain 0"
	self assert: (interpreter environment at: 'x') equals: 0.
	
	self interpret: 'var x = 0; var myFunc = function(a,b,c) { if (0 < 1) { x = a + b + c; } }; myFunc(2,3,4);'.
	"x should be reassigned to 9"
	self assert: (interpreter environment at: 'x') equals: 9.
]

{ #category : #tests }
JbInterpreterTest >> testInputBindingWorksCorrectly [

	| mockUIManager |
	mockUIManager := JbMockUIManager new.
	interpreter uiManager: mockUIManager.
	interpreter run: 'input("hello how are you?");'.
	self assert: mockUIManager prompt equals: 'hello how are you?'.
]

{ #category : #tests }
JbInterpreterTest >> testLessThanInterpreted [

	self interpret: 'var x = 10 < 3;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 < 7;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 < 3;'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testLessThanOrEqualToInterpreted [

	self interpret: 'var x = 10 <= 3;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 <= 7;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 <= 3;'.
	self assert: (interpreter environment at: 'x') equals: true.
]

{ #category : #tests }
JbInterpreterTest >> testModBindingWorksProperly [

	self interpret: 'var x = mod(12, 5);'.
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var x = mod(192, 16);'.
	self assert: (interpreter environment at: 'x') equals: 0.
]

{ #category : #tests }
JbInterpreterTest >> testMultiplyInterpreted [

	self interpret: 'var x = 10 * 3;'.
	self assert: (interpreter environment at: 'x') equals: 30.
	
	self interpret: 'var x = 2 * 32; var y = x * 2; var z = y * y;'.
	self assert: (interpreter environment at: 'z') equals: 16384.
]

{ #category : #tests }
JbInterpreterTest >> testNotBindingWorksProperly [

	self interpret: 'var x = true; var x = not(x);'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testNotEqualToInterpreted [

	self interpret: 'var x = 10 != 3;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 != 7;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 != 3;'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #printing }
JbInterpreterTest >> testPrintBindingPrintsCorrectly [

	| mockTranscript |
	mockTranscript := JbMockTranscript new.
	interpreter printer: mockTranscript.
	interpreter run: 'print(3);'.
	self assert:  mockTranscript contents equals: '3'.
	
]

{ #category : #tests }
JbInterpreterTest >> testReturnStatementInterpreted [


]

{ #category : #tests }
JbInterpreterTest >> testReturnStatementReturnsValue [
	self interpret: 'var func = function (a, b, c) {return a + b + c;};'.
	self interpret: 'var z = func(5, 3, 2);'. 
	self assert: (interpreter environment at: 'z') equals: 10.	
]

{ #category : #tests }
JbInterpreterTest >> testStringToNumberBindingWorksProperly [

	self interpret: 'var x = stringToNumber("2032");'.
	self assert: (interpreter environment at: 'x') equals: 2032.
	
	self interpret: 'var x = stringToNumber("-2032");'.
	self assert: (interpreter environment at: 'x') equals: -2032.
]

{ #category : #tests }
JbInterpreterTest >> testSubtractInterpreted [

	self interpret: 'var x = 10 - 3;'.
	self assert: (interpreter environment at: 'x') equals: 7.
	
	self interpret: 'var x = 10 - 3; var y = 9 - 3; var z = x - y;'.
	self assert: (interpreter environment at: 'z') equals: 1.
]

{ #category : #tests }
JbInterpreterTest >> testUnaryNegation [

	self interpret: 'var x = 10 / 2; var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: -5.
	
	self interpret: 'var x = -5; var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: 5.
	
]

{ #category : #tests }
JbInterpreterTest >> testWhileLoopCorrectlyLoops [

	self interpret: 'var x = 0; var loopFunc = function() { while (x < 10) { x = x+ 1; }}; loopFunc();'.
	self assert: (interpreter environment at: 'x') equals: 10.
	
	self interpret: 'var ayy = "a"; var counter = 0;'.
	self interpret: 'var ayyFunc = function() { while (counter < 10) { ayy = concat(ayy, "y"); counter = counter + 1; }}; ayyFunc();'.
	self assert: (interpreter environment at: 'ayy') equals: 'ayyyyyyyyyy'.
]

{ #category : #tests }
JbInterpreterTest >> testWhileLoopInterpreted [

	| programNode loopNode |
	programNode := parser parse: 'while (x < 10) {x = x+1;}'.
	loopNode := programNode statements first.
	self assert: (loopNode isMemberOf: JbWhileLoopNode) equals: true.
]

{ #category : #tests }
JbInterpreterTest >> testWhileLoopSumTest [

	self interpret: 'var x = 1; var sum = 0; var sumFunc = function() { while (x <= 10) { sum = sum + x; x = x + 1; }}; sumFunc();'.
	self assert: (interpreter environment at: 'sum') equals: 55.
]

{ #category : #'as yet unclassified' }
JbInterpreterTest >> testlengthBindingWorksProperly [

	
	interpreter run: 'var result = length("monkey");'.
	self assert: (interpreter environment at: 'result') equals: 6.
	
	interpreter run: 'var result = length("");'.
	self assert: (interpreter environment at: 'result') equals: 0.
]
