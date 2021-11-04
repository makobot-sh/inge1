!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'AF 11/2/2021 18:25:23'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
	
		should: [ cart add: self itemNotSellByTheStore ]
		
		raise: Error - MessageNotUnderstood
		
		withExceptionDo: [ :anError |
			
			self assert: anError messageText = Cart invalidItemErrorMessage.
			
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'AF 11/2/2021 18:17:39'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'AF 11/2/2021 18:17:49'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
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

!CartTest methodsFor: 'tests' stamp: 'AF 11/2/2021 20:09:55'!
test09TotalOfCartWithOneBookIsItsPrice
	| cart |
	
	cart := self createCart.
	
	cart add: 1 of: self itemSellByTheStore.
	self assert: (cart priceSum) = 100! !

!CartTest methodsFor: 'tests' stamp: 'AF 11/2/2021 20:09:55'!
test10TotalOfCartWithTwoOfSameBookIsItsPriceMultipliedByTwo
	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart priceSum) = 200! !

!CartTest methodsFor: 'tests' stamp: 'AF 11/2/2021 20:09:55'!
test11TotalOfCartWithTwoDifferentBooksIsCorrect
	| cart |
	
	cart := Cart acceptingItemsOf: ((Dictionary new) add: self itemSellByTheStore->100; add: 'validBook2'->50; yourself).
	
	cart add: 1 of: self itemSellByTheStore.
	cart add: 1 of: 'validBook2'.
	self assert: (cart priceSum) = 150! !

!CartTest methodsFor: 'tests' stamp: 'AF 11/2/2021 18:23:49'!
test12CannotCreateCartWithCatalogWithInvalidPrices

	| cart catalog |
	
	catalog _ (Dictionary new) add: self itemSellByTheStore->100; add: 'validBook2'->-50; yourself.
	
	
	
	self should: [cart _ Cart acceptingItemsOf: catalog.]
		raise: Error
		withExceptionDo:[:anError | self assert: anError messageText = Cart invalidPriceTagErrorMessage.
							   self assert: cart isNil.]
	
	
! !


!CartTest methodsFor: 'set up' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'set up' stamp: 'MK 11/2/2021 15:44:46'!
defaultCatalog
	
	| dict |
	dict := Dictionary new.
	dict add: self itemSellByTheStore->100.
	^ dict.! !

!CartTest methodsFor: 'set up' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'set up' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'AF 11/2/2021 20:21:58'!
test01CheckoutOfEmptyCartThrowsError
	
	| cart cashier creditCard |
	cart _ Cart acceptingItemsOf: Dictionary new.
	
	creditCard _ self createNonExpiredCreditCardWithNumber: 123 .
	
	cashier _ self createCashierFor: cart and: creditCard.	
	
	self assertCheckoutFromCashier: cashier ThrowsErrorWithMessage: Cashier emptyCartErrorDescription.	
! !

!CashierTest methodsFor: 'tests' stamp: 'AF 11/2/2021 19:16:09'!
test02ValidCheckoutReturnsCorrectTicket
	
	| cart cashier creditCard|
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	creditCard _ self createNonExpiredCreditCardWithNumber: 123 .

	cashier _ self createCashierFor: cart and: creditCard.


	self assert: 'Total: 100' equals: (cashier checkout).! !

!CashierTest methodsFor: 'tests' stamp: 'AF 11/2/2021 20:21:43'!
test03CheckoutWithExpiredCardThrowsError

	| cart cashier expiredDate creditCard |
	
	cart _ self createCart.
	
	cart add: self itemSellByTheStore.
	
	expiredDate _ GregorianMonthOfYear current previous: (TimeUnits month with: 1).
	
	creditCard _ CreditCard withNumber: 123 andExpiration: expiredDate.
	
	cashier _ self createCashierFor: cart and: creditCard.
	

	self assertCheckoutFromCashier: cashier ThrowsErrorWithMessage: Cashier expiredCreditCardErrorDescription.	
! !

