Class {
	#name : #BaselineOfSeasidePerformanceTiming,
	#superclass : #BaselineOf,
	#category : #BaselineOfSeasidePerformanceTiming
}

{ #category : #baselines }
BaselineOfSeasidePerformanceTiming >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self seaside: spec.
			spec
				package: 'Seaside-PerformanceTiming'
					with: [ spec requires: 'Seaside3' ];
				package: 'Seaside-Tests-PerformanceTiming'
					with: [ spec requires: 'Seaside-PerformanceTiming' ].
			spec
				group: 'Core' with: #('Seaside-PerformanceTiming');
				group: 'Tests' with: #('Seaside-Tests-PerformanceTiming');
				group: 'default' with: #('Core' 'Tests') ]
]

{ #category : #baselines }
BaselineOfSeasidePerformanceTiming >> seaside: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec
				loads: #('default');
				repository: 'github://SeasideSt/Seaside:master/repository' ]
]
