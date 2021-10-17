!classDefinition: #PortfolioTests category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/14/2021 21:44:11'!
test01EmptyPortfolioHasBalance0
	| portfolio |
	portfolio _ Portfolio new.
	self assert: portfolio balance = 0.
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/15/2021 18:55:50'!
test02PortfolioWithOneAccountMatchesItsBalance
	| portfolio account |
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	portfolio addMonetaryService: account.
	self assert: (portfolio balance = 50).
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/16/2021 12:29:53'!
test03PortfolioWithPortfolioWithTwoAccountsMatchesBalance
	| portfolio1 portfolio2 account1 account2 |
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	Deposit register: 100 on: account1.
	account2 _ ReceptiveAccount new.
	Withdraw register: 25 on: account2.
	
	portfolio1 addMonetaryService: account1.
	portfolio1 addMonetaryService: account2.
	portfolio1 addMonetaryService: portfolio2.
	self assert: (portfolio1 balance = 75).
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/16/2021 17:13:38'!
test04EmptyPortfolioHasNotRegisteredTransaction
	| portfolio1 transaction |
	portfolio1 _ Portfolio new.
	transaction _ Deposit for: 50.
	
	self assert: (portfolio1 hasRegistered: transaction ) not.
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/16/2021 17:12:35'!
test05PortfolioHasRegisteredTransactionThatIsInAddedAccount
	| portfolio1 transaction account |
	portfolio1 _ Portfolio new.
	account _ ReceptiveAccount new.
	transaction _ Deposit register: 50 on: account.
	
	portfolio1 addMonetaryService: account.
	
	self assert: (portfolio1 hasRegistered: transaction ).
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/16/2021 17:13:15'!
test06PortfolioHasRegisteredTransactionThatIsInSecondAccountAdded
	| portfolio1 transaction account1 account2 |
	portfolio1 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	Deposit register: 50 on: account1.
	transaction _ Deposit register: 100 on: account2.
	
	portfolio1 addMonetaryService: account1.
	portfolio1 addMonetaryService: account2.
	
	self assert: (portfolio1 hasRegistered: transaction ).
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/16/2021 17:14:37'!
test07PortfolioCannotAddPortfolioThatWasPreviouslyAdded
	| portfolio1 portfolio2 account1 |
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	portfolio2 addMonetaryService: account1.
	portfolio1 addMonetaryService: portfolio2.
	self should: [portfolio1 addMonetaryService: portfolio2] 
		raise: Error
		withExceptionDo: [ :anError |
				self assert: anError messageText = Portfolio cannotAddDuplicatedAccountErrorDescription]! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/16/2021 17:14:58'!
test08PortfolioCannotAddAccountThatIsInPreviouslyAddedPortfolio
	| portfolio1 portfolio2 account1 |
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	portfolio2 addMonetaryService: account1.
	portfolio1 addMonetaryService: portfolio2.
	self should: [portfolio1 addMonetaryService: account1.] 
		raise: Error
		withExceptionDo: [ :anError |
				self assert: anError messageText = Portfolio cannotAddDuplicatedAccountErrorDescription]! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/16/2021 17:41:00'!
test09PortfolioCannotAddAccountThatWasInParent
	| portfolio0 portfolio1 portfolio2 account1 |
	portfolio0 _ Portfolio new.
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	portfolio0 addMonetaryService: portfolio1.	
	portfolio0 addMonetaryService: account1.
	portfolio2 addMonetaryService: account1.
	self should: [portfolio1 addMonetaryService: portfolio2.] 
		raise: Error
		withExceptionDo: [ :anError |
				self assert: anError messageText = Portfolio cannotAddDuplicatedAccountErrorDescription]! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/16/2021 17:43:54'!
test10PortfolioCannotAddAccountThatWasInGrandparent
	| portfolio0 portfolio1 portfolio2 portfolio3 account1 |
	portfolio0 _ Portfolio new.
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	portfolio0 addMonetaryService: portfolio1.
	portfolio1 addMonetaryService: portfolio2.	
	portfolio0 addMonetaryService: account1.
	portfolio3 addMonetaryService: account1.
	self should: [portfolio2 addMonetaryService: portfolio3.] 
		raise: Error
		withExceptionDo: [ :anError |
				self assert: anError messageText = Portfolio cannotAddDuplicatedAccountErrorDescription]! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/16/2021 17:49:37'!
