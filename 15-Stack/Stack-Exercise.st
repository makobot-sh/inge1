!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/20/2021 15:35:55'!
test01StackEmptyShouldReturnEmptyCollection

	|stack matchingSentences finder|
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	matchingSentences := finder findAllSentencesWith: 'Macarena' .
	
	self assert: matchingSentences isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/20/2021 15:32:04'!
test02PrefixWithSpacesShouldThrowError

	|stack finder|
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	self	
		should: [finder findAllSentencesWith: 'Invalid prefix' ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix invalidPrefixWithSpaces].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/20/2021 15:32:11'!
test03EmptyPrefixShouldThrowError

	|stack finder|
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	self	
		should: [finder findAllSentencesWith: '' ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix invalidPrefixEmpty].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/20/2021 15:36:07'!
test04StackWithOneElementThatMatchesPrefix

	|stack matchingSentences finder|
	stack := OOStack new.
	stack push: 'Tomas'.
	finder := SentenceFinderByPrefix with:stack.
	matchingSentences := finder findAllSentencesWith: 'Tom' .
	
	self assert: matchingSentences = (OrderedCollection with: 'Tomas').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/20/2021 15:36:13'!
test05StackWithOneElementThatDoesNotMatchPrefix

	|stack matchingSentences finder|
	stack := OOStack new.
	stack push: 'Tomas'.
	finder := SentenceFinderByPrefix with:stack.
	matchingSentences := finder findAllSentencesWith: 'Agus' .
	
	self assert: matchingSentences = (OrderedCollection new).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/20/2021 15:36:18'!
test06StackWithOneElementThatDoesNotMatchPrefixCase

	|stack matchingSentences finder|
	stack := OOStack new.
	stack push: 'Tomas'.
	finder := SentenceFinderByPrefix with:stack.
	matchingSentences := finder findAllSentencesWith: 'tomas' .
	
	self assert: matchingSentences = (OrderedCollection new).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/20/2021 16:18:35'!
test07StackWithMultipleMatches

	|stack matchingSentences finder collectionOfSentences|
	
	
	collectionOfSentences := OrderedCollection with: 'Tomas' with: 'Macarena no va a salir' with: 'Tomas estuvo' with: 'Agustin tampoco' with: 'Tomas estuvo aqui'.
	stack := self createStackWith: collectionOfSentences.
	
	finder := SentenceFinderByPrefix with:stack.
	matchingSentences := finder findAllSentencesWith: 'Tomas' .
	
	self assert: matchingSentences = (OrderedCollection with: 'Tomas' with: 'Tomas estuvo' with: 'Tomas estuvo aqui').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/20/2021 16:18:35'!
test08StackWithMultipleMatchesButWrongCases

	|stack matchingSentences finder collectionOfSentences|
	
	
	collectionOfSentences := OrderedCollection with: 'Tomas' with: 'MaCarena no va a salir' with: 'TOmas estuvo' with: 'Agustin tampoco' with: 'TOMAS estuvo aqui'.
	stack := self createStackWith: collectionOfSentences.
	
	finder := SentenceFinderByPrefix with:stack.
	matchingSentences := finder findAllSentencesWith: 'Tomas' .
	
	self assert: matchingSentences = (OrderedCollection with: 'Tomas').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/20/2021 16:18:35'!
test09StackDoesNotGetModified
	|stack stackClone matchingSentences finder collectionOfSentences|
	
	collectionOfSentences := OrderedCollection with: 'Tomas' with: 'MaCarena no va a salir' with: 'TOmas estuvo' with: 'Agustin tampoco' with: 'TOMAS estuvo aqui'.
	
	stack := self createStackWith: collectionOfSentences.
	stackClone := self createStackWith: collectionOfSentences.
	
	finder := SentenceFinderByPrefix with:stack.
	matchingSentences := finder findAllSentencesWith: 'Tomas' .
	[stackClone isEmpty not & stack isEmpty not] whileTrue: [
		self assert: stackClone pop = stack pop
	]
	
	
! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'Chiro 9/20/2021 16:18:35'!
createStackWith: aCollectionOfSentences
	|stack|
	stack := OOStack new.
	aCollectionOfSentences do: [:aSentence | stack push: aSentence].
	^stack! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elementContainerList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'MK 9/19/2021 18:07:27'!
initialize
	elementContainerList  := OrderedCollection new.
	

	! !


!OOStack methodsFor: 'operations' stamp: 'Chiro 9/18/2021 14:55:29'!
isEmpty 

	^elementContainerList isEmpty.! !

!OOStack methodsFor: 'operations' stamp: 'Chiro 9/18/2021 14:54:17'!
pop
	
	|returnedString|

	returnedString _ self top.
	elementContainerList removeLast.
	^returnedString.
					
! !

!OOStack methodsFor: 'operations' stamp: 'Chiro 9/18/2021 14:54:23'!
push: anItem

	elementContainerList add: anItem.
	! !

!OOStack methodsFor: 'operations' stamp: 'Chiro 9/18/2021 14:55:21'!
size
 
	^elementContainerList size.! !

!OOStack methodsFor: 'operations' stamp: 'MK 9/19/2021 18:08:12'!
top
	^ (OOStackStateMachine with: self) top.
	
! !

