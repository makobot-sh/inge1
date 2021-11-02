!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MK 11/1/2021 19:40:35'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MK 11/1/2021 19:40:12'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MK 11/1/2021 19:40:27'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MK 11/1/2021 19:40:19'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MK 11/1/2021 20:04:20'!
test01CheckoutOfEmptyCartThrowsError
	
	| cart cashier |
	cart _ Cart acceptingItemsOf: Array new.
	cashier _ Cashier withCatalog: Array new.
	
	self 
		should: [ cashier doCheckoutOn: cart ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText  = Cashier emptyCartErrorDescription.	
		]
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MK 11/1/2021 20:26:51'!
test02CheckoutOfCartWithOneBookReturnsCorrectPrice
	
	| cart cashier priceList |
	cart _ self createCart.
	cart add: 1 of: self itemSellByTheStore.
	
	priceList _ Dictionary new.
	priceList add: self itemSellByTheStore->100.
	cashier _ Cashier withCatalog: priceList.
	
	self assert: 'Total: 100' equals: (cashier doCheckoutOn: cart).
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MK 11/1/2021 20:30:00'!
test03CheckoutOfCartWithTwoOfSameBookReturnsCombinedPrice
	
	| cart cashier priceList |
	cart _ self createCart.
	cart add: 2 of: self itemSellByTheStore.
	
	priceList _ Dictionary new.
	priceList add: self itemSellByTheStore->100.
	cashier _ Cashier withCatalog: priceList.
	
	self assert: 'Total: 200' equals: (cashier doCheckoutOn: cart).
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MK 11/1/2021 20:32:06'!
test04CheckoutOfCartWithTwoDifferentBooksReturnsCombinedPrice
	
	| cart cashier priceList |
	cart _ Cart acceptingItemsOf: (Array with: self itemSellByTheStore with: 'validBook2').
	cart add: 1 of: self itemSellByTheStore.
	cart add: 1 of: 'validBook2'.
	
	priceList _ Dictionary new.
	priceList add: self itemSellByTheStore->100; add: 'validBook2'->50.
	cashier _ Cashier withCatalog: priceList.
	
	self assert: 'Total: 150' equals: (cashier doCheckoutOn: cart).
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'MK 11/1/2021 20:29:17'!
doCheckoutOn: aCart
	
	| total |
	aCart isEmpty ifTrue: [self error: Cashier emptyCartErrorDescription].
	
	total _ 0.
	((aCart occurrencesOf: catalog keys first) > 0) ifTrue: 
		[total _ total + (catalog at: catalog keys first) * (aCart occurrencesOf: (catalog keys first))].
	
	catalog keys size =2 ifTrue: [1 = (aCart occurrencesOf: catalog keys second) ifTrue: 
		[total _ total + (catalog at: catalog keys second)]].
	
	^ 'Total: ', total asString.
	! !

!Cashier methodsFor: 'initialization' stamp: 'MK 11/1/2021 20:01:34'!
initializeAcceptingCatalog: aCatalog 
	
	catalog := aCatalog.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'MK 11/1/2021 19:59:29'!
withCatalog: aCatalog 

	^self new initializeAcceptingCatalog: aCatalog ! !


!Cashier class methodsFor: 'errors' stamp: 'MK 11/1/2021 19:50:41'!
emptyCartErrorDescription
	^ 'Cannot do checkout of empty cart'! !
