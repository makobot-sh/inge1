!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 18:24:08'!
addEntero: anAdderEntero
	^Entero with: value + anAdderEntero integerValue! !

!Entero methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/13/2021 22:15:33'!
addFraction: anAdderFraction
	^anAdderFraction addEntero: self! !

!Entero methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 13:48:19'!
divideEntero: aDivisor
	^Fraccion with: aDivisor over: self	! !

!Entero methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 15:37:12'!
divideFraction: aDivisor
	^aDivisor divideByEntero: self! !

!Entero methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 18:24:26'!
multiplyEntero: aMultiplier
	^Entero with: value * aMultiplier integerValue
! !

!Entero methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 13:37:10'!
multiplyFraction: aMultiplier
	^aMultiplier multiplyEntero: self! !

!Entero methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 18:24:32'!
subtractToEntero: aMiniuendEntero
	^Entero with: (aMiniuendEntero integerValue) - value.
	! !

!Entero methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 15:25:57'!
subtractToFraction: aSubstractedFraction
	^(aSubstractedFraction subtractEntero: self) ! !


!Entero methodsFor: 'arithmetic operations' stamp: 'Chiro 9/15/2021 12:23:02'!
* aMultiplier
	^aMultiplier multiplyEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Chiro 9/15/2021 12:23:07'!
+ anAdder 
	^anAdder addEntero: self
  ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Chiro 9/15/2021 12:23:11'!
- aSubtrahend 
	^aSubtrahend subtractToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Chiro 9/15/2021 12:23:16'!
/ aDivisor 
	^aDivisor divideEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Chiro 9/14/2021 18:43:27'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Chiro 9/15/2021 16:40:30'!
divideByGCDWith: aValue
	|greatestCommonDivisor |
	greatestCommonDivisor := self greatestCommonDivisorWith: aValue. 
	^self // greatestCommonDivisor.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Chiro 9/14/2021 17:13:36'!
fibonacci
	self subclassResponsibility 
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'Chiro 9/14/2021 18:44:58'!
negativeFibonacciErrorDescription
	^'Fibonacci no está definido aquí para Enteros Negativos!!!!!!'
! !

!Entero class methodsFor: 'instance creation' stamp: 'Chiro 9/15/2021 17:23:17'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].

	^(self subclasses detect:[:unEnteroClass | unEnteroClass isValidFor: aValue]) with: aValue.
	! !


!classDefinition: #EnteroCero category: 'Numero-Exercise'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'Chiro 9/14/2021 17:06:02'!
fibonacci
	^EnteroPositivo with: 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroCero class' category: 'Numero-Exercise'!
EnteroCero class
	instanceVariableNames: ''!

!EnteroCero class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:49:33'!
isValidFor: aValue
	^aValue = 0.! !

!EnteroCero class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:19:56'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initalizeWith: aValue! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'Chiro 9/14/2021 15:52:45'!
fibonacci
	self error: EnteroNegativo negativeFibonacciErrorDescription. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'errorsDescriptions' stamp: 'Chiro 9/14/2021 18:45:04'!
negativeFibonacciErrorDescription
	^ 'Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !


!EnteroNegativo class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:49:33'!
isValidFor: aValue
	^aValue < 0.! !

!EnteroNegativo class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:19:52'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initalizeWith: aValue! !


!classDefinition: #EnteroPositivo category: 'Numero-Exercise'!
Entero subclass: #EnteroPositivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivo methodsFor: 'arithmetic operations' stamp: 'Chiro 9/14/2021 18:26:15'!
fibonacci
	self subclassResponsibility 
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroPositivo class' category: 'Numero-Exercise'!
EnteroPositivo class
	instanceVariableNames: ''!

!EnteroPositivo class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:49:33'!
isValidFor: aValue
	^aValue > 0.! !

!EnteroPositivo class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:49:33'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].

	^(self subclasses detect:[:unEnteroPositivoClass | unEnteroPositivoClass isValidFor: aValue]) with: aValue.
	! !


!classDefinition: #EnteroMayorAUno category: 'Numero-Exercise'!
EnteroPositivo subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'Chiro 9/14/2021 18:25:41'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numero-Exercise'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:49:33'!
isValidFor: aValue
	^aValue > 1.! !