!OOStack methodsFor: 'operations' stamp: 'Chiro 9/18/2021 14:47:12'!
topEmpty
	^self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'operations' stamp: 'Chiro 9/18/2021 14:46:52'!
topNotEmpty
	^elementContainerList last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackStateMachine category: 'Stack-Exercise'!
Object subclass: #OOStackStateMachine
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateMachine methodsFor: 'initialization' stamp: 'MK 9/19/2021 17:52:26'!
initializeWith: aStack
	^ self subclassResponsibility.! !


!OOStackStateMachine methodsFor: 'operations' stamp: 'MK 9/19/2021 18:01:39'!
top
	^ self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateMachine class' category: 'Stack-Exercise'!
OOStackStateMachine class
	instanceVariableNames: ''!

!OOStackStateMachine class methodsFor: 'initialization' stamp: 'MK 9/19/2021 17:51:25'!
with: aStack
	^ (self subclasses detect:[:aStackState | aStackState canHandle: aStack]) with: aStack.! !


!OOStackStateMachine class methodsFor: 'class definition' stamp: 'MK 9/19/2021 17:57:37'!
canHandle: aStack
	^ self subclassResponsibility.! !


!classDefinition: #OOStackEmptyState category: 'Stack-Exercise'!
OOStackStateMachine subclass: #OOStackEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyState methodsFor: 'initialization' stamp: 'MK 9/19/2021 17:54:18'!
initializeWith: aStack
	stack := aStack.! !


!OOStackEmptyState methodsFor: 'operations' stamp: 'MK 9/19/2021 18:01:39'!
top
	^ stack topEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackEmptyState class' category: 'Stack-Exercise'!
OOStackEmptyState class
	instanceVariableNames: ''!

!OOStackEmptyState class methodsFor: 'initialization' stamp: 'MK 9/19/2021 17:53:02'!
with: aStack
	^ self new initializeWith: aStack.! !


!OOStackEmptyState class methodsFor: 'class definition' stamp: 'MK 9/19/2021 17:45:23'!
canHandle: aStack
	^ aStack isEmpty.! !


!classDefinition: #OOStackNotEmptyState category: 'Stack-Exercise'!
OOStackStateMachine subclass: #OOStackNotEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNotEmptyState methodsFor: 'initialization' stamp: 'MK 9/19/2021 17:54:33'!
initializeWith: aStack
	stack := aStack.! !


!OOStackNotEmptyState methodsFor: 'operations' stamp: 'MK 9/19/2021 18:01:40'!
top
	^ stack topNotEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNotEmptyState class' category: 'Stack-Exercise'!
OOStackNotEmptyState class
	instanceVariableNames: ''!

!OOStackNotEmptyState class methodsFor: 'initialization' stamp: 'MK 9/19/2021 17:53:22'!
with: aStack
	^ self new initializeWith: aStack.! !


!OOStackNotEmptyState class methodsFor: 'class definition' stamp: 'MK 9/19/2021 18:03:58'!
canHandle: aStack
	^ aStack isEmpty not.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'auxiliaryStack stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'MK 9/19/2021 19:27:27'!
assertPrefixHasNoSpaces: aPrefix
	^((aPrefix findString: ' ') = 0) ifFalse: [^self error: self class invalidPrefixWithSpaces].! !

!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'MK 9/19/2021 19:27:49'!
assertPrefixIsNotEmpty: aPrefix
	^aPrefix isEmpty ifTrue: [^self error: self class invalidPrefixEmpty].! !

!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'MK 9/19/2021 19:29:08'!
assertPrefixIsValid: aPrefix
	self assertPrefixHasNoSpaces: aPrefix.
	self assertPrefixIsNotEmpty: aPrefix.! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'Chiro 9/20/2021 15:30:50'!
initializeWith: aStack
	stack := aStack.
	auxiliaryStack := OOStack new.! !


!SentenceFinderByPrefix methodsFor: 'restorer' stamp: 'MK 9/19/2021 20:29:00'!
restoreStack: aStackOfSentences
	[auxiliaryStack isEmpty not] whileTrue: [
		aStackOfSentences push: auxiliaryStack pop.
	].
! !


!SentenceFinderByPrefix methodsFor: 'fetchers' stamp: 'Chiro 9/20/2021 15:34:53'!
fetchSentencesthatMatch: aPrefix
	|sentence matchingSentences|
	matchingSentences := OrderedCollection new.
	
	[stack isEmpty not] whileTrue: [
		sentence := stack pop.
		(sentence beginsWith: aPrefix) ifTrue: [matchingSentences addFirst: sentence].
		auxiliaryStack push: sentence.
	].

	self restoreStack: stack .
	^ matchingSentences! !

!SentenceFinderByPrefix methodsFor: 'fetchers' stamp: 'Chiro 9/20/2021 15:35:06'!
findAllSentencesWith: aPrefix  
	
	self assertPrefixIsValid: aPrefix.
	^self fetchSentencesthatMatch: aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'MK 9/19/2021 18:50:54'!
invalidPrefixEmpty

	^'The prefix should not be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'MK 9/19/2021 18:50:10'!
invalidPrefixWithSpaces

	^'The prefix should not contain any spaces'! !


!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'Chiro 9/20/2021 15:30:05'!
with: aStack
	^self new initializeWith: aStack! !
