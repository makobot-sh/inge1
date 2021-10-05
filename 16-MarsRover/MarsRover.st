!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:46:05'!
test01NoCommands
	| marsRover|
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:45:50'!
test02ForwardFromFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:48:24'!
test03BackwardsFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:49:41'!
test04RotateLeftFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:49:55'!
test05RotateLeftFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:50:00'!
test06RotateLeftFacingWest
	| marsRover|
	marsRover _ MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:49:48'!
test07RotateLeftFacingEast
	| marsRover|
	marsRover _ MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:49:27'!
test08RotateRightFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:50:18'!
test09RotateRightFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #West).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:14:00'!
isAt: aPoint heading: aSymbol 
	position = aPoint ifTrue: [
		direction = aSymbol ifTrue: [^ true].	
	].
	
	^false.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:43:40'!
process: aSequenceOfCommands 
	aSequenceOfCommands do: [:aCommand | 
		aCommand = $f ifTrue: [position _ position + (0@1)].
		aCommand = $b ifTrue: [position _ position - (0@1)].
		aCommand = $l ifTrue: [			self rotateLeft.		].
		aCommand = $r ifTrue: [ self rotateRight.].
	].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:39:33'!
rotateLeft

	^ direction = #North ifTrue: [direction _ #West]
			ifFalse: [
				direction = #South ifTrue: [direction _ #East] ifFalse: [
					direction = #West ifTrue: [direction _ #South] ifFalse: [
						direction = #East ifTrue: [direction _ #North] 
					].
				]	.
			]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 21:44:05'!
rotateRight

	^ direction = #North ifTrue: [direction _ #East]
			ifFalse: [
				direction = #South ifTrue: [direction _ #West] ifFalse: [
					direction = #West ifTrue: [direction _ #North] ifFalse: [
						direction = #East ifTrue: [direction _ #South] 
					].
				]	.
			]! !


!MarsRover methodsFor: 'initialization' stamp: 'MK 10/4/2021 21:12:07'!
initializeWith: aPoint and: aSymbol 
	position := aPoint.
	direction := aSymbol.
	^ self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'MK 10/4/2021 20:54:32'!
at: aPoint heading: aSymbol 
	^ self new initializeWith: aPoint and: aSymbol.! !

