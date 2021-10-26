!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'AF 10/25/2021 20:40:39'!
test01DoesNotMoveWhenNoCommand

	self 
	
		assertIsAt: 1@2 
		
		heading: self north 
		
		afterProcessing: '' 
		
		whenStartingAt: 1@2 
		
		heading: self north 
		
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AF 10/25/2021 20:42:03'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AF 10/25/2021 20:42:18'!
test03IsAtFailsForDifferentHeading


	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AF 10/25/2021 20:42:47'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self
	
		assertIsAt: 1@3 
		
		heading: self north 
		
		afterProcessing: 'f' 
		
		whenStartingAt: 1@2 
		
		heading: self north 
		
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'AF 10/25/2021 20:39:49'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'AF 10/25/2021 20:39:59'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'AF 10/25/2021 20:40:07'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'AF 10/25/2021 20:40:11'!
west


	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'AF 10/25/2021 20:39:39'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	

	marsRover process: commands.
	
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverXXXXTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverXXXXTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2021 21:48:27'!
test01

	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackPositionChangesOf: marsRover.
	
	marsRover process: 'f'.
	
	logReadStream _ ReadStream on: x contents.
	
	self assert: '1@2' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 15:31:28'!
test02

	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackHeadingChangesOf: marsRover.
	
	marsRover process: 'ff'.
	
	logReadStream _ ReadStream on: x contents.
	
	self assert: logReadStream atEnd.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 15:35:07'!
test03

	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackHeadingChangesOf: marsRover.
	
	marsRover process: 'ffr'.
	
	logReadStream _ ReadStream on: x contents.
	
	self assert: 'East' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 15:47:40'!
test04

	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackPositionAndHeadingChangesOf: marsRover.
	
	marsRover process: 'ffr'.
	
	logReadStream _ ReadStream on: x contents.
	
	self assert: '1@2' equals: logReadStream nextLine.
	self assert: '1@3' equals: logReadStream nextLine.
	self assert: 'East' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 15:50:35'!
test05

	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	
	x _ self trackPositionAndHeadingChangesOf: marsRover.
	
	marsRover process: 'frfrfr'.
	
	logReadStream _ ReadStream on: x contents.
	
	self assert: '2@1' equals: logReadStream nextLine.
	self assert: 'South' equals: logReadStream nextLine.
	self assert: '2@0' equals: logReadStream nextLine.
	self assert: 'West' equals: logReadStream nextLine.
	self assert: '1@0' equals: logReadStream nextLine.
	self assert: 'North' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 16:49:07'!
test06

	| marsRover x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self track2PositionChangesOf: marsRover.
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: x positionTextFieldModel.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 18:01:16'!
test07

	| marsRover x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self track2HeadingChangesOf: marsRover.
	
	marsRover process: 'fr'.
	
	self assert: 'East' equals: x headingTextFieldModel printString.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 18:07:08'!
test08

	| marsRover x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self track2PositionAndHeadingChangesOf: marsRover.
	
	marsRover process: 'fr'.
	
	self assert: 1@2 equals: x positionTextFieldModel.
	self assert: 'East' equals: x headingTextFieldModel printString.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 17:31:05'!
track2HeadingChangesOf: aMarsRover 
	
	|x|
	
	x := MarsRoverStatusView new.
	aMarsRover trackHeadingChangesToStatusView: x.
	
	^x. ! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 18:07:53'!
track2PositionAndHeadingChangesOf: aMarsRover 
	
	|x|
	
	x := MarsRoverStatusView new.
	aMarsRover trackPositionChangesToStatusView: x.
	aMarsRover trackHeadingChangesToStatusView: x.
	
	^x. ! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 17:32:29'!
track2PositionChangesOf: aMarsRover 
	
	| x |
	x := MarsRoverStatusView new.
	aMarsRover trackPositionChangesToStatusView: x. 
	
	^x.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 15:32:57'!
trackHeadingChangesOf: aMarsRover 
	
	|logger|
	
	logger := WriteStream on: ''.
	
	^aMarsRover trackHeadingChangesTo: logger.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 15:46:48'!
trackPositionAndHeadingChangesOf: aMarsRover 
	
	|logger|
	
	logger := WriteStream on: ''.
	aMarsRover trackHeadingChangesTo: logger.
	aMarsRover trackPositionChangesTo: logger.
	
	^logger.! !

!MarsRoverXXXXTest methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2021 21:42:05'!
trackPositionChangesOf: aMarsRover 
	
	|logger|
	
	logger := WriteStream on: ''.
	
	^aMarsRover trackPositionChangesTo: logger.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionChangesLogger headingChangesLogger positionChangesStatusView headingChangesStatusView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'AF 10/25/2021 20:37:38'!
invalidCommandErrorDescription

	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'AF 10/25/2021 20:37:42'!
signalInvalidCommand

	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'AF 10/25/2021 20:37:50'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	
	head := aHeadingType for: self ! !


!MarsRover methodsFor: 'heading' stamp: 'AF 10/26/2021 17:39:38'!
changeHeadTo: newHeading

	head := newHeading.
	headingChangesLogger ifNotNil: [headingChangesLogger nextPutAll: head printString; newLine].
	headingChangesStatusView ifNotNil: [headingChangesStatusView headingTextFieldModel: head].! !

!MarsRover methodsFor: 'heading' stamp: 'AF 10/26/2021 16:15:31'!
headEast

	self changeHeadTo: (MarsRoverHeadingEast for: self).
	
