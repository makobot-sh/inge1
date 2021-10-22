!classDefinition: #PortfolioTest category: 'Portfolio 2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio 2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio 2'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:02:22'!
test01AccountSummaryOfEmptyAccountReturnsOneLineWithBalance

	|accountSummary|
	
	accountSummary := AccountSummary for: ReceptiveAccount new.
	
	
	
	self assert: 'Balance = 0' equals: accountSummary makeReport.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 16:21:24'!
test02AccountSummaryOfAccountWithOneDepositReturnsALineForDepositAndALineForBalance

	|account		accountSummary|
	
	account := ReceptiveAccount new.
	
	accountSummary := AccountSummary for: account.
	
	Deposit register: 50 on: account. 
	
	self assert: accountSummary makeReport equals: (String streamContents: [:aStream | aStream     		nextPutAll: 'Depósito por 50'; 
																				nextPut: $.;
																				newLine; 
																				nextPutAll: 'Balance = 50']).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 16:22:06'!
test03AccountSummaryOfAccountWithOneWithdrawalReturnsALineForWithdrawAndALineForBalance

	|account		accountSummary|
	
	account := ReceptiveAccount new.
	
	accountSummary := AccountSummary for: account.
	
	Withdraw register: 50 on: account. 
	
	self assert: accountSummary makeReport equals: (String streamContents: [:aStream | aStream     		nextPutAll: 'Extracción por 50'; 
																				nextPut: $.;
																				newLine; 
																				nextPutAll: 'Balance = -50']).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 16:22:45'!
test04AccountSummaryOfAccountReturnsALineForEachTransactionAndAnotherOneForBalance

	|account		accountSummary|
	
	account := ReceptiveAccount new.
	
	accountSummary := AccountSummary for: account.
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account. 
	
	self assert: accountSummary makeReport equals: (String streamContents: [:aStream | aStream     nextPutAll: 'Depósito por 100';		
																		 		nextPut: $.;
																				newLine;	
																				nextPutAll: 'Extracción por 50'; 
																				nextPut: $.;
																				newLine; 
																				nextPutAll: 'Balance = 50']).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 16:24:44'!
test05AccountSummaryShowsTransfersOnSender

	|sender receiver 	accountSummary|
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	accountSummary := AccountSummary for: sender.
	
	Transfer from: sender to: receiver amount: 50.
	
	self assert: accountSummary makeReport equals: (String streamContents: [:aStream | aStream     nextPutAll: 'Salida por transferencia de 50';		
																				nextPut: $.;
																				newLine; 
																				nextPutAll: 'Balance = -50']).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 16:25:44'!
test06AccountSummaryShowsTransfersOnReceiver

	|sender receiver 	accountSummary|
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	accountSummary := AccountSummary for: receiver.
	
	Transfer from: sender to: receiver amount: 50.
	
	self assert: accountSummary makeReport equals: (String streamContents: [:aStream | aStream     nextPutAll: 'Entrada por transferencia de 50';		
																				nextPut: $.;
																				newLine; 
																				nextPutAll: 'Balance = 50']).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:38:19'!
test07TransferNetReturnsZeroOnEmptyAccount

	|transferNet|
	
	transferNet := TransferNet for: ReceptiveAccount new.

	self assert: 0 equals: transferNet makeReport! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:39:17'!
test08TransferNetReturnsCorrectValueOnAccountWithOneTransferOut

	|sender receiver transferNet|
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	transferNet  := TransferNet for: sender.
	
	Transfer from: sender to: receiver amount: 50. 
	
	self assert: -50 equals: transferNet makeReport.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:39:50'!
test09TransferNetReturnsCorrectValueOnAccountWithOneTransferIn

	|sender receiver transferNet|
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	transferNet  := TransferNet for: receiver.
	
	Transfer from: sender to: receiver amount: 50. 
	
	self assert: 50 equals: transferNet makeReport.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:41:30'!
test10TransferNetDoesNotCountNonTranferTransactions

	|transferNet account|
	
	account := ReceptiveAccount new.
	transferNet := TransferNet for: account.
	
	Deposit register: 100 on: account.
	
	self assert: 0 equals: transferNet makeReport.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:56:56'!
