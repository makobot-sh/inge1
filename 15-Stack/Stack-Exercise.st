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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Chiro 9/18/2021 16:09:10'!
test01StackEmptyShouldReturnEmptyCollection

	|stack prefixMatch finder|
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	prefixMatch := finder find:'Macarena       '.
	
	self assert: prefixMatch isEmpty! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stateMachine elementContainerList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'Chiro 9/18/2021 14:57:45'!
initialize
	elementContainerList  := OrderedCollection new.
	stateMachine := OOStackStateMachine new 
	

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

!OOStack methodsFor: 'operations' stamp: 'Chiro 9/18/2021 15:06:37'!
top
	^stateMachine topOf: self.
	
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
OOStack subclass: #OOStackStateMachine
	instanceVariableNames: 'topDictionary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateMachine methodsFor: 'as yet unclassified' stamp: 'Chiro 9/18/2021 14:59:25'!
initialize

	topDictionary := Dictionary new.
	topDictionary add: 0 -> [:aStack| aStack topEmpty].
	! !

!OOStackStateMachine methodsFor: 'as yet unclassified' stamp: 'Chiro 9/18/2021 15:03:36'!
topOf: aStack
	|size|
	size := aStack size.
	(topDictionary at: size ifAbsent:[^aStack topNotEmpty]) value: aStack. ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Chiro 9/18/2021 16:03:45'!
find: aPrefix
	|sentence auxiliaryStack prefixMatched|
	
	[self validatePrefix: aPrefix] ifFalse: [^self error: self class invalidPrefixWithEmptySpaces].
	prefixMatched := OrderedCollection new.
	auxiliaryStack := OOStack new.
	[stack isEmpty not] whileTrue: [
		sentence := stack pop.
		[sentence beginsWith: aPrefix] ifTrue: [prefixMatched add: sentence].
		auxiliaryStack push: sentence.
	].
	[auxiliaryStack isEmpty not] whileTrue: [
		stack push: auxiliaryStack pop.
	].
	^prefixMatched! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Chiro 9/18/2021 15:56:54'!
initializeWith: aStack
	stack := aStack! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Chiro 9/18/2021 16:07:41'!
validatePrefix: prefix
	^prefix findString: ' ' ~= 0
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initialize' stamp: 'Chiro 9/18/2021 15:56:28'!
with: aStack
	self new initializeWith: aStack! !


!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'Chiro 9/18/2021 16:07:57'!
invalidPrefixWithEmptySpaces

	^'The prefix should not contain any spaces'! !
