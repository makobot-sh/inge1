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

!CashierTest methodsFor: 'tests' stamp: 'AF 11/11/2021 16:24:11'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := ClientPurchases new.
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
			self assert: salesBook history isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'AF 11/11/2021 16:21:15'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: ClientPurchases new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'AF 11/11/2021 16:23:44'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := ClientPurchases new.
	
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
			self assert: salesBook history isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'AF 11/11/2021 16:24:45'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := ClientPurchases new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
	
	self assert: salesBook history size = 1.
	self assert: salesBook totalSpent = total.! !

!CashierTest methodsFor: 'tests' stamp: 'AF 11/11/2021 16:21:54'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: ClientPurchases new.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'AF 11/11/2021 16:26:06'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := ClientPurchases new.
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
			self assert: salesBook history isEmpty ]! !


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

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:01:35'!
createInterfaceWithClock: aClock

	^ Interface authenticatingWith: self andCatalog: defaultCatalog andMerchantProcessor: self andClock: aClock! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'Chiro 11/7/2021 16:48:42'!
debit: anAmount from: aCreditCard 

	^[ :anAmount2 :aCreditCard2| ] value: anAmount value: aCreditCard ! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/7/2021 14:48:51'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	
	defaultCatalog := testObjectsFactory defaultCatalog.! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:01:36'!
test01CannotCreateCartWithInvalidCredentials

	| interface invalidUser password trueClock |
	
	self setUp.
	
	invalidUser := 'notValid'.
	password := 'password'.
	
	trueClock := testObjectsFactory trueClock.
	shouldAuthenticate := false.
	interface := self createInterfaceWithClock: trueClock .
	
	self should: [interface createCartFor: invalidUser with: password]
		raise: Error
		withMessageText: Interface invalidCredentialsErrorMessage.
! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:01:36'!
test02CreateCartWithValidCredentialsReturnsIdOfAnEmptyCart

	| interface validUser password cartId cartContents trueClock |
	
	self setUp.
	
	validUser := 'valid'.
	password := 'password'.
	
	trueClock := testObjectsFactory trueClock.
	shouldAuthenticate := true.
	interface := self createInterfaceWithClock: trueClock .
	
	cartId := interface createCartFor: validUser with: password.
	cartContents := interface listCart: cartId.
	
	self assert: cartContents isEmpty.! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:01:36'!
test03AddingBookToInvalidIdCartThrowsError

	| interface cartId book trueClock |
	
	self setUp.
	
	trueClock := testObjectsFactory trueClock.
	interface := self createInterfaceWithClock: trueClock .
	
	cartId := 1.
	book := testObjectsFactory itemSellByTheStore.
	self should: [interface add: 1 of: book to: cartId.]
		raise: Error
		withMessageText: Interface invalidCartIdErrorMessage.
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:01:36'!
test04AddingBookToValidIdCartAddsBookToCorrespondingCart

	| interface cartId book cartContents trueClock |
	
	self setUp.
	
	shouldAuthenticate := true.
	trueClock := testObjectsFactory trueClock.
	interface := self createInterfaceWithClock: trueClock .
		
	cartId := interface createCartFor: 'user' with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	interface add: 1 of: book to: cartId.
	
	cartContents := interface listCart: cartId.
	
	self assert: (cartContents includes: book)
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:01:36'!
test05AddingMultipleCopiesOfTheSameBookAddsTheRightAmount

	| interface cartId book cartContents trueClock |
	
	self setUp.
	
	shouldAuthenticate := true.
	trueClock := testObjectsFactory trueClock.
	interface := self createInterfaceWithClock: trueClock .
		
	cartId := interface createCartFor: 'user' with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	interface add: 2 of: book to: cartId.
	
	cartContents := interface listCart: cartId.
	
	self assert: 2 equals: (cartContents occurrencesOf: book)
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:01:36'!
test06CreatingMoreThanOneCartAssingsDifferentIdsForEach

	| interface validUser password cartId1 cartId2 anotherValidUser trueClock |
	
	self setUp.
	
	validUser := 'valid'.
	anotherValidUser := 'valid2'.
	password := 'password'.
	
	trueClock := testObjectsFactory trueClock.
	shouldAuthenticate := true.
	interface := self createInterfaceWithClock: trueClock .
	
	cartId1 := interface createCartFor: validUser with: password.
	cartId2 := interface createCartFor: anotherValidUser with: password.
	
	self assert: cartId1 ~= cartId2! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:01:36'!
