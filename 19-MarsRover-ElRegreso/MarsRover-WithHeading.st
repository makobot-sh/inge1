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


!classDefinition: #MarsRoverTrackingTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTrackingTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTrackingTest methodsFor: 'set up' stamp: 'AF 10/27/2021 19:47:34'!
headingLoggerOn: marsRover

	^ MarsRoverLogger trackHeadingOf: marsRover! !

!MarsRoverTrackingTest methodsFor: 'set up' stamp: 'AF 10/27/2021 19:48:49'!
headingStatusViewOn: marsRover

	^ MarsRoverStatusView trackHeadingOf: marsRover! !

!MarsRoverTrackingTest methodsFor: 'set up' stamp: 'AF 10/27/2021 19:48:00'!
positionAndHeadingLoggerOn: marsRover

	^ MarsRoverLogger trackPositionAndHeadingOf: marsRover! !

!MarsRoverTrackingTest methodsFor: 'set up' stamp: 'AF 10/27/2021 19:49:14'!
positionAndHeadingStatusViewOn: marsRover

	^ MarsRoverStatusView trackPositionAndHeadingOf: marsRover! !

!MarsRoverTrackingTest methodsFor: 'set up' stamp: 'AF 10/27/2021 19:42:49'!
positionLoggerOn: marsRover

	^ MarsRoverLogger trackPositionOf: marsRover! !

!MarsRoverTrackingTest methodsFor: 'set up' stamp: 'AF 10/27/2021 19:48:20'!
positionStatusViewOn: marsRover

	^ MarsRoverStatusView trackPositionOf: marsRover! !


!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:01:53'!
test01PositionLoggerRegistersFirstPositionChange

	| marsRover logReadStream logger |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger _ self positionLoggerOn: marsRover.
	
	marsRover process: 'f'.
	
	logReadStream _ ReadStream on: logger log.
	
	self assert: '1@2' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:01:44'!
test02HeadinLoggerDoesNotRegisterPositionChanges

	| marsRover logReadStream logger |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger _ self headingLoggerOn: marsRover.
	
	marsRover process: 'ff'.
	
	logReadStream _ ReadStream on: logger log.
	
	self assert: logReadStream atEnd.! !

!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:04:00'!
test03HeadingLoggerRegistersFirstHeadingChange

	| marsRover logReadStream logger |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger _ self headingLoggerOn: marsRover.
	
	marsRover process: 'ffr'.
	
	logReadStream _ ReadStream on: logger log.
	
	self assert: 'East' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:07:27'!
test04PositionAndHeadingLoggerRegistersBothTypesOfChanges

	| marsRover logReadStream logger |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger _ self positionAndHeadingLoggerOn: marsRover.
	
	marsRover process: 'ffr'.
	
	logReadStream _ ReadStream on: logger log.
	
	self assert: '1@2' equals: logReadStream nextLine.
	self assert: '1@3' equals: logReadStream nextLine.
	self assert: 'East' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:08:04'!
test05PositionAndHeadingLoggerRegistersAllChangesInAllDirections

	| marsRover logReadStream logger |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	
	logger _ self positionAndHeadingLoggerOn: marsRover.
	
	marsRover process: 'frfrfr'.
	
	logReadStream _ ReadStream on: logger log.
	
	self assert: '2@1' equals: logReadStream nextLine.
	self assert: 'South' equals: logReadStream nextLine.
	self assert: '2@0' equals: logReadStream nextLine.
	self assert: 'West' equals: logReadStream nextLine.
	self assert: '1@0' equals: logReadStream nextLine.
	self assert: 'North' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:10:11'!
test06PositionStatusViewUpdatesWithOneMovementCommand

	| marsRover statusView |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusView _ self positionStatusViewOn: marsRover.
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: statusView marsRoverPosition.! !

!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:10:17'!
test07HeadingStatusViewUpdatesWithOneRotationCommand

	| marsRover statusView |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusView _ self headingStatusViewOn: marsRover.
	
	marsRover process: 'r'.
	
	self assert: 'East' equals: statusView marsRoverHeading printString.! !

!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:11:12'!
test08PositionAndHeadingStatusViewUpdatesWithOneMovementAndOneRotation

	| marsRover statusView |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusView _ self positionAndHeadingStatusViewOn: marsRover.
	
	marsRover process: 'fr'.
	
	self assert: 1@2 equals: statusView marsRoverPosition.
	self assert: 'East' equals: statusView marsRoverHeading printString.! !