test11TransferNetReturnsCorrectValueOnAccountWithATransferAndANonTransferTransactions

	|sender receiver transferNet|
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	transferNet  := TransferNet for: sender.
	
	Withdraw register: 100 on: sender.
	
	Transfer from: sender to: receiver amount: 50.
	
	self assert: -50 equals: transferNet makeReport .! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 17:16:23'!
test12

	|portfolio accountSummary |
	
	portfolio := Portfolio new.
	
	accountSummary := AccountSummary for: portfolio.
	
	self assert: accountSummary makeReport equals: 'Balance = 0'
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:58:41'!
test13

	|portfolio transferNet |
	
	portfolio := Portfolio new.
	
	transferNet := TransferNet for: portfolio.
	
	self assert: transferNet makeReport equals: 0
	
	
	! !


!classDefinition: #TransferTest category: 'Portfolio 2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 10/18/2021 21:20:40'!
test01CanNotTransferAZeroAmount

	|sender receiver|
	
	sender := ReceptiveAccount new.
	receiver  := ReceptiveAccount new.
	
	self should: [Transfer from: sender to: receiver amount: 0.]
		raise: Error
		withExceptionDo: [: anError | anError messageText = Transfer amountCanNotBeLessOrEqualToZeroErrorDescription]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 10/18/2021 20:39:06'!
test02TransferReflectsCorrectlyOnBothPartiesBalances

	|sender receiver|
	
	sender := ReceptiveAccount new.
	receiver  := ReceptiveAccount new.
	
	Transfer from: sender to: receiver amount: 50.
	
	self assert: (sender balance = -50 and: [receiver balance = 50]).
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 10/18/2021 21:06:52'!
test03SenderAndReceiverCanNotBeTheSame

	|sender receiver|
	
	sender := ReceptiveAccount new.
	receiver  := sender.
	
	self should: [Transfer from: sender to: receiver amount: 50.]
		raise: Error
		withExceptionDo: [:anError | anError messageText = Transfer senderCanNotBeReceiverErrorDescription]
	
	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 10/18/2021 21:31:46'!
test04CanNotTranferANegativeAmount


	|sender receiver|
	
	sender := ReceptiveAccount new.
	receiver  := ReceptiveAccount new.
	
	self should: [Transfer from: sender to: receiver amount: -50.]
		raise: Error
		withExceptionDo: [:anError | anError messageText = Transfer amountCanNotBeLessOrEqualToZeroErrorDescription ]
	
	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:27:19'!
test07SenderHasTheWithdrawalRegisteredAfterTranfer


	|sender receiver transfer|
	
	sender := ReceptiveAccount new.
	receiver  := ReceptiveAccount new.
	
	transfer := Transfer from: sender to: receiver amount: 100.
	
	self assert: (sender hasRegistered: transfer originTransaction).
	
	
	
	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:29:27'!
test08ReceiverHasTheDepositRegisteredAfterTransfer


	|sender receiver transfer|
	
	sender := ReceptiveAccount new.
	receiver  := ReceptiveAccount new.
	
	transfer := Transfer from: sender to: receiver amount: 100.
	
	self assert: (receiver hasRegistered: transfer endTransaction).
	
	
	
	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:29:27'!
test09ReceiversTransactionKnowsSendersTransaction


	|sender receiver transfer transferIn|
	
	sender := ReceptiveAccount new.
	receiver  := ReceptiveAccount new.
	
	transfer := Transfer from: sender to: receiver amount: 100.
	
	transferIn := transfer endTransaction.
	
	self assert: ( transferIn transfer originTransaction = transfer originTransaction ).
	
	
	
	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:29:27'!
test10SendersTransactionKnowsReceiversTransaction


	|sender receiver transfer transferOut|
	
	sender := ReceptiveAccount new.
	receiver  := ReceptiveAccount new.
	
	transfer := Transfer from: sender to: receiver amount: 100.
	
	transferOut := transfer originTransaction .
	
	self assert: ( transferOut transfer endTransaction = transfer endTransaction ).
	
	
	
	
! !


!classDefinition: #Account category: 'Portfolio 2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio 2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'AF 10/22/2021 19:00:06'!
affectTransferNet: aTransferNet 
	
	accounts do: [:anAccount | anAccount affectTransferNet: aTransferNet ]! !

