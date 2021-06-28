Extension { #name : #BlockClosure }

{ #category : #'*Seaside-PerformanceTiming' }
BlockClosure >> measuredAs: aString [
	WAPerformanceTiming measure: aString during: self
]
