Class {
	#name : #JbArity1OperatorNode,
	#superclass : #Object,
	#instVars : [
		'operator',
		'operand'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #'as yet unclassified' }
JbArity1OperatorNode >> evaluateIn: anEnvironment [

	| operandResult |
	operandResult := self operand evaluateIn: anEnvironment.
	self operator = $-
		ifTrue: [ ^ operandResult * -1 ].
]

{ #category : #accessing }
JbArity1OperatorNode >> operand [
	^ operand
]

{ #category : #accessing }
JbArity1OperatorNode >> operand: anObject [
	operand := anObject
]

{ #category : #accessing }
JbArity1OperatorNode >> operator [
	^ operator
]

{ #category : #accessing }
JbArity1OperatorNode >> operator: anObject [
	operator := anObject
]