!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'AF 10/22/2021 18:04:35'!
affectAccountSummary: anAccountSummary

	accounts do: [:anAccount | anAccount affectAccountSummary: anAccountSummary]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio 2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio 2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AF 10/22/2021 18:04:21'!
affectAccountSummary: anAccountSummary 
	
	
	^transactions do: [:aTransaction | aTransaction affectAccountSummary: anAccountSummary] .! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AF 10/22/2021 18:48:06'!
affectTransferNet: aTransferNet 
	transactions do: [:aTransaction | aTransaction affectTransferNet: aTransferNet ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountSummary category: 'Portfolio 2'!
Object subclass: #AccountSummary
	instanceVariableNames: 'account accountSummaryStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:23:56'!
applyDepositOfValue: aDepositValue

	self writeLine: 'Depósito por ' OnAccountSummaryStreamWithValue: aDepositValue asString.
! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:23:18'!
applyTransferInOfValue: aTransferInValue

	self writeLine: 'Entrada por transferencia de ' OnAccountSummaryStreamWithValue: aTransferInValue asString.

! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:22:16'!
applyTransferOutOfValue: aTransferOutValue

	self writeLine: 'Salida por transferencia de ' OnAccountSummaryStreamWithValue: aTransferOutValue asString.
! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:22:29'!
applyWithdrawOfValue: aWithdrawValue

	self writeLine: 'Extracción por ' OnAccountSummaryStreamWithValue: aWithdrawValue asString.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 16:18:55'!
for: anAccount

	account := 	anAccount .! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:25:34'!
makeReport


	accountSummaryStream := String new writeStream.
	
	account affectAccountSummary: self.

	accountSummaryStream nextPutAll: 'Balance = ';
					      nextPutAll: account balance asString.
	
	^accountSummaryStream contents.
! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:18:00'!
writeLine: aString OnAccountSummaryStreamWithValue: aValue

	accountSummaryStream  nextPutAll: aString;
						nextPutAll: aValue asString;
						nextPut: $.;
						newLine.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio 2'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 16:18:05'!
for: anAnccount


	^self basicNew for: anAnccount .! !


!classDefinition: #AccountTransaction category: 'Portfolio 2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'AF 10/22/2021 16:52:03'!
affectAccountSummary: anAccountSummary

	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio 2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio 2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'AF 10/22/2021 17:09:04'!
value

	^ value copy! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 16:58:30'!
affectAccountSummary: anAccountSummary

	^anAccountSummary applyDepositOfValue: self value.! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:53:29'!
affectTransferNet: aTransferNet 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio 2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferIn category: 'Portfolio 2'!
AccountTransaction subclass: #TransferIn
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferIn methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 17:02:05'!
affectAccountSummary: anAccountSummary

	^anAccountSummary applyTransferInOfValue: self value.! !

!TransferIn methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 20:53:47'!
affectBalance: aBalance

	^aBalance + self value ! !

!TransferIn methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:51:46'!
affectTransferNet: aTransferNet 
	
	aTransferNet applyTransferInOfValue: self value.! !

!TransferIn methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 20:59:19'!
initializeFor: aTransfer  

	transfer := aTransfer ! !

!TransferIn methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 20:58:17'!
transfer

	^ transfer ! !

!TransferIn methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 20:58:23'!
value

	^ self transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferIn class' category: 'Portfolio 2'!
TransferIn class
	instanceVariableNames: ''!

!TransferIn class methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 21:07:47'!
for: aTransfer  

	^ self new initializeFor: aTransfer.! !

!TransferIn class methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 21:08:52'!
register: aTransfer on: account

	| transaction |
	
	transaction := self for: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferOut category: 'Portfolio 2'!
AccountTransaction subclass: #TransferOut
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferOut methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 17:04:05'!
affectAccountSummary: anAccountSummary

	^anAccountSummary applyTransferOutOfValue: self value.! !

!TransferOut methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 21:03:16'!
affectBalance: aBalance

	^aBalance - self value! !

!TransferOut methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:49:31'!
affectTransferNet: aTransferNet 
	
	aTransferNet applyTransferOutOfValue: self value.! !

!TransferOut methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 21:01:36'!
initializeFor: aTransfer  

	transfer := aTransfer ! !

!TransferOut methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 21:01:58'!
transfer

	^ transfer ! !

!TransferOut methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 21:01:48'!
value

	^ self transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferOut class' category: 'Portfolio 2'!
TransferOut class
	instanceVariableNames: ''!

!TransferOut class methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 21:07:36'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !

!TransferOut class methodsFor: 'as yet unclassified' stamp: 'AF 10/20/2021 21:09:01'!
register: aTransfer on: account

	| transaction |
	
	transaction := self for: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: 'Portfolio 2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Withdraw methodsFor: 'initialization' stamp: 'AF 10/22/2021 17:06:12'!
affectAccountSummary: anAccountSummary

	^anAccountSummary applyWithdrawOfValue: self value.! !

!Withdraw methodsFor: 'initialization' stamp: 'AF 10/22/2021 18:55:09'!
affectTransferNet: anAccountSummary

	! !

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'AF 10/22/2021 17:09:53'!
value

	^ value copy! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio 2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio 2'!
Object subclass: #Transfer
	instanceVariableNames: 'senderAccount receiverAccount originTransaction endTransaction value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Transfer methodsFor: 'initialization' stamp: 'AF 10/22/2021 18:31:22'!
from: aSender to: aReceiver amount: aValue 

	value := aValue.
	originTransaction := TransferOut register: self on: aSender.
	endTransaction := TransferIn register: self on: aReceiver. 
	
! !


!Transfer methodsFor: 'accessing' stamp: 'AF 10/22/2021 18:29:48'!
endTransaction
	
	^ endTransaction.! !

!Transfer methodsFor: 'accessing' stamp: 'AF 10/22/2021 18:30:05'!
originTransaction

	^ originTransaction.! !

!Transfer methodsFor: 'accessing' stamp: 'AF 10/22/2021 17:09:41'!
value

	^value copy
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio 2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialization' stamp: 'AF 10/18/2021 21:02:06'!
from: aSender to: aReceiver amount: aValue
	
	self assertAmountIsValid: aValue.
	self assertAccountsAreNotTheSameWithReciever: aSender andSender: aReceiver.
	
	^ self new from: aSender to: aReceiver amount: aValue.! !


!Transfer class methodsFor: 'error descriptions' stamp: 'AF 10/18/2021 21:20:40'!
amountCanNotBeLessOrEqualToZeroErrorDescription

	^ 'amount cannot less or equal to zero'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'AF 10/18/2021 20:48:33'!
senderCanNotBeReceiverErrorDescription
	^ 'The sender and the receiver cannot be the same'! !


!Transfer class methodsFor: 'assertions' stamp: 'AF 10/18/2021 21:02:06'!
assertAccountsAreNotTheSameWithReciever: aSender andSender: aReceiver

	^ aSender = aReceiver  ifTrue: [self senderCanNotBeRecieverError ]! !

!Transfer class methodsFor: 'assertions' stamp: 'AF 10/18/2021 21:21:25'!
assertAmountIsValid: aValue

	^ aValue <= 0 ifTrue: [self amountCanNotBeLessOrEqualToZeroError]! !


!Transfer class methodsFor: 'errors' stamp: 'AF 10/18/2021 21:21:25'!
amountCanNotBeLessOrEqualToZeroError

	^ self error: self amountCanNotBeLessOrEqualToZeroErrorDescription.! !

!Transfer class methodsFor: 'errors' stamp: 'AF 10/18/2021 20:55:14'!
senderCanNotBeRecieverError

	^ self error: self senderCanNotBeReceiverErrorDescription! !


!classDefinition: #TransferNet category: 'Portfolio 2'!
Object subclass: #TransferNet
	instanceVariableNames: 'account result'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:52:20'!
applyTransferInOfValue: aTransferInValue 
	
	result := result + aTransferInValue .! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:50:38'!
applyTransferOutOfValue: aTransferOutValue 
	
	result := result - aTransferOutValue .! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:36:03'!
for: anAccount

	account := anAccount.
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:57:25'!
makeReport

	result := 0.
	
	account affectTransferNet: self.
	
	^result.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio 2'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'AF 10/22/2021 18:35:25'!
for: anAccount

	^self basicNew for: anAccount.! !
