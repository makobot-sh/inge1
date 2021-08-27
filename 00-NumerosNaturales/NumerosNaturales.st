!classDefinition: #I category: 'NúmerosNaturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NúmerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NúmerosNaturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 17:17:01'!
* aNaturalNumber
	^ aNaturalNumber.! !

!I class methodsFor: 'as yet unclassified' stamp: 'maca 8/26/2021 21:16:18'!
+ aNaturalNumber
	^ aNaturalNumber next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 17:44:50'!
- aNaturalNumber
	^ self error: 'Números negativos no soportados'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:40:01'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^I].
	^ self error: 'No se puede dividir por un número mayor.'.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:39:48'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^ false]. 
	^ true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:11:38'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor.'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 17:45:01'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Números negativos no soportados'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'maca 8/26/2021 20:46:27'!
next
	^ II! !

!I class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 16:59:15'!
substractTo: aNaturalNumber
	^ aNaturalNumber previous.! !


!classDefinition: #II category: 'NúmerosNaturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NúmerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NúmerosNaturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 17:20:38'!
* aNaturalNumber
	^ self previous * aNaturalNumber + aNaturalNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/26/2021 21:19:39'!
+ aNaturalNumber
	
	^ self previous + aNaturalNumber next. "Llevamos uno de los números hasta I, hasta que lleguemos a la operación sucesor (suma con I ya está bien definida como aNaturalNumber next."! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 17:14:49'!
- aNaturalNumber
	^ aNaturalNumber substractTo: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:40:44'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I]. 
	(self < aNaturalNumber) ifTrue: [^ self error: 'No se puede dividir por un número mayor.'].
	^ self - aNaturalNumber / aNaturalNumber + I.  "equivalent to ((self - aNaturalNumber)/aNaturalNumber) + 1"! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:37:43'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^ false].
	^ self previous < aNaturalNumber previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:11:23'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor.'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:47:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/26/2021 21:25:42'!
next

	next ifNotNil:[^next]. "Si está inicializada la devuelvo, si no la inicializo."
	next _ II createChildNamed: self name, 'I'. "Cuando guardamos nos pregunta quién es next, le decimos que es un collaborator."
	next previous: self. "Le mando a un mensaje a III indicandole que soy su previo. Tengo que crear este mensaje previous:"
	^next. "Si devolvía anObsoleteIII, hay que ir con el inspector a II y reemplazar next (que dira anObsoleteIII) por nil."
	         "lo que pasó es que quedo apuntando a un puntero viejo."! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/26/2021 21:21:47'!
previous
	^ previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/26/2021 21:29:36'!
previous: aNaturalNumber

	previous _ aNaturalNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 17:01:33'!
substractTo: aNaturalNumber
	^ previous substractTo: aNaturalNumber previous.! !


!classDefinition: #III category: 'NúmerosNaturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NúmerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NúmerosNaturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:47:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'NúmerosNaturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NúmerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'NúmerosNaturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:47:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'NúmerosNaturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NúmerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'NúmerosNaturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:47:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'NúmerosNaturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NúmerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'NúmerosNaturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'maca 8/27/2021 18:47:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!