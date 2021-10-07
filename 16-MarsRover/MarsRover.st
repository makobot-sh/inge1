!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:30:28'!
test01NoCommands
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
		
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 facing: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:30:35'!
test02MoveForwardFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 facing: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:30:47'!
test03BackwardsFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 facing: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:30:51'!
test04RotateLeftFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 facing: #West).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:22:25'!
test05RotateLeftFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 facing: #East).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:22:26'!
test06RotateLeftFacingWest
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 facing: #South).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:30:57'!
test07RotateLeftFacingEast
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 facing: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:31:01'!
test08RotateRightFacingNorth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 facing: #East).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:22:25'!
test09RotateRightFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #South.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 facing: #West).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:31:44'!
test10CommandsAfterInvalidCommandAreDiscarded
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #North.
	
	marsRover process: 'fWr'.
	
	self assert: (marsRover isAt: 1@3 facing: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:22:25'!
test11MoveForwardFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #South.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@1 facing: #South).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:22:25'!
test12MoveForwardFacingEast
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 facing: #East).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:22:26'!
test13MoveForwardFacingWest
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #West.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 0@2 facing: #West).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MK 10/5/2021 18:22:25'!
test14MoveBackwardsFacingSouth
	| marsRover|
	marsRover _ MarsRover at: 1@2 facing: #South.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@3 facing: #South).! !


!classDefinition: #CustomizableCommand category: 'MarsRover'!
Object subclass: #CustomizableCommand
	instanceVariableNames: 'command action'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CustomizableCommand methodsFor: 'initialization' stamp: 'MK 10/7/2021 15:36:26'!
initializeFor: aCommandString  withAction: anActionClosure.

	command := aCommandString .
	action := anActionClosure .! !


!CustomizableCommand methodsFor: 'assertion' stamp: 'MK 10/7/2021 15:36:26'!
isFor: aCommandCharacter

	^command = aCommandCharacter asString.! !


!CustomizableCommand methodsFor: 'execution' stamp: 'MK 10/7/2021 15:36:44'!
executeAction
	
	action value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomizableCommand class' category: 'MarsRover'!
CustomizableCommand class
	instanceVariableNames: ''!

!CustomizableCommand class methodsFor: 'initialization' stamp: 'MK 10/7/2021 15:51:11'!
for: aCommandString withAction: anActionClosure
	
	^ CustomizableCommand new initializeFor: aCommandString withAction: anActionClosure.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position state commands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'movement' stamp: 'MK 10/7/2021 16:04:55'!
moveBackward

	position _ state backwardFrom: position.! !

!MarsRover methodsFor: 'movement' stamp: 'MK 10/7/2021 16:04:55'!
moveForward

	position _ state forwardFrom: position.! !


!MarsRover methodsFor: 'rotation' stamp: 'MK 10/7/2021 16:04:55'!
changeFacingDirectionTo: aCardinalDirection

	state _ MarsRoverState newWith: aCardinalDirection.! !

!MarsRover methodsFor: 'rotation' stamp: 'MK 10/7/2021 16:04:55'!
rotateLeft

	self changeFacingDirectionTo: (state directionAfterRotatingLeft).! !

!MarsRover methodsFor: 'rotation' stamp: 'MK 10/7/2021 16:04:55'!
rotateRight

	self changeFacingDirectionTo: (state directionAfterRotatingRight).! !


!MarsRover methodsFor: 'initialization' stamp: 'MK 10/7/2021 16:04:55'!
initializeAt: aPosition facing: aCardinalDirection
	position := aPosition.
	state := MarsRoverState newWith: aCardinalDirection.
	commands := OrderedCollection 
				with:( CustomizableCommand for: 'f' withAction: [self moveForward]) 
				with:( CustomizableCommand for: 'b' withAction: [self moveBackward]) 
				with:( CustomizableCommand for: 'l' withAction: [self rotateLeft ]) 
				with:( CustomizableCommand for: 'r' withAction: [self rotateRight ]).! !


!MarsRover methodsFor: 'assertion' stamp: 'MK 10/7/2021 16:07:36'!
isAt: aPosition facing: aCardinalDirection 

	^ position = aPosition and: [state facingDirection = aCardinalDirection].! !


!MarsRover methodsFor: 'execution' stamp: 'MK 10/7/2021 15:50:12'!
executeCommand: aCommandString ifInvalid: aClosure
	
	(commands 	detect: [:aCommand | aCommand isFor: aCommandString ] 
			   ifNone: aClosure ) executeAction.! !

!MarsRover methodsFor: 'execution' stamp: 'MK 10/7/2021 15:48:38'!
process: aSequenceOfCommands

	aSequenceOfCommands do: 
	[:aCommandString | 
		self executeCommand: aCommandString ifInvalid: [^ self].
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'MK 10/6/2021 17:08:23'!
at: aPosition facing: aCardinalDirection 
	^ self new initializeAt: aPosition facing: aCardinalDirection.! !


!classDefinition: #MarsRoverState category: 'MarsRover'!
Object subclass: #MarsRoverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverState methodsFor: 'properties' stamp: 'MK 10/7/2021 16:07:36'!
facingDirection
	self subclassResponsibility ! !


!MarsRoverState methodsFor: 'movement' stamp: 'MK 10/7/2021 16:05:52'!
backwardFrom: aPosition
	self subclassResponsibility ! !

!MarsRoverState methodsFor: 'movement' stamp: 'MK 10/7/2021 16:05:59'!
forwardFrom: aPosition
	self subclassResponsibility ! !


!MarsRoverState methodsFor: 'rotation' stamp: 'MK 10/7/2021 16:06:11'!
directionAfterRotatingLeft
	self subclassResponsibility ! !

!MarsRoverState methodsFor: 'rotation' stamp: 'MK 10/7/2021 16:06:14'!
directionAfterRotatingRight
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverState class' category: 'MarsRover'!
MarsRoverState class
	instanceVariableNames: ''!

!MarsRoverState class methodsFor: 'initialization' stamp: 'MK 10/6/2021 17:07:56'!
newWith: aDirection
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

!FacingEast methodsFor: 'rotation' stamp: 'MK 10/6/2021 16:05:17'!
directionAfterRotatingLeft
	^ #North! !

!FacingEast methodsFor: 'rotation' stamp: 'MK 10/6/2021 16:07:05'!
directionAfterRotatingRight
	^ #South! !


!FacingEast methodsFor: 'movement' stamp: 'MK 10/6/2021 15:53:38'!
backwardFrom: aPosition
	^ aPosition - (1@0).! !

!FacingEast methodsFor: 'movement' stamp: 'MK 10/6/2021 15:01:34'!
forwardFrom: aPosition
	^ aPosition + (1@0).! !


!FacingEast methodsFor: 'properties' stamp: 'MK 10/7/2021 16:07:36'!
facingDirection
	^ #East! !


!classDefinition: #FacingNorth category: 'MarsRover'!
MarsRoverState subclass: #FacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingNorth methodsFor: 'rotation' stamp: 'MK 10/6/2021 16:05:33'!
directionAfterRotatingLeft
	^ #West! !

!FacingNorth methodsFor: 'rotation' stamp: 'MK 10/6/2021 16:07:12'!
directionAfterRotatingRight
	^ #East! !


!FacingNorth methodsFor: 'movement' stamp: 'MK 10/6/2021 15:53:43'!
backwardFrom: aPosition
	^ aPosition - (0@1).! !

!FacingNorth methodsFor: 'movement' stamp: 'MK 10/6/2021 15:01:47'!
forwardFrom: aPosition
	^ aPosition + (0@1).! !


!FacingNorth methodsFor: 'properties' stamp: 'MK 10/7/2021 16:07:36'!
facingDirection
	^ #North! !


!classDefinition: #FacingSouth category: 'MarsRover'!
MarsRoverState subclass: #FacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingSouth methodsFor: 'rotation' stamp: 'MK 10/6/2021 16:05:46'!
directionAfterRotatingLeft
	^ #East! !

!FacingSouth methodsFor: 'rotation' stamp: 'MK 10/6/2021 16:07:20'!
directionAfterRotatingRight
	^ #West! !


!FacingSouth methodsFor: 'movement' stamp: 'MK 10/6/2021 15:53:48'!
backwardFrom: aPosition
	^ aPosition + (0@1).! !

!FacingSouth methodsFor: 'movement' stamp: 'MK 10/6/2021 15:02:24'!
forwardFrom: aPosition
	^ aPosition - (0@1).! !


!FacingSouth methodsFor: 'properties' stamp: 'MK 10/7/2021 16:07:36'!
facingDirection
	^ #South! !


!classDefinition: #FacingWest category: 'MarsRover'!
MarsRoverState subclass: #FacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingWest methodsFor: 'properties' stamp: 'MK 10/7/2021 16:07:36'!
facingDirection
	^ #West! !


!FacingWest methodsFor: 'movement' stamp: 'MK 10/6/2021 15:53:51'!
backwardFrom: aPosition
	^ aPosition + (1@0).! !

!FacingWest methodsFor: 'movement' stamp: 'MK 10/6/2021 15:02:29'!
forwardFrom: aPosition
	^ aPosition - (1@0).! !


!FacingWest methodsFor: 'rotation' stamp: 'MK 10/6/2021 16:05:54'!
directionAfterRotatingLeft
	^ #South! !

!FacingWest methodsFor: 'rotation' stamp: 'MK 10/6/2021 16:07:30'!
directionAfterRotatingRight
	^ #North! !
