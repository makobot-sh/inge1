!classDefinition: #CartTest category: 'TusLibros-Tests'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

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


!classDefinition: #CashierTest category: 'TusLibros-Tests'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |

	salesBook := OrderedCollection new.
	self
		should: [ Cashier
			toCheckout: testObjectsFactory createCart
			ownedBy: testObjectsFactory customer
			charging: testObjectsFactory notExpiredCreditCard
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test02CalculatedTotalIsCorrect

	| cart cashier |

	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.

	cashier :=  Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: OrderedCollection new.

	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	self
		should: [ Cashier
				toCheckout: cart
				ownedBy: testObjectsFactory customer
				charging: testObjectsFactory expiredCreditCard
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	total := cashier checkOut total.

	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	debitBehavior := [ :anAmount :aCreditCard |
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.

	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:02'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
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


!classDefinition: #TusLibrosRestAPIInterfaceTest category: 'TusLibros-Tests'!
TestCase subclass: #TusLibrosRestAPIInterfaceTest
	instanceVariableNames: 'testObjectsFactory clock systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosRestAPIInterfaceTest methodsFor: 'test objects' stamp: 'AF 11/27/2021 21:02:36'!
invalidPassword

	^'notAdmin'! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'test objects' stamp: 'AF 11/29/2021 12:34:35'!
validBook

	^ testObjectsFactory itemSellByTheStore! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'test objects' stamp: 'AF 11/29/2021 12:35:56'!
validBookPrice

	^ testObjectsFactory itemSellByTheStorePrice! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'test objects' stamp: 'AF 11/29/2021 12:19:03'!
validCreditCardNumber

	^ testObjectsFactory notExpiredCreditCardNumber! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'test objects' stamp: 'AF 11/29/2021 12:20:40'!
validCreditCardOwnerHttpEncoded

	^ self encodeSpacesForUrl: testObjectsFactory notExpiredCreditCardOwner! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'test objects' stamp: 'AF 11/29/2021 12:20:10'!
validExpirationDateHttpEncoded

	^ self encodeSpacesForUrl: testObjectsFactory notExpiredMonthOfYear asString! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'test objects' stamp: 'AF 11/29/2021 12:17:05'!
validUser

	^testObjectsFactory validUser! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'test objects' stamp: 'AF 11/29/2021 12:17:16'!
validUserPassword

	^testObjectsFactory validUserPassword ! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'test objects' stamp: 'MP 11/17/2021 15:48:17'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !


!TusLibrosRestAPIInterfaceTest methodsFor: 'setup' stamp: 'MP 11/17/2021 15:48:58'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'setup' stamp: 'AF 11/19/2021 20:02:30'!
debit: anAmount from: aCreditCard
! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'setup' stamp: 'MP 11/17/2021 15:49:07'!
merchantProcessor

	^self! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'setup' stamp: 'MP 11/17/2021 15:46:51'!
setUp
	
	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock
! !


!TusLibrosRestAPIInterfaceTest methodsFor: 'tests' stamp: 'AF 11/29/2021 10:06:58'!
test01CreateCartForValidCredentials

	|server responseDecoded responseExpected client |
	
	self setUp.
	server _ TusLibrosRestAPIInterface listeningOn: 8080 communicateWith: systemFacade.	
	client _ WebClient new.
	
	responseDecoded _ self sendCreateCartRequest: client.
	
	client close.
	server destroy.
	
	responseExpected := (Dictionary new) add: 'status' -> 0; add: 'cartId' -> 1; yourself.
	
	self assert: (responseExpected at: 'status') equals: (responseDecoded at: 'status') .
	self assert: (responseExpected at: 'cartId') equals: (responseDecoded at: 'cartId') .! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'tests' stamp: 'AF 11/29/2021 10:10:23'!
test02CreateCartForInvalidCredentials

	|server response client responseDecoded responseExpected|
	
	self setUp.
	
	server _ TusLibrosRestAPIInterface listeningOn: 8080 communicateWith: systemFacade.
	
	client _ WebClient new.
	response _ (client httpGet: 'http://localhost:8080/createCart?clientId=',self validUser,'&password=',self invalidPassword).
	responseDecoded _ self decodeJsonMapFrom: response.
	
	client close.
	server destroy.
	
	responseExpected := Dictionary new add: 'status' -> 1; add: 'errorDescription' -> (systemFacade invalidUserAndOrPasswordErrorDescription); yourself.
	
	self assert: (responseExpected at: 'status') equals: (responseDecoded at: 'status').
	self assert: (responseExpected at: 'errorDescription') equals: (responseDecoded at: 'errorDescription').
	! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'tests' stamp: 'AF 11/29/2021 12:31:56'!
test03AddToCartReturnsProperly

	|server client cartId responseDecoded responseExpected|
	self setUp.
	
	server _ TusLibrosRestAPIInterface listeningOn: 8080 communicateWith: systemFacade.
	
	client _ WebClient new.
	
	responseDecoded _ self sendCreateCartRequest: client.
	
	cartId _ responseDecoded at: 'cartId'.
	
	responseDecoded _ self sendAddToCartRequest: client withCartId: cartId .
	
	client close.
	server destroy.
	
	responseExpected _ (Dictionary new) add: 'status' -> 0; yourself.
	
	self assert: (responseExpected at: 'status') equals: (responseDecoded at: 'status') .! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'tests' stamp: 'AF 11/29/2021 12:35:29'!
test04ListCartReturnsProperly

	|server client cartId book response responseDecoded responseExpected|
	self setUp.
	book _ self validBook.
	
	server _ TusLibrosRestAPIInterface listeningOn: 8080 communicateWith: systemFacade.
	
	client _ WebClient new.
	
	responseDecoded _ self sendCreateCartRequest: client.
	
	cartId _ (responseDecoded at: 'cartId') asString.
	
	
	self sendAddToCartRequest: client withCartId: cartId .
	
	response _ (client httpGet: 'http://localhost:8080/listCart?cartId=',cartId ).
	responseDecoded _ self decodeJsonMapFrom: response.
	

	client close.
	server destroy.
	
	responseExpected _ (Dictionary new) add: 'status' -> 0; add: 'cartContents' -> ((Dictionary new) add: book -> 1 ;yourself) ; yourself.
	
	self assert: (responseExpected at: 'status') equals: (responseDecoded at: 'status') .
	self assert: ((responseExpected at: 'cartContents') at: book) equals: ((responseDecoded at: 'cartContents') at: book) .
	! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'tests' stamp: 'AF 11/29/2021 12:34:35'!
test05CheckOutReturnsProperly

	|server client cartId book responseDecoded responseExpected |
	self setUp.
	book _ self validBook.
	
	server _ TusLibrosRestAPIInterface listeningOn: 8080 communicateWith: systemFacade.
	
	client _ WebClient new.
	
	responseDecoded _ self sendCreateCartRequest: client.
	
	cartId _ (responseDecoded at: 'cartId') asString.

	self sendAddToCartRequest: client withCartId: cartId .	

	responseDecoded _ self sendCheckOutCartRequest: client withCartId: cartId.

	client close.
	server destroy.
	
	responseExpected _ (Dictionary new) add: 'status' -> 0; add: 'ticket' -> (Dictionary new add: book -> 10; yourself); yourself.
	
	self assert: (responseExpected at: 'status') equals: (responseDecoded at: 'status') .
	self assert: (responseExpected at: 'ticket') equals: (responseDecoded at: 'ticket').
	! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'tests' stamp: 'AF 11/29/2021 12:35:56'!
test06listPurchasesReturnsProperly

	|server client cartId book responseDecoded |
	self setUp.
	book _ self validBook.
	
	server _ TusLibrosRestAPIInterface listeningOn: 8080 communicateWith: systemFacade.
	
	client _ WebClient new.
	
	responseDecoded _ self sendCreateCartRequest: client.
	
	cartId _ (responseDecoded at: 'cartId') asString.

	client httpGet: 'http://localhost:8080/addToCart?cartId=',cartId,'&bookIsbn=', book, '&bookQuantity=2'.
	
	self sendCheckOutCartRequest: client withCartId: cartId.

	responseDecoded _ self sendListPurchases: client.

	client close.
	server destroy.
	
	self assert: (self validBookPrice * 2) equals: ((responseDecoded at: 'purchases') at: book)! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'tests' stamp: 'AF 11/29/2021 12:32:22'!
test07fetchCatalogReturnsProperly

	|server client responseDecoded |
	self setUp.
	
	server _ TusLibrosRestAPIInterface listeningOn: 8080 communicateWith: systemFacade.
	
	client _ WebClient new.

	responseDecoded _ self sendFetchCatalog: client.
	
	client close.
	server destroy.
	
	self assert: (testObjectsFactory defaultCatalog ) equals: (responseDecoded at: 'catalog')! !


!TusLibrosRestAPIInterfaceTest methodsFor: 'GUI testing' stamp: 'MK 11/29/2021 00:34:43'!
startTestServerAndLoginInterface

	|server|
	self setUp.
	
	server _ TusLibrosRestAPIInterface listeningOn: 8080 communicateWith: systemFacade.
	
	LoginWindow open.
	
	^ server.! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'GUI testing' stamp: 'MK 11/29/2021 00:41:47'!
startTestServerAndShopInterface

	|server cart |
	self setUp.
	
	server _ TusLibrosRestAPIInterface listeningOn: 8080 communicateWith: systemFacade.
	cart _ systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	CatalogWindow openWithUser: self validUser andPass: self validUserPassword andCart: cart.

	^ server.! !


!TusLibrosRestAPIInterfaceTest methodsFor: 'encoding' stamp: 'AF 11/19/2021 15:05:26'!
decodeJsonMapFrom: resp

	^ WebUtils jsonMapFrom: (resp content) readStream! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'encoding' stamp: 'MP 11/20/2021 16:10:28'!
encodeSpacesForUrl: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !


!TusLibrosRestAPIInterfaceTest methodsFor: 'request http' stamp: 'AF 11/29/2021 12:34:35'!
sendAddToCartRequest: aWebClient withCartId: aCartId

	| response |
	
	response _ (aWebClient httpGet: 'http://localhost:8080/addToCart?cartId=',aCartId asString,'&bookIsbn=', self validBook, '&bookQuantity=1').
	^self decodeJsonMapFrom: response.
! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'request http' stamp: 'AF 11/29/2021 12:21:10'!
sendCheckOutCartRequest: aWebClient withCartId: aCartId
	
	
	| response |

	response _ aWebClient httpGet: 'http://localhost:8080/checkOutCart?cartId=', aCartId ,
    										    '&ccn=', self validCreditCardNumber, 
    										  '&cced=', self validExpirationDateHttpEncoded,
    										   '&cco=', self validCreditCardOwnerHttpEncoded.
	
	^self decodeJsonMapFrom: response.! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'request http' stamp: 'AF 11/29/2021 10:05:08'!
sendCreateCartRequest: aWebClient

	| response |
	
	response _ (aWebClient httpGet: 'http://localhost:8080/createCart?clientId=',self validUser,'&password=',self validUserPassword ).
	^self decodeJsonMapFrom: response.
! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'request http' stamp: 'AF 11/29/2021 12:25:11'!
sendFetchCatalog: aWebClient
	
	
	| response |
	response _ (aWebClient httpGet: 'http://localhost:8080/fetchCatalog' ).

	^self decodeJsonMapFrom: response.! !

!TusLibrosRestAPIInterfaceTest methodsFor: 'request http' stamp: 'AF 11/29/2021 10:42:16'!
sendListPurchases: aWebClient
	
	
	| response |
	response _ (aWebClient httpGet: 'http://localhost:8080/listPurchases?clientId=',self validUser,'&password=',self validUserPassword ).
	^self decodeJsonMapFrom: response.
! !


!TusLibrosRestAPIInterfaceTest methodsFor: 'time' stamp: 'MK 11/29/2021 00:37:34'!
advanceTimeToExpireSession

	clock advanceTime: systemFacade sessionDuration + 1 minutes! !


!classDefinition: #TusLibrosSystemFacadeTest category: 'TusLibros-Tests'!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: 'testObjectsFactory clock systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 6/19/2018 11:41:46'!
test04CanAddItemsToACreatedCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.

	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self assert: ((systemFacade listCartIdentifiedAs: cartId) occurrencesOf: self validBook) equals: 1
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 11/26/2018 18:03:02'!
test05CanNotAddItemToNotCreatedCart

	self
		should: [systemFacade add: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 11/26/2018 18:03:17'!
test06CanNotAddItemNotSellByTheStore

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade add: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidItemErrorMessage.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 11/26/2018 18:03:58'!
test17CanNotAddToCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self revertTime: systemFacade sessionDuration.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:07:48'!
test14ListPurchasesIncludesBoughtItems

	| cartId purchases |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: '1111222233334444'
		ownedBy: 'Juan Perez'
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.

	self assert: (purchases at: self validBook) equals: (testObjectsFactory itemSellByTheStorePrice * 2).
	self assert: (purchases at: self anotherValidBook) equals: testObjectsFactory anotherItemSellByTheStorePrice.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:29'!
test15CanNotListPurchasesOfInvalidCustomer

	self
		should: [systemFacade listPurchasesOf: self invalidUser authenticatingWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:45'!
test16CanNotListPurchasesOfValidCustomerWithInvalidPassword

	self
		should: [systemFacade listPurchasesOf: self validUser authenticatingWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 6/19/2018 11:40:51'!
test01CanCreateCartWithValidUserAndPassword

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:23'!
test02CanNotCreateCartWithInvalidUser

	self
		should: [ systemFacade createCartFor: self invalidUser authenticatedWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:33'!
test03CanNotCreateCartWithInvalidPassword

	self
		should: [ systemFacade createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/22/2013 11:48'!
debit: anAmount from: aCreditCard
! !


!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:42'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:47'!
merchantProcessor

	^self! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2015 20:53'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock
! !


!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook

	^testObjectsFactory anotherItemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:25'!
invalidCartId

	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword

	^'invalidPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'AF 11/27/2021 21:04:02'!
invalidUser

	^'notAdmin'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook

	^testObjectsFactory itemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'AF 11/29/2021 12:17:41'!
validUser

	^testObjectsFactory validUser ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'AF 11/29/2021 12:17:52'!
validUserPassword

	^testObjectsFactory validUserPassword ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:43'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 6/19/2018 11:45:13'!
test10CanCheckoutACart

	| cartId purchases |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.

	self assert: (purchases at: self validBook) equals: testObjectsFactory itemSellByTheStorePrice.
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:05:20'!
test11CanNotCheckoutANotCreatedCart

	self
		should: [systemFacade
			checkOutCartIdentifiedAs: self invalidCartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:06:07'!
test12CanNotCheckoutAnEmptyCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade cartCanNotBeEmptyErrorMessage.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:07:02'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:07:15'!
test19CanNotCheckOutCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self should: [
		systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]


	! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:15'!
test08CanNotListCartOfInvalidCartId

	self
		should: [systemFacade listCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:32'!
test09ListCartReturnsTheRightNumberOfItems

	| cartId cartContent |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	cartContent := systemFacade listCartIdentifiedAs: cartId.

	self assert: (cartContent occurrencesOf: self validBook) equals: 1.
	self assert: (cartContent occurrencesOf: self anotherValidBook) equals: 2
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:42'!
test18CanNotListCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade listCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription ].

! !


!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
advanceTime: aDuration

	clock advanceTime: aDuration ! !

!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:07'!
revertTime: aDuration

	clock revertTime: aDuration ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-Tests'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore

	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice

	^15! !

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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AF 11/28/2021 14:53:55'!
defaultCatalog

	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		
		add: 'Moby Dick' -> 1000;
		add: 'Winnie The Pooh' -> 900;
		add: 'Haikyuu!!!!' -> 450;
		add: 'Eragon' -> 1200;
		add: 'The Shining' -> 650;
		"add: 'Eldest' -> 1250;"
		add: 'Legado' -> 1100;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredCreditCard

	^CreditCard expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard

	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:30'!
notExpiredCreditCardNumber

	^ '1111222233334444' ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:48'!
notExpiredCreditCardOwner

	^'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today

	^ today! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'HernanWilkinson 6/22/2013 12:02'!
customer

	^'aCustomer'! !

!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'AF 11/29/2021 12:16:05'!
validUser

	^'admin'.! !

!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'AF 11/29/2021 12:16:11'!
validUserPassword

	^'admin'.! !


!classDefinition: #ManualClock category: 'TusLibros-Tests'!
ProtoObject subclass: #ManualClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 12:54'!
advanceTime: aDuration

	now := now + aDuration ! !

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 13:08'!
revertTime: aDuration

	now := now + aDuration negated ! !


!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:56'!
now

	^ now! !

!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
today

	^now date! !


!ManualClock methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:52'!
initializeNow: aTime

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: 'TusLibros-Tests'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:52'!
now: aTime

	^self new initializeNow: aTime ! !
