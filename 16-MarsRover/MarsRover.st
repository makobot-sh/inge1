!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:30:28'!
test01NoCommands
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
		
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 facing: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:30:35'!
test02MoveForwardFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 facing: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:30:47'!
test03BackwardsFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 facing: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:30:51'!
test04RotateLeftFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 facing: #West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:22:25'!
test05RotateLeftFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 facing: #East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:22:26'!
test06RotateLeftFacingWest
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 facing: #South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:30:57'!
test07RotateLeftFacingEast
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 facing: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:31:01'!
test08RotateRightFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 facing: #East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:22:25'!
test09RotateRightFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #South.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 facing: #West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:31:44'!
test10CommandsAfterInvalidCommandAreDiscarded
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'fWr'.
	
	self assert: (marsRover isAt: 1@3 facing: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:22:25'!
test11MoveForwardFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #South.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@1 facing: #South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:22:25'!
test12MoveForwardFacingEast
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 facing: #East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:22:26'!
test13MoveForwardFacingWest
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #West.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 0@2 facing: #West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:22:25'!
test14MoveBackwardsFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #South.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@3 facing: #South).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:22:56'!
isAt: aPosition facing: aDirection 
	position = aPosition ifTrue: [
		direction = aDirection ifTrue: [^ true].	
	].
	
	^false.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MK 10/5/2021 18:29:44'!
process: aSequenceOfCommands 
	| noMatch |
	aSequenceOfCommands do: [:aCommand | 
		noMatch _ true.
		aCommand = $f ifTrue: [
			direction = #North ifTrue: [position _ position + (0@1).]. 
			direction = #South ifTrue: [position _ position - (0@1).]. 
			direction = #West ifTrue: [position _ position - (1@0).]. 
			direction = #East ifTrue: [position _ position + (1@0).]. 
			noMatch _ false
		].
		aCommand = $b ifTrue: [
			direction = #North ifTrue: [position _ position - (0@1).].
			direction = #South ifTrue: [position _ position + (0@1).].
			direction = #West ifTrue: [position _ position + (1@0).]. 
			direction = #East ifTrue: [position _ position - (1@0).]. 
			noMatch _ false
		].
		aCommand = $l ifTrue: [			
			direction = #North ifTrue: [direction _ #West] ifFalse: [
				direction = #South ifTrue: [direction _ #East] ifFalse: [
					direction = #West ifTrue: [direction _ #South] ifFalse: [
						direction = #East ifTrue: [direction _ #North] 
					].
				].
			].
			noMatch _ false
		].
		aCommand = $r ifTrue: [
			direction = #North ifTrue: [direction _ #East] ifFalse: [
				direction = #South ifTrue: [direction _ #West] ifFalse: [
					direction = #West ifTrue: [direction _ #North] ifFalse: [
						direction = #East ifTrue: [direction _ #South] 
					].
				].
			].
			noMatch _ false
		].
		noMatch ifTrue: [^ self].
	].! !


!MarsRover methodsFor: 'initialization' stamp: 'MK 10/5/2021 18:49:22'!
initializeWith: aPosition and: aDirection 
	position := aPosition.
	direction := aDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'MK 10/5/2021 18:22:25'!
at: aPosition facing: aDirection 
	^ self new initializeWith: aPosition and: aDirection.! !


!classDefinition: #MarsRoverState category: 'MarsRover'!
Object subclass: #MarsRoverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverState class' category: 'MarsRover'!
MarsRoverState class
	instanceVariableNames: ''!

!MarsRoverState class methodsFor: 'class initialization' stamp: 'MK 10/5/2021 18:25:07'!
facing: aDirection
	aDirection = #South ifTrue: [^ FacingSouth new].
	aDirection = #North ifTrue: [^ FacingNorth new].
	aDirection = #West ifTrue: [^ FacingWest new].
	aDirection = #East ifTrue: [^ FacingEast new].! !


!classDefinition: #FacingEast category: 'MarsRover'!
MarsRoverState subclass: #FacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!classDefinition: #FacingNorth category: 'MarsRover'!
MarsRoverState subclass: #FacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!classDefinition: #FacingSouth category: 'MarsRover'!
MarsRoverState subclass: #FacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!classDefinition: #FacingWest category: 'MarsRover'!
MarsRoverState subclass: #FacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!
