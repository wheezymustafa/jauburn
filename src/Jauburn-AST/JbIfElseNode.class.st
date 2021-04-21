Class {
	#name : #JbIfElseNode,
	#superclass : #JbIfNode,
	#instVars : [
		'falseStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #'as yet unclassified' }
JbIfElseNode >> executeIn: anEnvironment [

(condition evaluateIn: anEnvironment)
	ifTrue: [ trueStatements do: [ :stmt | stmt executeIn: anEnvironment ] ]
	ifFalse: [ falseStatements do: [ :stmt | stmt executeIn: anEnvironment ] ]
]

{ #category : #accessing }
JbIfElseNode >> falseStatements [
	^ falseStatements
]

{ #category : #accessing }
JbIfElseNode >> falseStatements: anObject [
	falseStatements := anObject
]