!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:12:18'!
test09TwoLoggersOnSameMarsRoverSetAtDifferentTimesWorkProperly

	| marsRover logger1 logger2 logReadStream|
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	logger1 _ self positionAndHeadingLoggerOn: marsRover.
	
	marsRover process: 'fr'.
	
	logger2 _ self positionAndHeadingLoggerOn: marsRover.
	
	marsRover process: 'fr'.
	
	logReadStream _ ReadStream on: logger1 log.
	
	self assert: '1@2' equals: logReadStream nextLine.
	self assert: 'East' equals: logReadStream nextLine.
	self assert: '2@2' equals: logReadStream nextLine.
	self assert: 'South' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.

	logReadStream _ ReadStream on: logger2 log.

	self assert: '2@2' equals: logReadStream nextLine.
	self assert: 'South' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!MarsRoverTrackingTest methodsFor: 'tests' stamp: 'AF 10/27/2021 20:13:42'!
test10TwoStatusViewOnSameMarsRoverSetAtDifferentTimesHaveTheSameValues

	| marsRover statusView1 statusView2 |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusView1 _ self positionAndHeadingStatusViewOn: marsRover.
	
	marsRover process: 'fr'.
	
	statusView2 _ self positionAndHeadingStatusViewOn: marsRover.
	
	marsRover process: 'fr'.
	
	self assert: 2@2 equals: statusView1 marsRoverPosition.
	self assert: 'South' equals: statusView1 marsRoverHeading printString.
	
	self assert: 2@2 equals: statusView2 marsRoverPosition.
	self assert: 'South' equals: statusView2 marsRoverHeading printString.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionChangesTrackers headingChangesTrackers positionChangesStatusView headingChangesStatusView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'AF 10/25/2021 20:37:38'!
invalidCommandErrorDescription

	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'AF 10/25/2021 20:37:42'!
signalInvalidCommand

	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'AF 10/27/2021 17:46:32'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	
	head := aHeadingType for: self .
	
	positionChangesTrackers := OrderedCollection new.
	
	headingChangesTrackers := OrderedCollection new.
	
	positionChangesStatusView := OrderedCollection new.
	
	headingChangesStatusView := OrderedCollection new.
	! !


!MarsRover methodsFor: 'heading' stamp: 'Chiro 10/28/2021 16:36:39'!
changeHeadTo: newHeading

	head := newHeading.
	self updateAllHeadingTrackers.! !

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

!MarsRover methodsFor: 'heading' stamp: 'Chiro 10/28/2021 16:36:39'!
updateAllHeadingTrackers

	^ headingChangesTrackers do: [:aTracker | aTracker updateHeading: head copy]! !


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


!MarsRover methodsFor: 'moving' stamp: 'Chiro 10/28/2021 16:37:06'!
UpdateAllPositionTrackers

	^ positionChangesTrackers do: [:aTracker | aTracker updatePosition: position copy]! !

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

!MarsRover methodsFor: 'moving' stamp: 'Chiro 10/28/2021 16:37:06'!
movePositionWith: anOffset

	position := position + anOffset.
	self UpdateAllPositionTrackers.! !

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


!MarsRover methodsFor: 'tracking' stamp: 'AF 10/27/2021 17:46:22'!
addHeadingTracker: aTracker 
	
	headingChangesTrackers add: aTracker.! !

!MarsRover methodsFor: 'tracking' stamp: 'AF 10/27/2021 17:46:32'!
addPositionTracker: aTracker

	positionChangesTrackers add: aTracker.
	
	
	
	
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


!MarsRoverHeading methodsFor: 'printing' stamp: 'AF 10/27/2021 19:54:05'!
printOn: aStream

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


!classDefinition: #MarsRoverTracker category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTracker methodsFor: 'initialization' stamp: 'AF 10/27/2021 19:25:32'!
initializeWith: aMarsRover

! !

!MarsRoverTracker methodsFor: 'initialization' stamp: 'AF 10/27/2021 19:19:28'!
notifyHeadingTrackingTo: aMarsRover

	^ aMarsRover addHeadingTracker: self! !

!MarsRoverTracker methodsFor: 'initialization' stamp: 'AF 10/27/2021 19:19:41'!
notifyPositionTrackingTo: aMarsRover

	^ aMarsRover addPositionTracker: self! !

