Class {
	#name : #JbWhileLoopNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'statements'
	],
	#category : #'Jauburn-AST'
}

{ #category : #accessing }
JbWhileLoopNode >> condition [ 

^ condition
]

{ #category : #accessing }
JbWhileLoopNode >> condition: aCondition [

condition := aCondition 
]

{ #category : #'as yet unclassified' }
JbWhileLoopNode >> executeIn: anEnvironment [

	
[condition evaluateIn: anEnvironment]
	whileTrue: [ statements do: [ :stmt | stmt executeIn: anEnvironment  ] ].
]

{ #category : #accessing }
JbWhileLoopNode >> statements [ 

^ statements
]

{ #category : #accessing }
JbWhileLoopNode >> statements: someStatements [

statements := someStatements
]
