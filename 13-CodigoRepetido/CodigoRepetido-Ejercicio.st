!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'Chiro 9/9/2021 15:46:39'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertExecutionTimeOf: [customerBook addCustomerNamed: 'John Lennon'] WithinMiliseconds: 50.


! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Chiro 9/9/2021 15:47:12'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	
	self assertExecutionTimeOf: [customerBook removeCustomerNamed: paulMcCartney.] WithinMiliseconds: 100.
	

	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Chiro 9/9/2021 15:15:01'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook checkCustomerCanNotBeEmpty |
			
	customerBook := CustomerBook new.
	
	checkCustomerCanNotBeEmpty := [:anError | 
								self assert: anError messageText = CustomerBook 
								customerCanNotBeEmptyErrorMessage.
								self assert: customerBook isEmpty].
						
	self attempt: [ customerBook addCustomerNamed: ''.self fail ]  ifFailsWith: Error do: checkCustomerCanNotBeEmpty.		! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MK 9/9/2021 16:48:27'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon 	checkAddCustomerBehaviour |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	checkAddCustomerBehaviour := [ :anError | self assertNoChangesWereMadeIn: customerBook thatOriginallyHadCustomer: johnLennon].
	
	self attempt: 	[ customerBook removeCustomerNamed: 'Paul McCartney'. self fail ]  ifFailsWith: NotFound do: checkAddCustomerBehaviour.		
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AF 9/9/2021 16:28:38'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self checkIfNumberOfCustomersIn: customerBook Is: 1 WithActive: 0 WithSuspended: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Chiro 9/9/2021 01:53:46'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkIfNumberOfCustomersIn: customerBook Is: 0 WithActive: 0 WithSuspended: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MK 9/9/2021 16:48:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon checkAddCustomerBehaviour |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	checkAddCustomerBehaviour :=  [ :anError | self assertNoChangesWereMadeIn: customerBook thatOriginallyHadCustomer: johnLennon].
	
	self attempt: [ customerBook suspendCustomerNamed: 'George Harrison'. self fail ]  ifFailsWith: CantSuspend do: checkAddCustomerBehaviour.		
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MK 9/9/2021 16:48:27'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon checkAddCustomerBehaviour |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	checkAddCustomerBehaviour :=  [ :anError | self assertNoChangesWereMadeIn: customerBook thatOriginallyHadCustomer: johnLennon].
	
	self attempt: [ customerBook suspendCustomerNamed: johnLennon. self fail ]  ifFailsWith: CantSuspend do: checkAddCustomerBehaviour.		
! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'Chiro 9/9/2021 15:44:41'!
assertExecutionTimeOf: aClosure WithinMiliseconds: timeBound

	|millisecondsBeforeRunning millisecondsAfterRunning totalRunningTime |
 
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
 
	totalRunningTime := millisecondsAfterRunning-millisecondsBeforeRunning.
 
	^self assert: totalRunningTime < (timeBound * millisecond)
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'MK 9/9/2021 16:48:59'!
assertNoChangesWereMadeIn: aCustomerBook thatOriginallyHadCustomer: aCustomerName
	^self assert: (aCustomerBook numberOfCustomers = 1) & (aCustomerBook includesCustomerNamed: aCustomerName)
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'MK 9/7/2021 17:28:04'!
attempt: aClosure ifFailsWith: anErrorClass do: aPostErrorVerificationClosure
	
	aClosure
		on: anErrorClass
		do: [ :anError | aPostErrorVerificationClosure value: anError].! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'AF 9/9/2021 16:27:17'!
checkIfNumberOfCustomersIn: CustomerBook Is: aNumberOfCustomers WithActive: aNumberOfActiveCustomers WithSuspended: aNumberOfSuspendedCustomers
	
	self assert: (aNumberOfCustomers = CustomerBook numberOfCustomers) &
		(aNumberOfActiveCustomers = CustomerBook numberOfActiveCustomers) & 
		(aNumberOfSuspendedCustomers = CustomerBook numberOfSuspendedCustomers).
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MK 9/7/2021 18:22:34'!
numberOfCustomers
	
	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MK 9/7/2021 18:24:33'!
removeCustomerNamed: aName 

	^ active remove: aName ifAbsent: [
		^ suspended remove: aName ifAbsent: 
			[^ NotFound signal].	
	].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'MK 9/7/2021 18:24:12'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^ CantSuspend signal].
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
