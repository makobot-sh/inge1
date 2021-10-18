!classDefinition: #PortfolioTests category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:16:46'!
test01EmptyPortfolioHasBalance0
	| portfolio |
	portfolio _ self createPortfolioWith: OrderedCollection new.
	self assert: portfolio balance = 0.
	! !

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:17:45'!
test02PortfolioWithOneAccountMatchesItsBalance
	| portfolio account |
	account _ ReceptiveAccount new.
	Deposit register: 50 on: account.
	portfolio _ self createPortfolioWith: (OrderedCollection with: account ).

	self assert: portfolio balance = 50.
	! !

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:19:37'!
test03PortfolioWithPortfolioWithTwoAccountsMatchesBalance
	| portfolio1 portfolio2 account1 account2 |
	account1 _ ReceptiveAccount new.
	Deposit register: 100 on: account1.
	account2 _ ReceptiveAccount new.
	Withdraw register: 25 on: account2.
	
	portfolio1  := self createPortfolioWith: (OrderedCollection with: account1 with: account2).
	
	portfolio2 := self createPortfolioWith: (OrderedCollection with: portfolio1).
	self assert: portfolio2 balance = 75.
	! !

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:20:04'!
test04EmptyPortfolioHasNotRegisteredTransaction
	| portfolio1 transaction |
	portfolio1 _ self createPortfolioWith: OrderedCollection new.
	transaction _ Deposit for: 50.
	
	self assert: (portfolio1 hasRegistered: transaction ) not.
	! !

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:16:13'!
test05PortfolioHasRegisteredTransactionThatIsInAddedAccount
	| portfolio transaction account |
	account _ ReceptiveAccount new.
	transaction _ Deposit register: 50 on: account.
	
	portfolio := self createPortfolioWith: (OrderedCollection with: account ).
	
	self assert: (portfolio hasRegistered: transaction ).
	! !

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:21:45'!
test06PortfolioHasRegisteredTransactionThatIsInSecondAccountAdded
	| portfolio transaction account1 account2 |
	account1 _ ReceptiveAccount new.
	Deposit register: 50 on: account1.
	account2 _ ReceptiveAccount new.
	transaction _ Deposit register: 100 on: account2.
	
	portfolio := self createPortfolioWith: (OrderedCollection with: account1 with: account2).
	
	self assert: (portfolio hasRegistered: transaction ).! !

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:31:52'!
test07PortfolioCannotAddPortfolioThatWasPreviouslyAddedAndLaterModified
	| portfolio1 portfolio2 account |
	
	account _ ReceptiveAccount new.
	Deposit register: 50 on: account.
		portfolio2 := self createPortfolioWith: OrderedCollection new.

	portfolio1 := self createPortfolioWith: (OrderedCollection with: portfolio2).
	portfolio2 addMonetaryService: account.
	self should: [portfolio1 addMonetaryService: portfolio2] 
		raise: Error
		withExceptionDo: [ :anError |
				self assert: anError messageText = Portfolio cannotAddDuplicatedAccountErrorDescription]! !

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:31:32'!
test08PortfolioCannotAddAccountThatIsInPreviouslyAddedPortfolio
	| portfolio1 portfolio2 account |
	account _ ReceptiveAccount new.
	Deposit register: 50 on: account.
	portfolio2 := self createPortfolioWith: OrderedCollection new.

	portfolio1 := self createPortfolioWith: (OrderedCollection with: portfolio2 ).
	portfolio2 addMonetaryService: account.
	self should: [portfolio1 addMonetaryService: account.] 
		raise: Error
		withExceptionDo: [ :anError |
				self assert: anError messageText = Portfolio cannotAddDuplicatedAccountErrorDescription]! !

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:41:29'!
test09PortfolioCannotAddAccountThatWasInParent
	| portfolioRoot portfolio1 portfolio2 account |
	
	account _ ReceptiveAccount new.
	Deposit register: 50 on: account.
	portfolio1 := self createPortfolioWith: OrderedCollection new.

	portfolioRoot := self createPortfolioWith: (OrderedCollection with: portfolio1 with: account).	
	portfolio2 := self createPortfolioWith: (OrderedCollection with: account).
	self should: [portfolio1 addMonetaryService: portfolio2.] 
		raise: Error
		withExceptionDo: [ :anError |
				self assert: anError messageText = Portfolio cannotAddDuplicatedAccountErrorDescription]! !

!PortfolioTests methodsFor: 'testing' stamp: 'AF 10/18/2021 16:47:44'!
test10PortfolioCannotAddAccountThatWasInGrandparent
	| portfolio0 portfolio1 portfolio2 portfolio3 account1 |

	account1 _ ReceptiveAccount new.
	Deposit register: 50 on: account1.
		portfolio1 := self createPortfolioWith: OrderedCollection new .
	portfolio2 _ self createPortfolioWith: OrderedCollection new.

	portfolio0 := self createPortfolioWith: (OrderedCollection with: portfolio1 ).
	portfolio1 addMonetaryService: portfolio2.	
	portfolio0 addMonetaryService: account1.
	portfolio3 := self createPortfolioWith: (OrderedCollection with: account1 ).
	self should: [portfolio2 addMonetaryService: portfolio3.] 
		raise: Error
		withExceptionDo: [ :anError |
				self assert: anError messageText = Portfolio cannotAddDuplicatedAccountErrorDescription]! !

