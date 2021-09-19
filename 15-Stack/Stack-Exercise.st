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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MK 9/19/2021 18:10:21'!
test01StackEmptyShouldReturnEmptyCollection

	|stack prefixMatch finder|
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	prefixMatch := finder find: 'Macarena'.
	
	self assert: prefixMatch isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MK 9/19/2021 18:54:48'!
test02PrefixWithSpacesShouldThrowError

	|stack finder|
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	self	
		should: [finder find: 'Invalid prefix']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix invalidPrefixWithSpaces].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MK 9/19/2021 18:54:59'!
test03EmptyPrefixShouldThrowError

	|stack finder|
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	self	
		should: [finder find: '']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix invalidPrefixEmpty].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MK 9/19/2021 19:02:03'!
test04StackWithOneElementThatMatchesPrefix

	|stack prefixMatch finder|
	stack := OOStack new.
	stack push: 'Tomas'.
	finder := SentenceFinderByPrefix with: stack.
	prefixMatch := finder find: 'Tom'.
	
	self assert: prefixMatch = (OrderedCollection with: 'Tomas').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MK 9/19/2021 19:02:36'!
test05StackWithOneElementThatDoesNotMatchPrefix

	|stack prefixMatch finder|
	stack := OOStack new.
	stack push: 'Tomas'.
	finder := SentenceFinderByPrefix with: stack.
	prefixMatch := finder find: 'Agus'.
	
	self assert: prefixMatch = (OrderedCollection new).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MK 9/19/2021 19:03:43'!
test06StackWithOneElementThatDoesNotMatchPrefixCase

	|stack prefixMatch finder|
	stack := OOStack new.
	stack push: 'Tomas'.
	finder := SentenceFinderByPrefix with: stack.
	prefixMatch := finder find: 'tomas'.
	
	self assert: prefixMatch = (OrderedCollection new).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MK 9/19/2021 19:08:09'!
test07StackWithMultipleMatches

	|stack prefixMatch finder|
	stack := OOStack new.
	stack push: 'Tomas'.
	stack push: 'Macarena no va a salir'.
	stack push: 'Tomas estuvo'.
	stack push: 'Agustin tampoco'.
	stack push: 'Tomas estuvo aqui'.
	
	finder := SentenceFinderByPrefix with: stack.
	prefixMatch := finder find: 'Tomas'.
	
	self assert: prefixMatch = (OrderedCollection with: 'Tomas' with: 'Tomas estuvo' with: 'Tomas estuvo aqui').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MK 9/19/2021 19:12:28'!
test08StackWithMultipleMatchesButWrongCases

	|stack prefixMatch finder|
	stack := OOStack new.
	stack push: 'Tomas'.
	stack push: 'Macarena no va a salir'.
	stack push: 'tOmAs estUvo'.
	stack push: 'Agustin tampoco'.
	stack push: 'TOMAS ESTUVO AQUI!!!!!!'.
	
	finder := SentenceFinderByPrefix with: stack.
	prefixMatch := finder find: 'Tomas'.
	
	self assert: prefixMatch = (OrderedCollection with: 'Tomas').! !


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
	instanceVariableNames: 'stack auxiliaryStack'
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


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'MK 9/19/2021 20:04:52'!
initializeWith: aStack
	stack := aStack.
	auxiliaryStack := OOStack new.! !


!SentenceFinderByPrefix methodsFor: 'restorer' stamp: 'MK 9/19/2021 19:51:22'!
restoreStackFromAuxiliaryStack
	[auxiliaryStack isEmpty not] whileTrue: [
		stack push: auxiliaryStack pop.
	].
! !


!SentenceFinderByPrefix methodsFor: 'fetchers' stamp: 'MK 9/19/2021 20:03:37'!
fetchSentencesInStackThatMatch: aPrefix
	|sentence matchingSentences|
	matchingSentences := OrderedCollection new.
	
	[stack isEmpty not] whileTrue: [
		sentence := stack pop.
		(sentence beginsWith: aPrefix) ifTrue: [matchingSentences addFirst: sentence].
		auxiliaryStack push: sentence.
	].

	self restoreStackFromAuxiliaryStack.
	^ matchingSentences! !

!SentenceFinderByPrefix methodsFor: 'fetchers' stamp: 'MK 9/19/2021 20:02:52'!
find: aPrefix
	
	self assertPrefixIsValid: aPrefix.
	^ self fetchSentencesInStackThatMatch: aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initialize' stamp: 'MK 9/19/2021 18:11:45'!
with: aStack
	^ self new initializeWith: aStack! !


!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'MK 9/19/2021 18:50:54'!
invalidPrefixEmpty

	^'The prefix should not be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'MK 9/19/2021 18:50:10'!
invalidPrefixWithSpaces

	^'The prefix should not contain any spaces'! !
