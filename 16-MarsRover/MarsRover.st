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

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 15:58:16'!
test15ProcessMultipleCommands
	| marsRover |
	"Este test lo agregamos por fuera del proceso de TDD ya que por la decisión que se dió en clase temprano de implementar en process la ejecución de comandos con un:
		aSequenceOfCommands do: [:aCommand | ...]
	la situación de correr varios comandos se resolvió desde muy temprano.
	Decidimos agregar este test de todos modos por completitud."
	marsRover _ MarsRover at: 1@2 facing: #South.
	
	marsRover process: 'bbr'.
	
	self assert: (marsRover isAt: 1@4 facing: #West).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position facingDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'movement' stamp: 'MK 10/6/2021 17:06:18'!
moveBackward

	position _ facingDirection backwardFrom: position.! !

!MarsRover methodsFor: 'movement' stamp: 'MK 10/6/2021 17:06:17'!
moveForward

	position _ facingDirection forwardFrom: position.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 17:09:51'!
changeFacingDirectionTo: aCardinalDirection

	facingDirection _ MarsRoverFacingDirection newWith: aCardinalDirection.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 16:40:26'!
process: aSequenceOfCommands 
	| noMatch |
	aSequenceOfCommands do: [:aCommand | 
		noMatch _ true.
		aCommand = $f ifTrue: [
			self moveForward.
			noMatch _ false.
		].
		aCommand = $b ifTrue: [
			self moveBackward.
			noMatch _ false.
		].
		aCommand = $l ifTrue: [			
			self rotateLeft.
			noMatch _ false
		].
		aCommand = $r ifTrue: [
			self rotateRight.
			noMatch _ false
		].
		noMatch ifTrue: [^ self].
	].! !


!MarsRover methodsFor: 'rotation' stamp: 'MK 10/6/2021 17:10:26'!
rotateLeft

	self changeFacingDirectionTo: (facingDirection directionAfterRotatingLeft).! !

!MarsRover methodsFor: 'rotation' stamp: 'MK 10/6/2021 17:10:40'!
rotateRight

	self changeFacingDirectionTo: (facingDirection directionAfterRotatingRight).! !


!MarsRover methodsFor: 'initialization' stamp: 'MK 10/6/2021 17:07:56'!
initializeAt: aPosition facing: aCardinalDirection
	position := aPosition.
	facingDirection := MarsRoverFacingDirection newWith: aCardinalDirection.! !


!MarsRover methodsFor: 'assertion' stamp: 'MK 10/6/2021 17:14:32'!
isAt: aPosition facing: aCardinalDirection 

	^ position = aPosition and: [facingDirection asCardinalDirection = aCardinalDirection].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'MK 10/6/2021 17:08:23'!
at: aPosition facing: aCardinalDirection 
	^ self new initializeAt: aPosition facing: aCardinalDirection.! !


!classDefinition: #MarsRoverFacingDirection category: 'MarsRover'!
Object subclass: #MarsRoverFacingDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverFacingDirection methodsFor: 'class initialization' stamp: 'MK 10/6/2021 17:14:16'!
asCardinalDirection
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingDirection class' category: 'MarsRover'!
MarsRoverFacingDirection class
	instanceVariableNames: ''!

!MarsRoverFacingDirection class methodsFor: 'class initialization' stamp: 'MK 10/6/2021 17:07:56'!
newWith: aDirection
	aDirection = #South ifTrue: [^ FacingSouth new].
	aDirection = #North ifTrue: [^ FacingNorth new].
	aDirection = #West ifTrue: [^ FacingWest new].
	aDirection = #East ifTrue: [^ FacingEast new].! !


!classDefinition: #FacingEast category: 'MarsRover'!
MarsRoverFacingDirection subclass: #FacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingEast methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 17:14:16'!
asCardinalDirection
	^ #East! !

!FacingEast methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 15:53:38'!
backwardFrom: aPosition
	^ aPosition - (1@0).! !

!FacingEast methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 16:05:17'!
directionAfterRotatingLeft
	^ #North! !

!FacingEast methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 16:07:05'!
directionAfterRotatingRight
	^ #South! !

!FacingEast methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 15:01:34'!
forwardFrom: aPosition
	^ aPosition + (1@0).! !


!classDefinition: #FacingNorth category: 'MarsRover'!
MarsRoverFacingDirection subclass: #FacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 17:14:16'!
asCardinalDirection
	^ #North! !

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 15:53:43'!
backwardFrom: aPosition
	^ aPosition - (0@1).! !

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 16:05:33'!
directionAfterRotatingLeft
	^ #West! !

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 16:07:12'!
directionAfterRotatingRight
	^ #East! !

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 15:01:47'!
forwardFrom: aPosition
	^ aPosition + (0@1).! !


!classDefinition: #FacingSouth category: 'MarsRover'!
MarsRoverFacingDirection subclass: #FacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 17:14:16'!
asCardinalDirection
	^ #South! !

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 15:53:48'!
backwardFrom: aPosition
	^ aPosition + (0@1).! !

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 16:05:46'!
directionAfterRotatingLeft
	^ #East! !

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 16:07:20'!
directionAfterRotatingRight
	^ #West! !

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 15:02:24'!
forwardFrom: aPosition
	^ aPosition - (0@1).! !


!classDefinition: #FacingWest category: 'MarsRover'!
MarsRoverFacingDirection subclass: #FacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingWest methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 17:14:16'!
asCardinalDirection
	^ #West! !

!FacingWest methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 15:53:51'!
backwardFrom: aPosition
	^ aPosition + (1@0).! !

!FacingWest methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 16:05:54'!
directionAfterRotatingLeft
	^ #South! !

!FacingWest methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 16:07:30'!
directionAfterRotatingRight
	^ #North! !

!FacingWest methodsFor: 'as yet unclassified' stamp: 'MK 10/6/2021 15:02:29'!
forwardFrom: aPosition
	^ aPosition - (1@0).! !
