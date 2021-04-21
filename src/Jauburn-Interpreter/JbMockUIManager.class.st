Class {
	#name : #JbMockUIManager,
	#superclass : #Object,
	#instVars : [
		'prompt',
		'response'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #accessing }
JbMockUIManager class >> default [ 

	^ self new.
]

{ #category : #accessing }
JbMockUIManager >> default [ 
	^ self 
]

{ #category : #accessing }
JbMockUIManager >> prompt [
	^ prompt 
]

{ #category : #accessing }
JbMockUIManager >> request: aPrompt [

	prompt := aPrompt 
	
]