! !

!MarsRover methodsFor: 'heading' stamp: 'AF 10/26/2021 16:15:50'!
headNorth

	self changeHeadTo: (MarsRoverHeadingNorth for: self).
! !

!MarsRover methodsFor: 'heading' stamp: 'AF 10/26/2021 16:16:07'!
headSouth

	self changeHeadTo: (MarsRoverHeadingSouth for: self).
! !

!MarsRover methodsFor: 'heading' stamp: 'AF 10/26/2021 16:16:26'!
headWest

	self changeHeadTo: (MarsRoverHeadingWest for: self).
! !

!MarsRover methodsFor: 'heading' stamp: 'AF 10/25/2021 20:37:28'!
rotateLeft

	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'AF 10/25/2021 20:37:32'!
rotateRight

	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'AF 10/25/2021 20:37:59'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'AF 10/25/2021 20:38:12'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'AF 10/25/2021 20:38:18'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'AF 10/25/2021 20:38:23'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'AF 10/25/2021 20:38:27'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'AF 10/25/2021 20:38:32'!
moveBackward

	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'AF 10/26/2021 16:10:00'!
moveEast

	self movePositionWith: 1@0.! !

!MarsRover methodsFor: 'moving' stamp: 'AF 10/25/2021 20:38:40'!
moveForward

	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'AF 10/26/2021 16:10:41'!
moveNorth

	self movePositionWith: 0@1.
! !

!MarsRover methodsFor: 'moving' stamp: 'AF 10/26/2021 16:50:57'!
movePositionWith: anOffset

	position := position + anOffset.
	positionChangesLogger ifNotNil:[positionChangesLogger nextPutAll: position printString; newLine ].
	positionChangesStatusView ifNotNil: [positionChangesStatusView positionTextFieldModel: position].! !

!MarsRover methodsFor: 'moving' stamp: 'AF 10/26/2021 16:11:00'!
moveSouth

	self movePositionWith: 0@-1.
! !

!MarsRover methodsFor: 'moving' stamp: 'AF 10/26/2021 16:11:18'!
moveWest

	self movePositionWith: -1@0.
! !


!MarsRover methodsFor: 'command processing' stamp: 'AF 10/25/2021 20:39:00'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]! !

!MarsRover methodsFor: 'command processing' stamp: 'AF 10/25/2021 20:39:17'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 15:33:51'!
trackHeadingChangesTo: aLogger 
	
	^headingChangesLogger := aLogger! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 17:34:25'!
trackHeadingChangesToStatusView: aMarsRoverStatusView 
	
	headingChangesStatusView :=  aMarsRoverStatusView.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2021 21:45:16'!
trackPositionChangesTo: aLogger

	^positionChangesLogger := aLogger.
	
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 17:31:49'!
trackPositionChangesToStatusView: aMarsRoverStatusView 
	
	positionChangesStatusView :=  aMarsRoverStatusView.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'AF 10/26/2021 17:52:03'!
at: aPosition heading: aHeadingType

	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'AF 10/25/2021 20:36:35'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'AF 10/25/2021 20:36:39'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'AF 10/25/2021 20:36:45'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'AF 10/25/2021 20:36:51'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'AF 10/25/2021 20:36:55'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'AF 10/25/2021 20:37:02'!
initializeFor: aMarsRover 

	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'AF 10/26/2021 17:46:30'!
for: aMarsRover 

	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'AF 10/25/2021 20:34:47'!
moveBackward

	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'AF 10/25/2021 20:34:55'!
moveForward

	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'AF 10/25/2021 20:34:41'!
rotateLeft

	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'AF 10/25/2021 20:34:34'!
rotateRight

	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'printing' stamp: 'AF 10/26/2021 18:01:26'!
printOn: aStream 
	
	aStream nextPutAll: 'East'! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'AF 10/25/2021 20:35:10'!
moveBackward

	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'AF 10/25/2021 20:35:14'!
moveForward

	^marsRover moveNorth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'AF 10/26/2021 16:00:29'!
printOn: aStream 
	
	aStream nextPutAll: 'North'! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'AF 10/25/2021 20:35:26'!
rotateLeft

	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'AF 10/25/2021 20:35:31'!
rotateRight


	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'AF 10/25/2021 20:35:48'!
moveBackward

	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'AF 10/25/2021 20:35:53'!
moveForward

	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'AF 10/25/2021 20:35:37'!
rotateLeft

	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'AF 10/25/2021 20:35:42'!
rotateRight

	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 16:01:16'!
printOn: aStream 
	
	aStream nextPutAll: 'South'! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'AF 10/25/2021 20:36:09'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'AF 10/25/2021 20:36:14'!
moveForward

	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'AF 10/25/2021 20:36:21'!
rotateLeft

	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'AF 10/25/2021 20:36:25'!
rotateRight

	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 16:01:26'!
printOn: aStream 
	
	aStream nextPutAll: 'West'! !


!classDefinition: #MarsRoverStatusView category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverStatusView
	instanceVariableNames: 'positionTextFieldModel headingTextFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 17:35:51'!
headingTextFieldModel
	
	^headingTextFieldModel.! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 17:42:59'!
headingTextFieldModel: aMarsRoverHeading
	
	headingTextFieldModel := aMarsRoverHeading! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 16:53:48'!
positionTextFieldModel
	
	^positionTextFieldModel ! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'AF 10/26/2021 16:52:02'!
positionTextFieldModel: aPosition
	
	positionTextFieldModel := aPosition! !
