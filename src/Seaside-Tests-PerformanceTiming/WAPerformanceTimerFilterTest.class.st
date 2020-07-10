Class {
	#name : #WAPerformanceTimerFilterTest,
	#superclass : #WARequestHandlerTest,
	#category : #'Seaside-Tests-PerformanceTiming'
}

{ #category : #tests }
WAPerformanceTimerFilterTest >> newHandler [
	^ WAPerformanceTimerTestHandler new
]

{ #category : #tests }
WAPerformanceTimerFilterTest >> testHandlesNotifications [
	| context indicators |
	handler addFilter: WAPerformanceTimerFilter new.
	context := self createRequestContext.
	handler handle: context.
	self assert: (context response headers includesKey: 'Server-Timing').
	indicators := (context response headers allAt: 'Server-Timing').
	self
		assert: indicators size
		equals: handler samplePerformanceIndicators size
]