!EnteroMayorAUno class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:19:33'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initalizeWith: aValue! !


!classDefinition: #EnteroUno category: 'Numero-Exercise'!
EnteroPositivo subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'Chiro 9/14/2021 17:07:29'!
fibonacci
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroUno class' category: 'Numero-Exercise'!
EnteroUno class
	instanceVariableNames: ''!

!EnteroUno class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:49:33'!
isValidFor: aValue
	^aValue = 1.! !

!EnteroUno class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/14/2021 18:19:46'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initalizeWith: aValue! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/13/2021 22:03:13'!
addEntero: anAdderEntero
	|newNumerator newDenominator|
	
	newNumerator := (numerator * (Entero with: 1)) + (denominator * anAdderEntero).
	newDenominator := denominator.
	^newNumerator / newDenominator.

! !

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/13/2021 22:03:05'!
addFraction: anAdderFraction
	|newNumerator newDenominator|
	
	newNumerator := (numerator * anAdderFraction denominator) + (denominator * anAdderFraction numerator).
	newDenominator := denominator * anAdderFraction denominator.
	
	^newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 15:41:02'!
divideByEntero: anEntero 
	^self numerator / (self denominator * anEntero).! !

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/15/2021 12:18:14'!
divideEntero: aDivisor
	^(self denominator * aDivisor) / (self numerator)! !

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 13:49:42'!
divideFraction: aDivisor
	^ (denominator * aDivisor numerator)	 / (numerator * aDivisor denominator).
	! !

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 13:32:37'!
multiplyEntero: aMultiplier
	^(numerator * aMultiplier) / denominator ! !

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 13:29:25'!
multiplyFraction: aMultiplier

	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator).! !

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 15:21:09'!
subtractEntero: aMinuendFraction
	|newDenominator newNumerator|
	
	newNumerator := (numerator * (Entero with: 1)) - (denominator * aMinuendFraction).
	newDenominator := denominator.
	^newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 15:09:07'!
subtractToEntero: aMinuendFraction
	|newDenominator newNumerator|
	
	newNumerator := (denominator * aMinuendFraction) - (numerator * (Entero with: 1) ).
	newDenominator := denominator.
	^newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations XXXX' stamp: 'Chiro 9/14/2021 15:09:58'!
subtractToFraction: aSubtrahendFraction
	
	|newNumerator newDenominator|
	newNumerator :=  (denominator * aSubtrahendFraction numerator) - (numerator * aSubtrahendFraction denominator).
	newDenominator := denominator * aSubtrahendFraction denominator.
	
	^newNumerator / newDenominator ! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'Chiro 9/15/2021 12:15:43'!
* aMultiplier 
	^aMultiplier multiplyFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Chiro 9/15/2021 12:15:49'!
+ anAdder 
	^anAdder addFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Chiro 9/15/2021 12:15:53'!
- aSubtrahend 

	^aSubtrahend subtractToFraction: self

! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Chiro 9/15/2021 12:15:56'!
/ aDivisor 
	^aDivisor divideFraction: self.
! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'Chiro 9/15/2021 16:47:21'!
initializeWith: aNumerator over: aDenominator
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'Chiro 9/15/2021 16:46:43'!
with: aDividend over: aDivisor

	^(self subclasses detect:[:unaFraccionClass | unaFraccionClass isValidForNumerator: aDividend andDenominator: aDivisor]) with: aDividend over: aDivisor.	
! !


!classDefinition: #FraccionWithDenominator0 category: 'Numero-Exercise'!
Fraccion subclass: #FraccionWithDenominator0
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionWithDenominator0 class' category: 'Numero-Exercise'!
FraccionWithDenominator0 class
	instanceVariableNames: ''!

!FraccionWithDenominator0 class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:12:36'!
isValidForNumerator: aNumerator andDenominator: aDenominator 
	^aDenominator integerValue = 0.! !

!FraccionWithDenominator0 class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 15:35:17'!
with: aDividend over: aDivisor

	Fraccion error: Fraccion canNotDivideByZeroErrorDescription ! !


