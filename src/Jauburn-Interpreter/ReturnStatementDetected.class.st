Class {
	#name : #ReturnStatementDetected,
	#superclass : #Error,
	#instVars : [
		'value'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #evaluating }
ReturnStatementDetected >> value [
	^ value
]

{ #category : #accessing }
ReturnStatementDetected >> value: aReturnValue [

value := aReturnValue 
]