test11PortfolioCannotAddAccountThatIsInSecondParent
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

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'Chiro 10/17/2021 11:18:11'!
test12PortfolioHasNoTransactions
	| portfolio|
	portfolio _ Portfolio new.
	
	self assert: OrderedCollection new = portfolio transactions.
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'Chiro 10/17/2021 11:22:58'!
test13PortfolioTransactionsHasOneTransaction
	| portfolio account1 transaction|
	portfolio _ Portfolio new.
	
	account1 _ ReceptiveAccount new.
	transaction _ Deposit for: 50.
	account1 register: transaction.
	portfolio addMonetaryService: account1.
	
	self assert: (OrderedCollection with: transaction) = portfolio transactions.
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'Chiro 10/17/2021 11:39:00'!
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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MK 10/14/2021 21:37:16'!
test03WithdrawDecreasesBalanceOnTransactionValue 
	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
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


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'monetaryServices parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet undefined' stamp: 'Chiro 10/17/2021 13:47:27'!
XXXX: anAccount
	"XXXX was hasAccount"
	^monetaryServices allSatisfy: [:aService | aService XXXX: anAccount].! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'Chiro 10/17/2021 13:42:13'!
addMonetaryService: aMonetaryService 
	(self familiyDoesNotHave: aMonetaryService) ifFalse:[
		^self error: self class cannotAddDuplicatedAccountErrorDescription.
	].
	
	monetaryServices add: aMonetaryService.
	aMonetaryService becomeChildOf: self.

	
	! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'MK 10/16/2021 12:09:23'!
balance
	^ monetaryServices sum: [:anAccount | anAccount balance] ifEmpty: [^ 0].! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'Chiro 10/17/2021 12:19:44'!
becomeChildOf: aPortfolio
	parents add: aPortfolio.! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'Chiro 10/17/2021 13:00:17'!
canBeAddedTo: aPortfolio
	^monetaryServices allSatisfy: [:aService | aService canBeAddedTo: aPortfolio].! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'Chiro 10/17/2021 13:44:06'!
familiyDoesNotHave: aMonetaryService
	parents isEmpty ifTrue: [
		^(aMonetaryService canBeAddedTo: self)
	].
	^parents allSatisfy: [:myParent | myParent familiyDoesNotHave: aMonetaryService]! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'MK 10/16/2021 16:09:44'!
hasRegistered: aTransaction 
	^ (monetaryServices anySatisfy: [:service | service hasRegistered: aTransaction ]).! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'MK 10/16/2021 17:50:49'!
initialize
	monetaryServices _ OrderedCollection new.
	parents _ OrderedCollection new.! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'Chiro 10/17/2021 11:40:01'!
transactions
	|totalTransactions|
	totalTransactions _ OrderedCollection new.
	monetaryServices do: [:service |totalTransactions addAllLast: service transactions].
	^totalTransactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'MK 10/16/2021 13:49:51'!
cannotAddDuplicatedAccountErrorDescription
	^ 'Cannot add account to portfolio if it was already present.'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MK 10/15/2021 18:44:13'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'Chiro 10/17/2021 13:04:57'!
XXXX: anAccount

	^ self ~= anAccount .! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'MK 10/15/2021 18:44:28'!
register: aTransaction

	transactions add: aTransaction ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'MK 10/15/2021 18:44:34'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MK 10/14/2021 21:40:21'!
balance
	|depositSum withdrawSum|
	depositSum _ (transactions select: [:aTransaction | aTransaction class = Deposit ]) sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ].
	withdrawSum _ (transactions select: [:aTransaction | aTransaction class = Withdraw ]) sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ].
	^ depositSum - withdrawSum ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'MK 10/16/2021 12:49:43'!
hasRegistered: aTransaction
	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'Chiro 10/17/2021 12:18:59'!
becomeChildOf: aPortfolio
	! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'Chiro 10/17/2021 12:49:26'!
canBeAddedTo: aPortfolio
	^aPortfolio XXXX: self! !
