"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'as yet unclassified' }
JbSamplePrograms class >> gcd [
"Provides the greatest common denominator between two values."
	| jbi |
	jbi := JbInterpreter new.
	jbi run: 'var gcd = function(a,b) { if (a == 0) { return b; }  return gcd(mod(b,a), a); };'.
	jbi run: 'var a = stringToNumber(input("Enter first numeric value:")); var b = stringToNumber(input("Enter second numeric value:"));'.
	jbi run: 'println(gcd(a,b));'.
	
]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]

{ #category : #'instance creation' }
JbSamplePrograms class >> sqrt [ 
"Calculates and displays the square root of a number in Float form."
| jbi |
jbi := JbInterpreter new.
jbi run: '
var sqrt = function(x) { 
	var n = x;
	var counter = 0;
	var root = 0;
	var running = true;
	
	while (running) { 
		counter = counter + 1;
		root = 1/2 * (x + (n / x));
		var y = abs(root - x);
		
		if (y < 1/10000) { 
			running = false;
		 } else { 
			println(concat("Current root: ", asFloat(root)));
		 }
		x = root;
	 }
	return asFloat(x);
 };'.

jbi run: 'println(concat("Result: ", sqrt(stringToNumber(input("Enter a number: ")))));'
]
