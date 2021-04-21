Class {
	#name : #JbMockTranscript,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #accessing }
JbMockTranscript >> contents [
	
	^ contents
]

{ #category : #'stop conditions' }
JbMockTranscript >> cr [

^ Character cr 
]

{ #category : #accessing }
JbMockTranscript >> show: aString [

	contents := aString
]