!MarsRoverTracker methodsFor: 'initialization' stamp: 'AF 10/27/2021 19:24:12'!
trackHeadingOf: aMarsRover

	self initializeWith: aMarsRover.

	self notifyHeadingTrackingTo: aMarsRover.! !

!MarsRoverTracker methodsFor: 'initialization' stamp: 'AF 10/27/2021 19:24:02'!
trackPositionAndHeadingOf: aMarsRover

	self initializeWith: aMarsRover.

	self notifyHeadingTrackingTo: aMarsRover.
	self notifyPositionTrackingTo: aMarsRover.! !

!MarsRoverTracker methodsFor: 'initialization' stamp: 'AF 10/27/2021 19:24:21'!
trackPositionOf: aMarsRover

	self initializeWith: aMarsRover.

	self notifyPositionTrackingTo: aMarsRover.
! !


!MarsRoverTracker methodsFor: 'updating' stamp: 'AF 10/27/2021 17:52:55'!
updateHeading: aHeading

	^self subclassResponsibility .! !

!MarsRoverTracker methodsFor: 'updating' stamp: 'AF 10/27/2021 17:53:16'!
updatePosition: aPosition

	^self subclassResponsibility .! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverTracker subclass: #MarsRoverLogger
	instanceVariableNames: 'logStream loggee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'AF 10/27/2021 19:32:29'!
initializeWith: aMarsRover

	logStream := WriteStream on: ''.! !


!MarsRoverLogger methodsFor: 'updating' stamp: 'AF 10/27/2021 19:32:29'!
log: aPositionOrHeading
	
	logStream nextPutAll: aPositionOrHeading printString; newLine.! !

!MarsRoverLogger methodsFor: 'updating' stamp: 'AF 10/27/2021 17:52:55'!
updateHeading: aHeading
	
	self log: aHeading .! !

!MarsRoverLogger methodsFor: 'updating' stamp: 'AF 10/27/2021 17:53:16'!
updatePosition: aPosition
	
	self log: aPosition .! !


!MarsRoverLogger methodsFor: 'accessing' stamp: 'AF 10/27/2021 19:32:29'!
log
	
	^logStream contents! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'AF 10/27/2021 19:14:25'!
trackHeadingOf: aMarsRover

	^self new trackHeadingOf: aMarsRover.! !

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'AF 10/27/2021 19:15:03'!
trackPositionAndHeadingOf: aMarsRover

	^self new trackPositionAndHeadingOf: aMarsRover.! !

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'AF 10/27/2021 19:14:49'!
trackPositionOf: aMarsRover

	^self new trackPositionOf: aMarsRover.! !


!classDefinition: #MarsRoverStatusView category: 'MarsRover-WithHeading'!
MarsRoverTracker subclass: #MarsRoverStatusView
	instanceVariableNames: 'MarsRoverPosition MarsRoverHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusView methodsFor: 'updating' stamp: 'AF 10/27/2021 17:52:55'!
updateHeading: aMarsRoverHeading
	
	MarsRoverHeading := aMarsRoverHeading! !

!MarsRoverStatusView methodsFor: 'updating' stamp: 'AF 10/27/2021 17:53:16'!
updatePosition: aPosition
	
	MarsRoverPosition := aPosition! !


!MarsRoverStatusView methodsFor: 'accessing' stamp: 'AF 10/27/2021 19:26:28'!
marsRoverHeading
	
	^MarsRoverHeading.! !

!MarsRoverStatusView methodsFor: 'accessing' stamp: 'AF 10/27/2021 19:26:20'!
marsRoverPosition
	
	^MarsRoverPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverStatusView class' category: 'MarsRover-WithHeading'!
MarsRoverStatusView class
	instanceVariableNames: ''!

!MarsRoverStatusView class methodsFor: 'as yet unclassified' stamp: 'AF 10/27/2021 17:42:37'!
trackHeadingOf: aMarsRover

	^self new trackHeadingOf: aMarsRover.! !

!MarsRoverStatusView class methodsFor: 'as yet unclassified' stamp: 'AF 10/27/2021 17:42:53'!
trackPositionAndHeadingOf: aMarsRover

	^self new trackPositionAndHeadingOf: aMarsRover.! !

!MarsRoverStatusView class methodsFor: 'as yet unclassified' stamp: 'AF 10/27/2021 17:42:26'!
trackPositionOf: aMarsRover

	^self new trackPositionOf: aMarsRover.! !