!CashierTest methodsFor: 'tests' stamp: 'MK 11/4/2021 10:50:52'!
test04CheckoutFailsIfCreditCardDoesNotHaveEnoughFunds

	| cart cashier creditCard |
	
	cart _ self createCart.
	
	cart add: self itemSellByTheStore.
	
	creditCard _ self createNonExpiredCreditCardWithNumber: MPTestInterface noFundsCardNumber.
	
	cashier _ self createCashierFor: cart and: creditCard.
	

	self assertCheckoutFromCashier: cashier ThrowsErrorWithMessage: Cashier notEnoughFundsInCreditCardErrorMessage.	
! !

!CashierTest methodsFor: 'tests' stamp: 'MK 11/4/2021 10:52:09'!
test05CheckoutFailsIfCreditCardIsRobbed

	| cart cashier creditCard |
	
	cart _ self createCart.
	
	cart add: self itemSellByTheStore.
	
	creditCard _ self createNonExpiredCreditCardWithNumber: MPTestInterface robbedCardNumber.
	
	cashier _ self createCashierFor: cart and: creditCard.
	

	self assertCheckoutFromCashier: cashier ThrowsErrorWithMessage: Cashier robbedCardErrorMessage.	
! !


!CashierTest methodsFor: 'asserting' stamp: 'AF 11/2/2021 20:19:57'!
assertCheckoutFromCashier: aCashier ThrowsErrorWithMessage: aMessage
	
	|ticket|

	self should: [ticket _ aCashier checkout]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText  = aMessage.	
		self assert: ticket isNil.
	].! !


!CashierTest methodsFor: 'set up' stamp: 'MK 11/1/2021 19:40:35'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'set up' stamp: 'AF 11/2/2021 17:21:30'!
createCashierFor: aCart and: aCreditCard 

	^ Cashier withCart: aCart andCreditCard: aCreditCard onDate: (GregorianDateTime now)! !

!CashierTest methodsFor: 'set up' stamp: 'AF 11/2/2021 19:16:09'!
createNonExpiredCreditCardWithNumber: aNumber

	|nonExpiredDate|
	
	nonExpiredDate _ GregorianMonthOfYear current next: (TimeUnits month with: 1).
	
	^CreditCard withNumber: aNumber andExpiration: nonExpiredDate.
	! !

!CashierTest methodsFor: 'set up' stamp: 'MK 11/2/2021 15:41:53'!
defaultCatalog
	
	| dict |
	dict := Dictionary new.
	dict add: self itemSellByTheStore->100.
	^ dict.! !

!CashierTest methodsFor: 'set up' stamp: 'MK 11/1/2021 19:40:27'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'set up' stamp: 'MK 11/1/2021 19:40:19'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'AF 11/2/2021 18:27:43'!
assertIsValidItem: anItem

	catalog at: anItem ifAbsent: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'AF 11/2/2021 18:27:57'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'MK 11/2/2021 15:31:10'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'AF 11/2/2021 20:09:55'!
priceSum
	| total |
	total _ 0.
	items do: [ :aBook | total _ total + catalog at: aBook ].
	^ total.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AF 11/2/2021 18:22:54'!
acceptingItemsOf: aCatalog

	(aCatalog allSatisfy: [:aPriceTag | aPriceTag positive]) ifFalse: [self error: self invalidPriceTagErrorMessage].

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'AF 11/2/2021 18:16:27'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'AF 11/2/2021 18:23:22'!
invalidPriceTagErrorMessage
	
	^'All prices must be positive'! !

!Cart class methodsFor: 'error messages' stamp: 'AF 11/2/2021 18:16:41'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog date cart creditCard merchantProcessor errorMap'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'asserting' stamp: 'AF 11/2/2021 19:58:39'!
assertCartIsNotEmpty

	^ cart isEmpty ifTrue: [self error: Cashier emptyCartErrorDescription]! !

!Cashier methodsFor: 'asserting' stamp: 'MK 11/2/2021 16:48:29'!
assertIsNotExpired: aCreditCard

	date monthOfYear > aCreditCard expirationDate ifTrue: [^ self error: Cashier expiredCreditCardErrorDescription ].! !

!Cashier methodsFor: 'asserting' stamp: 'AF 11/2/2021 20:24:44'!
checkTransactionStatus: transactionStatus

	^ (errorMap at: transactionStatus ifAbsent:[]) value! !