!PortfolioTests methodsFor: 'testing' stamp: 'MK 10/18/2021 15:23:46'!
test11PortfolioCannotAddAccountThatIsInSecondParent
	"This test made sense when parent was a single portfolio instead of a collection of portfolios, since only the last portfolio that parented the current portfolio was saved as parent."
	| portfolio1 portfolio0 portfolio2 account1 |
	portfolio0 _ Portfolio new.
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	portfolio0 addMonetaryService: portfolio2.	
	portfolio1 addMonetaryService: portfolio2.
	portfolio0 addMonetaryService: account1.
	self should: [portfolio2 addMonetaryService: account1.] 
		raise: Error
		withExceptionDo: [ :anError |
				self assert: anError messageText = Portfolio cannotAddDuplicatedAccountErrorDescription]! !

!PortfolioTests methodsFor: 'testing' stamp: 'Chiro 10/17/2021 11:18:11'!
test12PortfolioHasNoTransactions
	| portfolio|
	portfolio _ Portfolio new.
	
	self assert: OrderedCollection new = portfolio transactions.
	! !

!PortfolioTests methodsFor: 'testing' stamp: 'Chiro 10/17/2021 11:22:58'!
test13PortfolioTransactionsHasOneTransaction
	| portfolio account1 transaction|
	portfolio _ Portfolio new.
	
	account1 _ ReceptiveAccount new.
	transaction _ Deposit for: 50.
	account1 register: transaction.
	portfolio addMonetaryService: account1.
	
	self assert: (OrderedCollection with: transaction) = portfolio transactions.
	! !

!PortfolioTests methodsFor: 'testing' stamp: 'Chiro 10/17/2021 11:39:00'!
test14PortfolioTransactionsHasInnerPortfolioTransactions
	| portfolio1 portfolio2 account1 account2 transaction2 transaction1|
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	
	account1 _ ReceptiveAccount new.
	transaction1 _ Deposit for: 50.
	account2 _ ReceptiveAccount new.
	transaction2 _ Deposit for: 100.
	account1 register: transaction1.
	account2 register: transaction2.

	portfolio1 addMonetaryService: account1.
	portfolio2 addMonetaryService: account2.
	portfolio1 addMonetaryService: portfolio2.
	self assert: (OrderedCollection with: transaction1 with: transaction2) = portfolio1 transactions.
	! !


!PortfolioTests methodsFor: 'monetaryService creation' stamp: 'AF 10/18/2021 16:10:29'!
createPortfolioWith: aCollectionOfMonetaryServices 

	| portfolio |
	
	portfolio _ Portfolio new.
	
	aCollectionOfMonetaryServices do: [:aMonetaryService | portfolio addMonetaryService: aMonetaryService ].
	^portfolio.
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MK 10/18/2021 13:50:55'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 
	| account |
	
	account := ReceptiveAccount new.
	self assert: 0 equals: account balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MK 10/18/2021 13:51:13'!
test02DepositIncreasesBalanceOnTransactionValue 
	| account |
	
	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	
	self assert: 100 equals: account balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MK 10/14/2021 21:37:16'!
test03WithdrawDecreasesBalanceOnTransactionValue 
	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MK 10/18/2021 13:51:32'!
test04WithdrawValueMustBePositive 
	| account withdrawValue |
	
	account := ReceptiveAccount new.
	
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MK 10/18/2021 13:51:54'!
test05ReceptiveAccountKnowsRegisteredTransactions 
	| account deposit withdraw |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MK 10/18/2021 13:52:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MK 10/18/2021 13:52:31'!
test07AccountKnowsItsTransactions 
	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 50 on: account1.

	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'initialization' stamp: 'MK 10/14/2021 21:30:43'!
initializeFor: aValue

	value := aValue ! !


!AccountTransaction methodsFor: 'value' stamp: 'MK 10/18/2021 14:32:02'!
balance
	^ self subclassResponsibility.! !

!AccountTransaction methodsFor: 'value' stamp: 'MK 10/14/2021 21:33:01'!
value
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MK 10/14/2021 21:30:21'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MK 10/14/2021 21:30:07'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
	
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'balance' stamp: 'MK 10/18/2021 14:33:42'!
balance
	^ self value.! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'balance' stamp: 'AF 10/18/2021 15:54:29'!
balance
	^ self value * -1.! !


!classDefinition: #MonetaryService category: 'Portfolio-Ejercicio'!
Object subclass: #MonetaryService
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!MonetaryService methodsFor: 'initialization' stamp: 'AF 10/18/2021 09:07:17'!
initialize

	^self subclassResponsibility.! !