test07AddingABookToOneCartDoesNotAffectTheOtherCart

	| interface validUser password cartId1 cartId2 anotherValidUser book cart1Contents cart2Contents trueClock |
	
	self setUp.
	validUser := 'valid'.
	anotherValidUser := 'valid2'.
	password := 'password'.
	book := testObjectsFactory itemSellByTheStore .
	shouldAuthenticate := true.
	trueClock := testObjectsFactory trueClock.
	interface := self createInterfaceWithClock: trueClock .
	
	cartId1 := interface createCartFor: validUser with: password.
	cartId2 := interface createCartFor: anotherValidUser with: password.
	
	interface add: 1 of: book to: cartId1.
	
	cart1Contents := interface listCart: cartId1.
	cart2Contents := interface listCart: cartId2.	
	self assert: cart1Contents ~= cart2Contents.! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:01:36'!
test08ListingInvalidCartIdThrowsError

	| interface trueClock |
	
	self setUp.
	
	trueClock := testObjectsFactory trueClock.
	interface := self createInterfaceWithClock: trueClock .

	self should: [interface listCart: 0]
		raise: Error
		withMessageText: Interface invalidCartIdErrorMessage ! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:12:35'!
test09CheckOutOfAInvalidIdCartThrowError

	| interface cartId creditCard trueClock |
	
	self setUp.
	
	trueClock := testObjectsFactory trueClock.
	interface := self createInterfaceWithClock: trueClock .
	creditCard := testObjectsFactory notExpiredCreditCard.
	cartId := 1.
	self should: [interface checkOutCartWith: cartId creditCard: creditCard forClientId: clientId]
		raise: Error
		withMessageText: Interface invalidCartIdErrorMessage
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:12:35'!
test10CheckOutOfValidIdCartRegisterSale

	|creditCard interface cartId book aSalesBook trueClock clientId |
	
	self setUp.
	
	shouldAuthenticate := true.
	trueClock := testObjectsFactory trueClock.
	interface := self createInterfaceWithClock: trueClock.
	clientId := 'user'.
	
	cartId := interface createCartFor: clientId with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	
	interface add: 1 of: book to: cartId.
	aSalesBook := interface checkOutCartWith: cartId creditCard: creditCard forClientId: clientId.
	
	self assert: (testObjectsFactory itemSellByTheStorePrice) equals: aSalesBook totalSpent .
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:59:30'!
test11WhenAddingBookCartExpiresIfWasntUsedFor30Minutes

	|interface cartId book falseClock|
	
	self setUp.
	
	shouldAuthenticate := true.
	falseClock := testObjectsFactory falseClock.
	interface := self createInterfaceWithClock: falseClock.
		
	cartId := interface createCartFor: 'user' with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	falseClock addTime: (Duration minutes: 30).
	
	self should: [interface add: 1 of: book to: cartId.]
		raise: Error
		withMessageText: Interface expiredCartErrorMessage

	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:12:35'!
test12WhenDoingCheckoutCartExpiresIfWasntUsedFor30Minutes

	|creditCard interface cartId book falseClock|
	
	self setUp.
	
	shouldAuthenticate := true.
	falseClock := testObjectsFactory falseClock.
	interface := self createInterfaceWithClock: falseClock.
		
	cartId := interface createCartFor: 'user' with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	
	interface add: 1 of: book to: cartId.
	falseClock addTime: (Duration minutes: 30).
	
	self should: [interface checkOutCartWith: cartId creditCard: creditCard forClientId: clientId]
		raise: Error
		withMessageText: Interface expiredCartErrorMessage

	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 10:00:39'!