!Cashier methodsFor: 'initialization' stamp: 'MK 11/4/2021 10:50:19'!
initializeWith: aCart and: aCreditCard on: aDate
	cart _ aCart.
	
	creditCard _ aCreditCard.
	
	date _ aDate.
	
	merchantProcessor  _ MPTestInterface new.
	
	errorMap _ (Dictionary new) add: 'robbed' -> [self error: self class robbedCardErrorMessage]; 
						      add: 'noFunds' -> [self error: self class notEnoughFundsInCreditCardErrorMessage];
					             	yourself.! !


!Cashier methodsFor: 'transaction operations' stamp: 'AF 11/2/2021 20:03:45'!
charge: aTransactionAmount

	| transactionStatus |
	
	transactionStatus _ merchantProcessor charge: aTransactionAmount on: creditCard.
	
	self checkTransactionStatus: transactionStatus.! !

!Cashier methodsFor: 'transaction operations' stamp: 'AF 11/2/2021 20:09:55'!
checkout  

	| finalPrice |
	
	self assertCartIsNotEmpty.
	
	self assertIsNotExpired: creditCard .
	
	finalPrice _ cart priceSum.
	
	self charge: finalPrice.
	
	^'Total: ', finalPrice asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initialization' stamp: 'AF 11/2/2021 17:19:10'!
withCart: aCart andCreditCard: aCreditCard onDate: aDate
	^ self basicNew initializeWith: aCart and: aCreditCard on: aDate.! !


!Cashier class methodsFor: 'error messages' stamp: 'MK 11/1/2021 19:50:41'!
emptyCartErrorDescription
	^ 'Cannot do checkout of empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'MK 11/2/2021 16:40:40'!
expiredCreditCardErrorDescription
	^ 'Credit card has already expired'! !

!Cashier class methodsFor: 'error messages' stamp: 'AF 11/2/2021 19:08:10'!
notEnoughFundsInCreditCardErrorMessage

	^ 'Not enough funds'! !

!Cashier class methodsFor: 'error messages' stamp: 'AF 11/2/2021 19:32:07'!
robbedCardErrorMessage
	 
	^'atrapen al ladrón'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'AF 11/2/2021 16:57:24'!
initializeWith: aCreditCardNumber and: aGregorianMonthOfYear
	number _ aCreditCardNumber.
	expiration _ aGregorianMonthOfYear.! !


!CreditCard methodsFor: 'accessing' stamp: 'AF 11/2/2021 19:14:02'!
expirationDate
	^ expiration copy! !

!CreditCard methodsFor: 'accessing' stamp: 'AF 11/2/2021 19:13:57'!
number
	^ number copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MK 11/2/2021 16:28:25'!
withNumber: aCreditCardNumber andExpiration: aGregorianMonthOfYear
	^ self new initializeWith: aCreditCardNumber and: aGregorianMonthOfYear.! !


!classDefinition: #MPTestInterface category: 'TusLibros'!
Object subclass: #MPTestInterface
	instanceVariableNames: 'invalidCreditCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPTestInterface methodsFor: 'initialization' stamp: 'AF 11/2/2021 19:46:00'!
initialize

	invalidCreditCards _ (Dictionary new) add: 789 -> 'robbed'; add: 456 -> 'noFunds';yourself.! !


!MPTestInterface methodsFor: 'charge' stamp: 'AF 11/2/2021 19:46:33'!
charge: aTransactionAmount on: aCreditCard 
	
	|result|
		
	result _ invalidCreditCards at: aCreditCard number ifAbsent: ['OK'].
	
	^result.
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPTestInterface class' category: 'TusLibros'!
MPTestInterface class
	instanceVariableNames: ''!

!MPTestInterface class methodsFor: 'as yet unclassified' stamp: 'MK 11/4/2021 10:50:09'!
noFundsCardNumber

	^ 456.! !

!MPTestInterface class methodsFor: 'as yet unclassified' stamp: 'MK 11/4/2021 10:52:09'!
robbedCardNumber

	^ 789.! !
