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

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/15/2021 19:02:39'!
test03PortfolioWithOnePortfolioMatchesItsBalance
	| portfolio1 account portfolio2 |
	portfolio1 _ Portfolio new.
	account _ ReceptiveAccount new.
	Deposit register: 50 on: account.
	portfolio2 _ Portfolio new.
	
	portfolio1 addMonetaryService: account.
	portfolio2 addMonetaryService: portfolio1.
	self assert: (portfolio2 balance = 50).
	! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'MK 10/15/2021 19:28:52'!
test04PortfolioWithTwoAccountsMatchesBalance
	| portfolio account1 account2 |
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.
	Deposit register: 50 on: account1.
	account2 _ ReceptiveAccount new.
	Deposit register: 100 on: account2.
	
	portfolio addMonetaryService: account1.
	portfolio addMonetaryService: account2.
	self assert: (portfolio balance = 150).
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
	instanceVariableNames: 'monetaryServices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet undefined' stamp: 'MK 10/15/2021 19:32:29'!
addMonetaryService: aMonetaryService 
	monetaryServices add: aMonetaryService.! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'MK 10/15/2021 19:32:29'!
balance
	monetaryServices isEmpty ifTrue: [^ 0].
	^ monetaryServices sum: [:anAccount | anAccount balance].! !

!Portfolio methodsFor: 'as yet undefined' stamp: 'MK 10/15/2021 19:32:29'!
initialize
	monetaryServices _ OrderedCollection new.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'balance' stamp: 'MK 10/14/2021 21:40:21'!
balance
	|depositSum withdrawSum|
	depositSum _ (transactions select: [:aTransaction | aTransaction class = Deposit ]) sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ].
	withdrawSum _ (transactions select: [:aTransaction | aTransaction class = Withdraw ]) sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ].
	^ depositSum - withdrawSum ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
