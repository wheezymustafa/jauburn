"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'printer',
		'uiManager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #'as yet unclassified' }
JbInterpreter >> absBinding [

	^ #abs -> [ :aNumber | aNumber first abs ]
]

{ #category : #converting }
JbInterpreter >> asFloatBinding [

^ #asFloat -> [ :args | args first asFloat ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> concatBinding [

	^ #concat -> [ :args | args first asString, args second asString]
	
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	| bindings |
	super initialize.
	environment := JbEnvironment new.
	
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| binding jbPrim |
				binding := self perform: s.
				jbPrim := JbPrimitive new
					block: (binding value).
				environment at: binding key put: jbPrim ].
		 
]

{ #category : #'as yet unclassified' }
JbInterpreter >> inputBinding [

	^ #input -> [ :args | self uiManager default request: args first ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #'as yet unclassified' }
JbInterpreter >> lengthBinding [
	
	^ #length -> [ :aString | aString first size ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> modBinding [

	^ #mod -> [ :args | 
		Transcript show: 'a: ', args first asString, ', b: ', args second asString; cr.
		args first \\ args second ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> notBinding [

	^ #not -> [ :aBoolean | aBoolean first not ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
	^#print -> [ :value | self printer show: value first printString ]
]

{ #category : #accessing }
JbInterpreter >> printer [
	^ printer ifNil: [ Transcript ]
]

{ #category : #accessing }
JbInterpreter >> printer: aPrinter [

	printer := aPrinter
]

{ #category : #'as yet unclassified' }
JbInterpreter >> printlnBinding [

	^#println -> [ :value | self printer show: value first printString; cr. ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #'as yet unclassified' }
JbInterpreter >> stringToNumberBinding [ 
	^ #stringToNumber -> [ :aNumberString | aNumberString first asNumber ]
]

{ #category : #accessing }
JbInterpreter >> uiManager [ 

^ uiManager ifNil: [ UIManager ] 
]

{ #category : #accessing }
JbInterpreter >> uiManager: aUIManager [

uiManager := aUIManager 
]
