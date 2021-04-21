Class {
	#name : #JbIfNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfNode >> condition [
	^ condition
]

{ #category : #accessing }
JbIfNode >> condition: anObject [
	condition := anObject
]

{ #category : #'as yet unclassified' }
JbIfNode >> executeIn: anEnvironment [

(condition evaluateIn: anEnvironment)
	ifTrue: [ trueStatements do: [ :stmt | stmt executeIn: anEnvironment ] ].
]

{ #category : #accessing }
JbIfNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbIfNode >> trueStatements: anObject [
	trueStatements := anObject
]