test13WhenListingCartItExpiresIfWasntUsedFor30Minutes

	|interface cartId book falseClock|
	
	self setUp.
	
	shouldAuthenticate := true.
	falseClock := testObjectsFactory falseClock.
	interface := self createInterfaceWithClock: falseClock.
		
	cartId := interface createCartFor: 'user' with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	interface add: 1 of: book to: cartId.
	falseClock addTime: (Duration minutes: 30).
	
	self should: [interface listCart: cartId]
		raise: Error
		withMessageText: Interface expiredCartErrorMessage

	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 10:02:46'!
test14CreatingASecondCartDoesNotResetPreviousCartTimer

	|interface cartId1 book falseClock|
	
	self setUp.
	
	shouldAuthenticate := true.
	falseClock := testObjectsFactory falseClock.
	
	interface := self createInterfaceWithClock: falseClock.
	cartId1 := interface createCartFor: 'user' with: 'password'.
	book := testObjectsFactory itemSellByTheStore.
	interface add: 1 of: book to: cartId1.
	falseClock addTime: (Duration minutes: 30).
	
	interface createCartFor: 'user2' with: 'password2'.
	
	self should: [interface listCart: cartId1]
		raise: Error
		withMessageText: Interface expiredCartErrorMessage

	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:57:10'!
test15CheckThatExpiredCartNoLongerExistsAfterTryingToUseIt

	|interface cartId1 book falseClock|
	self setUp.
	
	shouldAuthenticate := true.
	falseClock := testObjectsFactory falseClock.
	interface := self createInterfaceWithClock: falseClock.
	cartId1 := interface createCartFor: 'user' with: 'password'.
	falseClock addTime: (Duration minutes: 30).
	
	book := testObjectsFactory itemSellByTheStore .
	
	self should: [interface add: 1 of: book to: cartId1]
		raise: Error
		withExceptionDo:[:anError | self assert: anError messageText = Interface expiredCartErrorMessage.
							   
							   self should: [interface add: 1 of: book to: cartId1]
								  raise: Error
								  withMessageText: Interface invalidCartIdErrorMessage.

							 ] 
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 15:47:29'!
test16WhenClientHasNotBoughtThenClientPurchasesReturnsNoPurchases

	|interface clientPurchases trueClock |
	
	self setUp.
	
	shouldAuthenticate := true.
	
	trueClock := testObjectsFactory trueClock.
	
	interface := self createInterfaceWithClock: trueClock.
	
	clientPurchases := interface listPurchasesOf: 'user' with: 'password'.
	
	
	self assert: Bag new equals: clientPurchases history. 
	self assert: 0 equals: clientPurchases totalSpent.
	
! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:12:35'!
test17WhenClientHasMadeAPurchaseThenListPurchasesReturnsIt

	|creditCard interface cartId book clientPurchases trueClock bag clientId password |
	
	self setUp.
	
	shouldAuthenticate := true.
	trueClock := testObjectsFactory trueClock.
	interface := self createInterfaceWithClock: trueClock.
	
	clientId := 'user'. password := 'password'.
	
	cartId := interface createCartFor: clientId with: password.
	book := testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	
	interface add: 1 of: book to: cartId.
	interface checkOutCartWith: cartId creditCard: creditCard forClientId: clientId.
	
	clientPurchases := interface listPurchasesOf: clientId with: password.
	 
	bag := Bag new.
	bag add: testObjectsFactory itemSellByTheStore.
	
	self assert: bag equals: clientPurchases history. 
	self assert: testObjectsFactory itemSellByTheStorePrice equals: clientPurchases totalSpent.
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 15:50:49'!
test18CannotListPurchasesWithInvalidCredentials

	| interface invalidUser password trueClock |
	
	self setUp.
	
	invalidUser := 'notValid'.
	password := 'password'.
	
	trueClock := testObjectsFactory trueClock.
	shouldAuthenticate := false.
	interface := self createInterfaceWithClock: trueClock .
	
	self should: [interface listPurchasesOf: invalidUser with: password]
		raise: Error
		withMessageText: Interface invalidCredentialsErrorMessage.
! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:12:35'!
test19ListingPurchasesOfDifferentClientsReturnsTheCorrespondingPurchases

	|creditCard interface cartId book clientPurchases1 trueClock bag clientId1 password1 clientId2 clientPurchases2 password2 |
	
	self setUp.
	
	shouldAuthenticate := true.
	
	book := testObjectsFactory itemSellByTheStore.
	
	creditCard := testObjectsFactory notExpiredCreditCard.

	trueClock := testObjectsFactory trueClock.
	
	interface := self createInterfaceWithClock: trueClock.
	
	
	
	clientId1 := 'user'. password1 := 'password'.
	
	cartId := interface createCartFor: clientId1 with: password1.
	
	
	interface add: 1 of: book to: cartId.
	
	interface checkOutCartWith: cartId creditCard: creditCard forClientId: clientId1.
	
	clientId2 := 'user2'. password2 := 'password'.
	
	clientPurchases1 := interface listPurchasesOf: clientId1 with: password1.
	clientPurchases2 := interface listPurchasesOf: clientId2 with: password2.
	
	bag := Bag new.
	bag add: testObjectsFactory itemSellByTheStore.
	
	self assert: bag equals: clientPurchases1 history. 
	self assert: testObjectsFactory itemSellByTheStorePrice equals: clientPurchases1 totalSpent.
	
	self assert: Bag new equals: clientPurchases2 history. 
	self assert: 0 equals: clientPurchases2 totalSpent.
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


!Cart methodsFor: 'initialization' stamp: 'Chiro 11/11/2021 13:46:06'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


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


!classDefinition: #CartSession category: 'TusLibros'!
Object subclass: #CartSession
	instanceVariableNames: 'cart lastTimeUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:00:13'!
cart

	^cart.! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:17:06'!
initializeWith: aCart On: aDateAndTime

	cart := aCart.
	lastTimeUsed  := aDateAndTime.! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:00:34'!
lastTimeUsed

	^lastTimeUsed .! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:10:49'!
usedAt: aDateAndTime

	lastTimeUsed := aDateAndTime .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:01:51'!
with: aCart on: aDateAndTime

	^self basicNew initializeWith: aCart On: aDateAndTime .! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart clientPurchases merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'AF 11/11/2021 15:27:31'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'AF 11/11/2021 15:20:06'!
registerSale

	clientPurchases add: cart contents andTotalPaid: total.! !


!Cashier methodsFor: 'checkout' stamp: 'AF 11/11/2021 15:15:02'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.
	
	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'AF 11/11/2021 15:18:00'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aClientPurchases
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	clientPurchases := aClientPurchases! !

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


!classDefinition: #ClientPurchases category: 'TusLibros'!
Object subclass: #ClientPurchases
	instanceVariableNames: 'itemsBought totalSpent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientPurchases methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 15:27:45'!
add: aCollectionOfItems andTotalPaid: anAmount

	itemsBought addAll: aCollectionOfItems.
	
	totalSpent := totalSpent + anAmount.

	! !

!ClientPurchases methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 15:23:24'!
history

	^itemsBought copy! !

!ClientPurchases methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:04:33'!
initialize 

	itemsBought := Bag new. 
	totalSpent := 0.! !

!ClientPurchases methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 14:20:58'!
totalSpent

	^totalSpent copy! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:37:23'!
currentTime

	^DateAndTime now.! !


!classDefinition: #ClockSimulated category: 'TusLibros'!
Clock subclass: #ClockSimulated
	instanceVariableNames: 'addedTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockSimulated methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:33:37'!
addTime: aTimeDuration
	addedTime := aTimeDuration! !

!ClockSimulated methodsFor: 'as yet unclassified' stamp: 'Chiro 11/11/2021 08:42:41'!
currentTime
	^DateAndTime now + addedTime.! !