!MonetaryService methodsFor: 'testing' stamp: 'AF 10/18/2021 09:07:57'!
canBeAddedTo: aPortfolio

	^self subclassResponsibility.! !

!MonetaryService methodsFor: 'testing' stamp: 'MK 10/18/2021 15:03:50'!
canCoexistWith: anAccount

	^self subclassResponsibility.! !

!MonetaryService methodsFor: 'testing' stamp: 'AF 10/18/2021 09:06:23'!
hasRegistered: aTransaction

	^self subclassResponsibility.! !


!MonetaryService methodsFor: 'transactions' stamp: 'AF 10/18/2021 09:06:34'!
transactions

	^self subclassResponsibility.! !


!MonetaryService methodsFor: 'balance' stamp: 'AF 10/18/2021 09:04:29'!
balance

	^self subclassResponsibility.! !


!MonetaryService methodsFor: 'operations' stamp: 'AF 10/18/2021 09:10:42'!
becomeChildOf: aPortfolio

	^self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
MonetaryService subclass: #Portfolio
	instanceVariableNames: 'monetaryServices parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'transactions' stamp: 'Chiro 10/17/2021 11:40:01'!
transactions
	|totalTransactions|
	totalTransactions _ OrderedCollection new.
	monetaryServices do: [:service |totalTransactions addAllLast: service transactions].
	^totalTransactions.! !


!Portfolio methodsFor: 'testing' stamp: 'MK 10/18/2021 14:25:02'!
canAdd: aMonetaryService
	^ self serviceTreeDoesNotHave: aMonetaryService.! !

!Portfolio methodsFor: 'testing' stamp: 'AF 10/18/2021 15:48:06'!
canAddMonetaryServices: aCollectionOfMonetaryServices
	^aCollectionOfMonetaryServices allSatisfy: [:aMonetaryService | aMonetaryService canBeAddedTo: self].! !

!Portfolio methodsFor: 'testing' stamp: 'AF 10/18/2021 15:48:06'!
canBeAddedTo: aPortfolio

	^aPortfolio canAddMonetaryServices: monetaryServices.! !

!Portfolio methodsFor: 'testing' stamp: 'MK 10/18/2021 15:05:15'!
canCoexistWith: anAccount
	^ self hasAccount: anAccount.! !

!Portfolio methodsFor: 'testing' stamp: 'MK 10/18/2021 15:04:58'!
hasAccount: anAccount
	^monetaryServices allSatisfy: [:aService | aService canCoexistWith: anAccount].! !

!Portfolio methodsFor: 'testing' stamp: 'MK 10/16/2021 16:09:44'!
hasRegistered: aTransaction 
	^ (monetaryServices anySatisfy: [:service | service hasRegistered: aTransaction ]).! !

!Portfolio methodsFor: 'testing' stamp: 'MK 10/18/2021 14:16:46'!
serviceTreeDoesNotHave: aMonetaryService
	parents isEmpty ifTrue: [
		^(aMonetaryService canBeAddedTo: self)
	].
	^parents allSatisfy: [:myParent | myParent serviceTreeDoesNotHave: aMonetaryService]! !


!Portfolio methodsFor: 'initialization' stamp: 'MK 10/16/2021 17:50:49'!
initialize
	monetaryServices _ OrderedCollection new.
	parents _ OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'AF 10/18/2021 09:05:03'!
balance
	^ monetaryServices sum: [:aMonetaryService | aMonetaryService balance] ifEmpty: [^ 0].! !


!Portfolio methodsFor: 'operations' stamp: 'MK 10/18/2021 14:25:22'!
addMonetaryService: aMonetaryService 
	(self canAdd: aMonetaryService) ifFalse:[
		^self error: self class cannotAddDuplicatedAccountErrorDescription.
	].
	
	monetaryServices add: aMonetaryService.
	aMonetaryService becomeChildOf: self.

	
	! !

!Portfolio methodsFor: 'operations' stamp: 'Chiro 10/17/2021 12:19:44'!
becomeChildOf: aPortfolio
	parents add: aPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'MK 10/16/2021 13:49:51'!
cannotAddDuplicatedAccountErrorDescription
	^ 'Cannot add account to portfolio if it was already present.'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
MonetaryService subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MK 10/15/2021 18:44:13'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'MK 10/15/2021 18:44:28'!
register: aTransaction

	transactions add: aTransaction ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'MK 10/15/2021 18:44:34'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MK 10/18/2021 14:35:41'!
balance
	^ transactions sum: [ :aTransaction | aTransaction balance ] ifEmpty: [ 0 ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'MK 10/18/2021 15:03:50'!
canBeAddedTo: aPortfolio
	^aPortfolio canCoexistWith: self! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'MK 10/18/2021 15:03:50'!
canCoexistWith: anAccount

	^ self ~= anAccount .! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'MK 10/16/2021 12:49:43'!
hasRegistered: aTransaction
	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'Chiro 10/17/2021 12:18:59'!
becomeChildOf: aPortfolio
	! !
