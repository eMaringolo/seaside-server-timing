Class {
	#name : #WAPerformanceTimerTestHandler,
	#superclass : #WARequestHandler,
	#category : #'Seaside-Tests-PerformanceTiming'
}

{ #category : #handling }
WAPerformanceTimerTestHandler >> handleFiltered: aRequestContext [
	self samplePerformanceIndicators do: [ :each | each signal ].
	(Delay forMilliseconds: 105) wait
]

{ #category : #handling }
WAPerformanceTimerTestHandler >> samplePerformanceIndicators [
	^ Array
		with: (WAPerformanceTiming name: 'setup' description: 'Request setup' duration: 5 milliseconds)
		with: (WAPerformanceTiming name: 'callback' description: 'Callback procesing' duration: 80 milliseconds)
		with: (WAPerformanceTiming name: 'render' description: 'Rendering' duration: 25 milliseconds)
		with: (WAPerformanceTiming name: 'cache' description: 'Cache hit')
]
