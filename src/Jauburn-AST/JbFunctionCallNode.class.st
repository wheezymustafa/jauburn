Class {
	#name : #JbFunctionCallNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'arguments'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbFunctionCallNode >> arguments [
	^ arguments
]

{ #category : #accessing }
JbFunctionCallNode >> arguments: anObject [
	arguments := anObject
]

{ #category : #'as yet unclassified' }
JbFunctionCallNode >> evaluateIn: anEnvironment [

| func |
func := anEnvironment at: identifier.
^ func call: arguments in: anEnvironment.
]

{ #category : #'as yet unclassified' }
JbFunctionCallNode >> executeIn: anEnvironment [

| func |
func := anEnvironment at: identifier.
^ func call: arguments in: anEnvironment.
]

{ #category : #accessing }
JbFunctionCallNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbFunctionCallNode >> identifier: anObject [
	identifier := anObject
]