!ClockSimulated methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:35:01'!
initialize
	addedTime := Duration minutes: 0! !


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
	instanceVariableNames: 'authenticator catalog nextCartId merchantProcessor clock salesBookByClientId cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:13:05'!
add: anAmount of: aBook to: aCartId

	|cart|
	
	cart := (cartSessions at: aCartId ifAbsent:[self error: Interface invalidCartIdErrorMessage ]) cart.
	self checkExpirationTimeForCartIdAndRefreshIfNotExpired: aCartId.
	
	cart add: anAmount of: aBook.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:14:55'!
authenticatingWith: anAuthenticator andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andClock: aClock   

	authenticator := anAuthenticator .
	catalog := aCatalog .
	cartSessions := Dictionary new.
	
	salesBookByClientId  := Dictionary new.
	
	nextCartId := 1.
	
	merchantProcessor  := aMerchantProcessor.
	clock := aClock.
	
	
! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:10:16'!
checkExpirationTimeForCartIdAndRefreshIfNotExpired: aCartId

	(Duration minutes: 30) < (clock currentTime - ((cartSessions at: aCartId) lastTimeUsed)) ifTrue: [cartSessions removeKey: aCartId.
																			      self error: Interface expiredCartErrorMessage].
	

	(cartSessions at: aCartId) usedAt: clock currentTime.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:12:35'!
checkOutCartWith: aCartId creditCard: aCreditCard forClientId: aClientId  

	|cart cashier clientPurchases|
	
	cart := (cartSessions at: aCartId ifAbsent:[^self error: Interface invalidCartIdErrorMessage ]) cart.
	self checkExpirationTimeForCartIdAndRefreshIfNotExpired: aCartId.
	
	clientPurchases := salesBookByClientId at: aClientId ifAbsent: [salesBookByClientId add: aClientId -> (ClientPurchases new ).
													clientPurchases := salesBookByClientId at: aClientId].
	
	cashier := Cashier toCheckout: cart charging: aCreditCard throught: merchantProcessor on: clock currentTime  registeringOn: clientPurchases .
	cashier checkOut. 	
	^clientPurchases.
	! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:14:55'!
createCartFor: aClientId with: aPassword

	| cartId cartSession |

	(authenticator authenticateUser: aClientId with: aPassword) ifFalse: [self error: Interface invalidCredentialsErrorMessage].
	
	cartId := nextCartId .
	nextCartId := cartId + 1.
	cartSession := CartSession with: (Cart acceptingItemsOf: catalog) on: clock currentTime .
	cartSessions add: cartId -> cartSession .
	
	^cartId.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:08:16'!
listCart: aCartId

	|cart|

	cart := (cartSessions at: aCartId ifAbsent: [self error: Interface invalidCartIdErrorMessage ]) cart.
	
	self checkExpirationTimeForCartIdAndRefreshIfNotExpired: aCartId.
	
	^cart contents.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 16:03:40'!
listPurchasesOf: aClientId with: aPassword 

	(authenticator authenticateUser: aClientId with: aPassword) ifFalse: [self error: Interface invalidCredentialsErrorMessage].

	^salesBookByClientId at: aClientId ifAbsent: [salesBookByClientId add: aClientId -> (ClientPurchases new ).
									    ^salesBookByClientId at: aClientId].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: 'TusLibros'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'as yet unclassified' stamp: 'Chiro 11/11/2021 08:40:29'!
authenticatingWith: anAuthenticator andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andClock: aClock       
	
	^self basicNew authenticatingWith: anAuthenticator andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andClock: aClock .! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'Chiro 11/11/2021 00:40:17'!
expiredCartErrorMessage
	^'Cannot use an expired cart'! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'MK 11/8/2021 15:46:03'!
invalidCartIdErrorMessage
	^ 'Invalid cart id'! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'MK 11/8/2021 15:46:12'!
invalidCredentialsErrorMessage
	^ 'Invalid credentials'! !


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


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:39:12'!
falseClock
	^ClockSimulated new.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AF 11/11/2021 09:37:50'!
trueClock
	^Clock new.! !