!classDefinition: #FraccionWithNegativeDenominator category: 'Numero-Exercise'!
Fraccion subclass: #FraccionWithNegativeDenominator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionWithNegativeDenominator class' category: 'Numero-Exercise'!
FraccionWithNegativeDenominator class
	instanceVariableNames: ''!

!FraccionWithNegativeDenominator class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:12:46'!
isValidForNumerator: aNumerator andDenominator: aDenominator 
	^(aDenominator integerValue < 0) & (aNumerator integerValue ~= 0).! !

!FraccionWithNegativeDenominator class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 15:36:53'!
with: aDividend over: aDivisor
	
	 ^aDividend negated / aDivisor negated! !


!classDefinition: #FraccionWithNumerator0 category: 'Numero-Exercise'!
Fraccion subclass: #FraccionWithNumerator0
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionWithNumerator0 class' category: 'Numero-Exercise'!
FraccionWithNumerator0 class
	instanceVariableNames: ''!

!FraccionWithNumerator0 class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:12:55'!
isValidForNumerator: aNumerator andDenominator: aDenominator 
	^(aNumerator integerValue = 0) & (aDenominator integerValue ~= 0).! !

!FraccionWithNumerator0 class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:22:44'!
with: aDividend over: aDivisor
	 ^aDividend.! !


!classDefinition: #FraccionWithPositiveDenominator category: 'Numero-Exercise'!
Fraccion subclass: #FraccionWithPositiveDenominator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionWithPositiveDenominator class' category: 'Numero-Exercise'!
FraccionWithPositiveDenominator class
	instanceVariableNames: ''!

!FraccionWithPositiveDenominator class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:36:04'!
divide: aValue byGCDWith: aValue2
	|greatestCommonDivisor |
	greatestCommonDivisor := aValue greatestCommonDivisorWith: aValue2. 
	^aValue // greatestCommonDivisor.! !

!FraccionWithPositiveDenominator class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:13:01'!
isValidForNumerator: aNumerator andDenominator: aDenominator 
	^(aDenominator integerValue > 0) & (aNumerator integerValue ~= 0) ! !

!FraccionWithPositiveDenominator class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 15:46:16'!
with: aDividend over: aDivisor

	^(self subclasses detect:[:unaFraccionClass | unaFraccionClass isValidForNumerator: aDividend andDenominator: aDivisor]) with: aDividend over: aDivisor.	! !


!classDefinition: #FraccionWithDenominator1 category: 'Numero-Exercise'!
FraccionWithPositiveDenominator subclass: #FraccionWithDenominator1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionWithDenominator1 class' category: 'Numero-Exercise'!
FraccionWithDenominator1 class
	instanceVariableNames: ''!

!FraccionWithDenominator1 class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:40:30'!
isValidForNumerator: aNumerator andDenominator: aDenominator 
	^(aDenominator divideByGCDWith: aNumerator) integerValue = 1.! !

!FraccionWithDenominator1 class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:40:30'!
with: aDividend over: aDivisor
	^aDividend divideByGCDWith: aDivisor.
! !


!classDefinition: #FraccionWithDenominatorGreaterThan1 category: 'Numero-Exercise'!
FraccionWithPositiveDenominator subclass: #FraccionWithDenominatorGreaterThan1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionWithDenominatorGreaterThan1 class' category: 'Numero-Exercise'!
FraccionWithDenominatorGreaterThan1 class
	instanceVariableNames: ''!

!FraccionWithDenominatorGreaterThan1 class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:40:51'!
isValidForNumerator: aNumerator andDenominator: aDenominator 
	
	^(aDenominator divideByGCDWith: aNumerator) integerValue ~= 1.! !

!FraccionWithDenominatorGreaterThan1 class methodsFor: 'as yet unclassified' stamp: 'Chiro 9/15/2021 16:41:14'!
with: aDividend over: aDivisor
	|denominator numerator|
	numerator    := aDividend divideByGCDWith: aDivisor.
	denominator :=  aDivisor divideByGCDWith: aDividend.
	^self new initializeWith: numerator over: denominator
! !
