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

!CartTest methodsFor: 'tests' stamp: 'MK 11/2/2021 15:53:55'!
test09TotalOfCartWithOneBookIsItsPrice
	| cart |
	
	cart := self createCart.
	
	cart add: 1 of: self itemSellByTheStore.
	self assert: (cart total) = 100! !

!CartTest methodsFor: 'tests' stamp: 'MK 11/2/2021 15:54:42'!
test10TotalOfCartWithTwoOfSameBookIsItsPriceMultipliedByTwo
	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart total) = 200! !

!CartTest methodsFor: 'tests' stamp: 'MK 11/2/2021 15:56:48'!
test11TotalOfCartWithTwoDifferentBooksIsCorrect
	| cart |
	
	cart := Cart acceptingItemsOf: ((Dictionary new) add: self itemSellByTheStore->100; add: 'validBook2'->50; yourself).
	
	cart add: 1 of: self itemSellByTheStore.
	cart add: 1 of: 'validBook2'.
	self assert: (cart total) = 150! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'MK 11/2/2021 15:44:46'!
defaultCatalog
	
	| dict |
	dict := Dictionary new.
	dict add: self itemSellByTheStore->100.
	^ dict.! !

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

!CashierTest methodsFor: 'tests' stamp: 'MK 11/2/2021 16:50:32'!
test01CheckoutOfEmptyCartThrowsError
	
	| cart cashier nonExpiredDate |
	cart _ Cart acceptingItemsOf: Dictionary new.
	cashier _ self createCashier.
	nonExpiredDate _ GregorianMonthOfYear current next: (TimeUnits month with: 1).
	
	self 
		should: [ cashier doCheckoutOn: cart 
					withCard: (CreditCard withNumber: 123 andExpiration: nonExpiredDate )]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText  = Cashier emptyCartErrorDescription.	
		]
	! !

!CashierTest methodsFor: 'tests' stamp: 'MK 11/2/2021 16:50:32'!
test02ValidCheckoutReturnsCorrectTicket
	
	| cart cashier nonExpiredDate |
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	cashier _ self createCashier.
	nonExpiredDate _ GregorianMonthOfYear current next: (TimeUnits month with: 1).
	
	self assert: 
		'Total: 100' equals: 
		(cashier doCheckoutOn: cart 
			withCard: (CreditCard withNumber: 123 andExpiration: nonExpiredDate )).! !

!CashierTest methodsFor: 'tests' stamp: 'MK 11/2/2021 16:51:18'!
test03CheckoutWithExpiredCardThrowsError
	
	| cart cashier expiredDate |
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	cashier _ self createCashier.
	expiredDate _ GregorianMonthOfYear current previous: (TimeUnits month with: 1).
	
	self should: 
		[cashier doCheckoutOn: cart 
			withCard: (CreditCard withNumber: 123 andExpiration: expiredDate )]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText  = Cashier expiredCreditCardErrorDescription.	
	].! !


!CashierTest methodsFor: 'supporting' stamp: 'MK 11/1/2021 19:40:35'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'supporting' stamp: 'MK 11/2/2021 16:50:31'!
createCashier

	^ Cashier withDate: (GregorianDateTime now)! !

!CashierTest methodsFor: 'supporting' stamp: 'MK 11/2/2021 15:41:53'!
defaultCatalog
	
	| dict |
	dict := Dictionary new.
	dict add: self itemSellByTheStore->100.
	^ dict.! !

!CashierTest methodsFor: 'supporting' stamp: 'MK 11/1/2021 19:40:27'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'supporting' stamp: 'MK 11/1/2021 19:40:19'!
itemSellByTheStore
	
	^ 'validBook'! !


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


!Cart methodsFor: 'assertions' stamp: 'MK 11/2/2021 15:41:09'!
assertIsValidItem: anItem

	catalog at: anItem ifAbsent: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'MK 11/2/2021 15:31:10'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'MK 11/2/2021 15:42:49'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'MK 11/2/2021 15:33:37'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'MK 11/2/2021 15:52:37'!
total
	| total |
	total _ 0.
	items do: [ :aBook | total _ total + catalog at: aBook ].
	^ total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'MK 11/2/2021 16:48:29'!
assertIsNotExpired: aCreditCard

	date monthOfYear > aCreditCard expirationDate ifTrue: [^ self error: Cashier expiredCreditCardErrorDescription ].! !

!Cashier methodsFor: 'initialization' stamp: 'MK 11/2/2021 16:43:53'!
doCheckoutOn: aCart withCard: aCreditCard 
	
	| total |
	aCart isEmpty ifTrue: [self error: Cashier emptyCartErrorDescription].
	self assertIsNotExpired: aCreditCard.
	
	total _ aCart total.
	
	^ 'Total: ', total asString.
	! !

!Cashier methodsFor: 'initialization' stamp: 'MK 11/2/2021 16:44:18'!
initializeWith: aDate
	
	date _ aDate.! !



"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!


!Cashier class methodsFor: 'errors' stamp: 'MK 11/1/2021 19:50:41'!
emptyCartErrorDescription
	^ 'Cannot do checkout of empty cart'! !

!Cashier class methodsFor: 'errors' stamp: 'MK 11/2/2021 16:40:40'!
expiredCreditCardErrorDescription
	^ 'Credit card has already expired'! !

!Cashier class methodsFor: 'errors' stamp: 'MK 11/2/2021 16:45:12'!
withDate: aDate
	^ self basicNew initializeWith: aDate.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'card expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MK 11/2/2021 16:48:45'!
expirationDate
	^ expiration ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MK 11/2/2021 16:28:02'!
initializeWith: aCreditCardNumber and: aGregorianMonthOfYear
	card _ aCreditCardNumber.
	expiration _ aGregorianMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'MK 11/2/2021 16:28:25'!
withNumber: aCreditCardNumber andExpiration: aGregorianMonthOfYear
	^ self new initializeWith: aCreditCardNumber and: aGregorianMonthOfYear.! !
