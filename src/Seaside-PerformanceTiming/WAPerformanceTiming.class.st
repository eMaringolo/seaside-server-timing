"
I represent a PerformanceServerTiming that is going to be added to the Server-Timing HTTP header. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Server-Timing

The specification advices that names and descriptions should be kept as short as possible (use abbreviations and omit optional values where possible) to minimize the HTTP overhead.

// Single metric without value
Server-Timing: missedCache

// Single metric with value
Server-Timing: cpu;dur=2.4

// Single metric with description and value
Server-Timing: cache;desc=""Cache Read"";dur=23.2

// Two metrics with value
Server-Timing: db;dur=53, app;dur=47.2
"
Class {
	#name : #WAPerformanceTiming,
	#superclass : #Notification,
	#instVars : [
		'duration'
	],
	#category : #'Seaside-PerformanceTiming-Timing'
}

{ #category : #convenience }
WAPerformanceTiming class >> measure: performanceName during: aBlock [

	self signalName: performanceName duration: (Time millisecondsToRun: aBlock) milliseconds
]

{ #category : #'instance creation' }
WAPerformanceTiming class >> name: aString [ 
	^ self new
		tag: aString;
		yourself
]

{ #category : #'instance creation' }
WAPerformanceTiming class >> name: aString description: descriptionString [
	^ self new
		tag: aString;
		messageText: descriptionString;
		yourself
]

{ #category : #'instance creation' }
WAPerformanceTiming class >> name: aString description: descriptionString duration: aDuration [
	^ self new
		tag: aString;
		messageText: descriptionString;
		duration: aDuration;
		yourself
]

{ #category : #'instance creation' }
WAPerformanceTiming class >> name: aString duration: aDuration [
	^ self new
		tag: aString;
		duration: aDuration;
		yourself
]

{ #category : #signalling }
WAPerformanceTiming class >> signalName: aString [
	^ (self name: aString) signal
]

{ #category : #signalling }
WAPerformanceTiming class >> signalName: aString description: descriptionString duration: aDuration [
	^ (self
		name: aString
		description: descriptionString
		duration: aDuration) signal
]

{ #category : #signalling }
WAPerformanceTiming class >> signalName: aString duration: aDuration [
	^ (self name: aString duration: aDuration) signal
]

{ #category : #accessing }
WAPerformanceTiming >> duration: aDuration [ 
	duration := aDuration asDuration
]

{ #category : #converting }
WAPerformanceTiming >> greaseString [
	^ String
		streamContents: [ :stream | 
			stream
				nextPutAll: self tag..
			messageText notNil
				ifTrue:
					[ self writeDescriptionOn: stream ].
			duration notNil
				ifTrue: [ stream nextPutAll: ';dur='.
					(GRNumberPrinter new precision: 1)
						print: duration asMilliSeconds
						on: stream ] ]
]

{ #category : #converting }
WAPerformanceTiming >> writeDescriptionOn: aStream [
	aStream nextPutAll: ';desc="'.
	messageText
		do: [ :each | 
			each = $"
				ifTrue: [ aStream nextPutAll: '\"' ]
				ifFalse: [ aStream nextPut: each ] ].
	aStream nextPutAll: '"'
]
