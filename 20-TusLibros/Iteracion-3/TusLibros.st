!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InterfaceTest category: 'TusLibros'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'testObjectsFactory shouldAuthenticate defaultCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/7/2021 12:08:11'!
authenticateUser: aUser with: aPassword

	^shouldAuthenticate! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:48:42'!
debit: anAmount from: aCreditCard 

	^[ :anAmount2 :aCreditCard2| ] value: anAmount value: aCreditCard ! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/7/2021 14:48:51'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	
	defaultCatalog := testObjectsFactory defaultCatalog.! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:55:03'!
test01CannotCreateCartWithInvalidCredentials

	| interface invalidUser password |
	
	self setUp.
	
	invalidUser := 'notValid'.
	password := 'password'.
	
	shouldAuthenticate := false.
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self .
	
	self should: [interface createCartFor: invalidUser with: password]
		raise: Error
		withMessageText: 'Invalid credentials'
! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:54:59'!
test02CreateCartWithValidCredentialsReturnsIdOfAnEmptyCart

	| interface validUser password cartId cartContents |
	
	self setUp.
	
	validUser := 'valid'.
	password := 'password'.
	
	shouldAuthenticate := true.
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self .
	
	cartId := interface createCartFor: validUser with: password.
	cartContents := interface listCart: cartId.
	
	self assert: cartContents isEmpty.! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:54:55'!
test03AddingBookToInvalidIdCartThrowsError

	| interface cartId book |
	
	self setUp.
	
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self .
	
	cartId := 1.
	book := testObjectsFactory itemSellByTheStore.
	self should: [interface add: 1 of: book to: cartId.]
		raise: Error
		withMessageText: 'Invalid cart id'
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:54:51'!
test04AddingBookToValidIdCartAddsBookToCorrespondingCart

	| interface cartId book cartContents |
	
	self setUp.
	
	shouldAuthenticate := true.
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self .
		
	cartId := interface createCartFor: 'user' with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	interface add: 1 of: book to: cartId.
	
	cartContents := interface listCart: cartId.
	
	self assert: (cartContents includes: book)
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:54:47'!
test05AddingMultipleCopiesOfTheSameBookAddsTheRightAmount

	| interface cartId book cartContents |
	
	self setUp.
	
	shouldAuthenticate := true.
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self .
		
	cartId := interface createCartFor: 'user' with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	interface add: 2 of: book to: cartId.
	
	cartContents := interface listCart: cartId.
	
	self assert: 2 equals: (cartContents occurrencesOf: book)
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:54:42'!
test06CreatingMoreThanOneCartAssingsDifferentIdsForEach

	| interface validUser password cartId1 cartId2 anotherValidUser |
	
	self setUp.
	
	validUser := 'valid'.
	anotherValidUser := 'valid2'.
	password := 'password'.
	
	shouldAuthenticate := true.
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self .
	
	cartId1 := interface createCartFor: validUser with: password.
	cartId2 := interface createCartFor: anotherValidUser with: password.
	
	self assert: cartId1 ~= cartId2! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:54:39'!
test07AddingABookToOneCartDoesNotAffectTheOtherCart

	| interface validUser password cartId1 cartId2 anotherValidUser book cart1Contents cart2Contents |
	
	self setUp.
	validUser := 'valid'.
	anotherValidUser := 'valid2'.
	password := 'password'.
	book := testObjectsFactory itemSellByTheStore .
	shouldAuthenticate := true.
	
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self .
	
	cartId1 := interface createCartFor: validUser with: password.
	cartId2 := interface createCartFor: anotherValidUser with: password.
	
	interface add: 1 of: book to: cartId1.
	
	cart1Contents := interface listCart: cartId1.
	cart2Contents := interface listCart: cartId2.	
	self assert: cart1Contents ~= cart2Contents.! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:54:35'!
test08ListingInvalidCartIdThrowsError

	| interface |
	
	self setUp.
	
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self .

	self should: [interface listCart: 0]
		raise: Error
		withMessageText: 'Invalid cart id' ! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:55:31'!
test09CheckOutOfAInvalidIdCartThrowError

	| interface cartId creditCard |
	
	self setUp.
	
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self .
	creditCard := testObjectsFactory notExpiredCreditCard.
	cartId := 1.
	self should: [interface checkOutCartWith: cartId creditCard: creditCard onDate: testObjectsFactory today]
		raise: Error
		withMessageText: 'Invalid cart id'
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:55:53'!
test10CheckOutOfValidIdCartRegisterSale

	|creditCard interface cartId book aSalesBook |
	
	self setUp.
	
	shouldAuthenticate := true.
	interface := Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self.
		
	cartId := interface createCartFor: 'user' with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	
	interface add: 1 of: book to: cartId.
	aSalesBook := interface checkOutCartWith: cartId creditCard: creditCard onDate: testObjectsFactory today.
	
	self assert: (testObjectsFactory itemSellByTheStorePrice) equals: aSalesBook first total
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'AF 11/7/2021 14:52:18'!
contents
	
	^items copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Interface category: 'TusLibros'!
Object subclass: #Interface
	instanceVariableNames: 'authenticator activeCarts catalog nextId merchantProcessor saleBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/7/2021 15:45:19'!
add: anAmount of: aBook to: aCartId

	
	^(activeCarts at: aCartId ifAbsent:[self error: 'Invalid cart id']) add: anAmount of: aBook.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:42:31'!
authenticatingWith: anAuthenticator andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor   

	authenticator := anAuthenticator .
	
	catalog := aCatalog .
	
	activeCarts := Dictionary new.
	
	nextId := 1.
	
	merchantProcessor  := aMerchantProcessor.
	
	saleBook := OrderedCollection new.
	
	
	
	
	
	
	! !

!Interface methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:51:51'!
checkOutCartWith: aCartId creditCard: aCreditCard onDate: aDate  
	
	|cart cashier|
	cart := activeCarts at: aCartId ifAbsent:[^self error: 'Invalid cart id'].
	
	cashier := Cashier toCheckout: cart charging: aCreditCard throught: merchantProcessor on: aDate  registeringOn: saleBook.
	cashier checkOut.
	^saleBook copy
	! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/7/2021 15:42:02'!
createCartFor: aUser with: aPassword

	| cartId |
	(authenticator authenticateUser: aUser with: aPassword) ifFalse: [self error: 'Invalid credentials'].
	
	cartId := nextId .
	nextId := cartId + 1.
	
	activeCarts add: cartId -> (Cart acceptingItemsOf: catalog).
	
	^cartId.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/7/2021 15:51:15'!
listCart: aCartId 
	
	^(activeCarts at: aCartId ifAbsent: [self error: 'Invalid cart id']) contents.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: 'TusLibros'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:52:46'!
authenticatingWith: anAuthenticator andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor      
	
	^self basicNew authenticatingWith: anAuthenticator andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor .! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
