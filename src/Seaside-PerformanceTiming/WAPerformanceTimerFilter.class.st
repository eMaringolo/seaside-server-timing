"
I watch for WAPerformanceTiming notifications and add them to a 'Server-Timing' HTTP header. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Server-Timing

"
Class {
	#name : #WAPerformanceTimerFilter,
	#superclass : #WARequestFilter,
	#category : #'Seaside-PerformanceTiming-Core'
}

{ #category : #processing }
WAPerformanceTimerFilter >> handleFiltered: aRequestContext [
	[ super handleFiltered: aRequestContext ]
		on: WAPerformanceTiming
		do: [ :timingNotification | 
			self updateHeaderOf: aRequestContext with: timingNotification.
			timingNotification resume ]
]

{ #category : #processing }
WAPerformanceTimerFilter >> updateHeaderOf: aRequestContext with: timingNotification [
	"This should not be done, since multiple Server-Timing headers should be allowed and
	merged by the adapter into a single header or sent all of them in different lines."

	aRequestContext response
		headerAt: 'Server-Timing'
		put:
			((aRequestContext response headerAt: 'Server-Timing')
				ifNil: [ '' ]
				ifNotNil: [ :value | value , ',' ])
				, timingNotification greaseString
]
