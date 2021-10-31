!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'Chiro 10/31/2021 13:17:42'!
test01EmptyCartListsNoBooks

	| cart |
	cart := Cart with: Set new.
	
	self assert: (Dictionary new) equals: cart listBooks.
	
	! !

!CartTest methodsFor: 'tests' stamp: 'Chiro 10/31/2021 13:45:08'!
test02WhenOneValidBookIsAddedThenListBooksReturnsIt

	| cart cartContent |
	cart := Cart with: (Set with: 'Haikyuu!!').
	cartContent := Dictionary new.
	cartContent add: 'Haikyuu!!' -> 1.
	
	cart add: 'Haikyuu!!'.
	
	self assert: cartContent equals: cart listBooks.
	
	! !

!CartTest methodsFor: 'tests' stamp: 'Chiro 10/31/2021 13:50:02'!
test03WhenOneInvalidBookIsAddedThenThrowError

	| cart |
	cart := Cart with: (Set with: 'Haikyuu!!').
	
	
	self assertAddingNoInvalidBooks: [cart add: 'JoJos Bizarre Adventure'.] 

	! !

!CartTest methodsFor: 'tests' stamp: 'Chiro 10/31/2021 13:22:49'!
test04AddMultipleDifferentValidBooks

	| bookList cart cartContent |
	bookList := Set with: 'Haikyuu!!' with: 'JoJos Bizarre Adventure'.
	
	cartContent := Dictionary new.
	cartContent add: 'Haikyuu!!' -> 1; add: 'JoJos Bizarre Adventure' -> 1.
	
	cart := Cart with: bookList.
	
	cart add: 'Haikyuu!!'.
	cart add: 'JoJos Bizarre Adventure'.
	self assert: cartContent equals: cart listBooks.
	
	! !

!CartTest methodsFor: 'tests' stamp: 'Chiro 10/31/2021 13:23:19'!
test05AddMultipleCopysOfSameValidBook

	| cart cartContent|
	cart := Cart with: (Set with: 'Haikyuu!!').
	
	cartContent := Dictionary new.
	cartContent add: 'Haikyuu!!' -> 2.
	
	cart add: 'Haikyuu!!' withAmount: 2.
	self assert:  cartContent equals: cart listBooks.
	
	! !

!CartTest methodsFor: 'tests' stamp: 'Chiro 10/31/2021 13:50:02'!
test06WhenMultipleInvalidBooksAreAddedThenThrowError

	| cart |
	cart := Cart with: (Set with: 'Haikyuu!!').
	 
	self assertAddingNoInvalidBooks: [ cart add: 'JoJos Bizarre Adventure!!' withAmount: 100. ].
	! !

!CartTest methodsFor: 'tests' stamp: 'Chiro 10/31/2021 13:12:21'!
test07WhenInvalidAmountOfCopiesAreAddedThenThrowError
	
	| cart |
	cart := Cart with: (Set with: 'Haikyuu!!').
	
	self
	should: [ cart add: 'Haikyuu!!' withAmount: -5. ]
 		raise: Error
 		withExceptionDo: [ :anError |
			self assert: Cart cannotAddInvalidNumberErrorDescription equals: anError messageText.]
	
	! !

!CartTest methodsFor: 'tests' stamp: 'Chiro 10/31/2021 13:44:26'!
test08WhenAddingABookMultipleTimesInBatchesThenListsCorrectAmount

	| cart cartContent|
	cart := Cart with: (Set with: 'Haikyuu!!').
	
	cartContent := Dictionary new.
	cartContent add: 'Haikyuu!!' -> 6.
	
	cart add: 'Haikyuu!!'.
	cart add: 'Haikyuu!!' withAmount: 2.
	cart add: 'Haikyuu!!' withAmount: 3.
	
	self assert:  cartContent equals: cart listBooks.
	
	! !


!CartTest methodsFor: 'assertions' stamp: 'Chiro 10/31/2021 13:50:02'!
assertAddingNoInvalidBooks: aClosure

	^ self
	should: aClosure 
 		raise: Error
 		withExceptionDo: [ :anError |
			self assert: Cart cannotAddInvalidBookErrorDescription equals: anError messageText.]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalogue contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'Chiro 10/31/2021 13:23:42'!
initializeWith: aCatalogue 

	catalogue := aCatalogue.
	contents := Dictionary new.! !


!Cart methodsFor: 'asserts' stamp: 'Chiro 10/31/2021 13:39:03'!
assertCanAdd: aBook with: anAmount

	(anAmount <= 0) ifTrue:[self error: self class cannotAddInvalidNumberErrorDescription.].
	(catalogue includes: aBook) ifFalse: [self error: self class cannotAddInvalidBookErrorDescription.]! !


!Cart methodsFor: 'operations' stamp: 'Chiro 10/31/2021 13:26:00'!
add: aBook
	self add: aBook withAmount: 1.! !

!Cart methodsFor: 'operations' stamp: 'Chiro 10/31/2021 13:39:03'!
add: aBook withAmount: anAmount
	
	| newAmount |
	self assertCanAdd: aBook with: anAmount.
	
	newAmount := anAmount + contents at: aBook ifAbsent: [ ^contents add: aBook -> anAmount].
	contents at: aBook put: newAmount.
	! !

!Cart methodsFor: 'operations' stamp: 'Chiro 10/31/2021 11:38:25'!
listBooks
	^contents.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'Chiro 10/31/2021 11:29:54'!
with: aCatalogue 
	
	^self new initializeWith: aCatalogue ! !


!Cart class methodsFor: 'as yet unclassified' stamp: 'Chiro 10/31/2021 11:48:38'!
cannotAddInvalidBookErrorDescription
	^'This book is not present in the catalogue'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'Chiro 10/31/2021 12:47:46'!
cannotAddInvalidNumberErrorDescription
	^'We cant add that amount of copys, sorry not sorry'! !
