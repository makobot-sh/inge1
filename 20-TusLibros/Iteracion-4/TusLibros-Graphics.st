!classDefinition: #CatalogWindow category: 'TusLibros-Graphics'!
Panel subclass: #CatalogWindow
	instanceVariableNames: 'username password counters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 11:45:39'!
buildCatalogItemRowWithName: aBookName withISBN: anISBN withExtent: anExtent 

	| itemMorph |
	itemMorph := LayoutMorph newRow.
	itemMorph separation: 1; 
	morphWidth: anExtent x; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: aBookName ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCatalogTableItem: anISBN ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCounterMorph).

	"TO DO: falta agregar boton para agregar al carrito"

	^ itemMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 11:35:52'!
buildCatalogListHeaderWithExtent: anExtent
	
	| catalogMorph |
	
	catalogMorph := LayoutMorph newRow.
	catalogMorph separation: 1; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: 'Book name' ownerExtent: anExtent);
	addMorph: (self buildCatalogTableItem: 'ISBN' ownerExtent: anExtent).
	^ catalogMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 11:45:03'!
buildCatalogMorph
	
	| catalogMorph scrollMorph |
	
	catalogMorph := LayoutMorph newColumn.
	scrollMorph := PluggableScrollPane new.
	scrollMorph morphExtent: (self defaultExtent x*0.6)@(self defaultExtent y * 0.60);
	scroller: catalogMorph.
	
	catalogMorph separation: 1; 
	morphExtent: catalogMorph morphExtent;
	axisEdgeWeight: 0.0.
	catalogMorph addMorph: (self buildCatalogListHeaderWithExtent: scrollMorph morphExtent).
	20 timesRepeat: [catalogMorph addMorph: (self buildCatalogItemRowWithName: 'test' withISBN: 'ISBN' withExtent: scrollMorph morphExtent).].
	
	^ scrollMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 11:38:07'!
buildCatalogTableItem: aName ownerExtent: anExtent 
	
	| itemMorph |
	
	itemMorph := LabelMorph contents: aName font: FontFamily defaultFamilyAndPointSize.
	itemMorph morphWidth: (anExtent x *0.25).
	^ itemMorph! !


!CatalogWindow methodsFor: 'auxiliary' stamp: 'AF 11/27/2021 12:02:11'!
buildCounterMorph
	| numberInputMorph counterMorph arrowDown arrowUp counter arrowsMorph counterId |
	
	counterId _ counters size +1. 
	counter _ ItemCounterModel newWith: counterId.
	numberInputMorph := TextModelMorph textProvider: counter textGetter: #value textSetter: #value:.
	numberInputMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | numberInputMorph innerTextMorph acceptContents ] .
	numberInputMorph morphExtent: 50@20.
	counters add: numberInputMorph. 
	
	arrowUp := PluggableButtonMorph model: counter stateGetter: nil action: #valueUp  label: (Character arrowUp asString).
	arrowUp morphExtent: 25@10. 
	
	arrowDown := PluggableButtonMorph model: counter stateGetter: nil action: #valueDown  label: (Character arrowDown asString) .
	arrowDown morphExtent: 25@10.
	
	counter when: #updateCounter send: #updateCounter: to: self with: counter.
	
	arrowsMorph := LayoutMorph newColumn.
	arrowsMorph separation: 0.001;
	morphExtent: 25@20;
	addMorph: arrowUp;
	addMorph: arrowDown.
		
	counterMorph := LayoutMorph newRow. 
	counterMorph separation: 0.1;
	morphExtent: 100@50;
	addMorph: numberInputMorph;
	addMorph: arrowsMorph.
	
	^ counterMorph.! !

!CatalogWindow methodsFor: 'auxiliary' stamp: 'AF 11/27/2021 12:35:52'!
updateCounter: aCounter
	
	| textMorph |
	textMorph _ (counters at: aCounter id) innerTextMorph.
	textMorph contents: aCounter value.
	textMorph hasUnacceptedEdits: true.
	textMorph acceptContents.
	textMorph resetTextComposition; updateFromTextComposition.
! !


!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:43:54'!
buildCartListMorph

	^ self shouldBeImplemented.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:43:49'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 25;
	axisEdgeWeight: 0.0;
	morphExtent: self defaultExtent;
	addMorph: self buildShopHeader;
	addMorph: self buildShopBody.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:43:31'!
buildShopBody

	| bodyLayoutMorph catalogMorph cartListMorph |
		
	catalogMorph := self buildCatalogMorph.
	"cartListMorph := self buildCartListMorph."
		
	bodyLayoutMorph := LayoutMorph newRow.
	bodyLayoutMorph separation: 1;
	axisEdgeWeight: 0.0;
	morphExtent: (self defaultExtent x)@(self defaultExtent y * 0.70) ;
	addMorph: catalogMorph.
	"addMorph: cartListMorph."
	
	^bodyLayoutMorph.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:43:19'!
buildShopHeader

	| firstRowLayoutMorph headerButtonsMorph |
		
	headerButtonsMorph := LayoutMorph newRow.
	headerButtonsMorph separation: 25;
	axisEdgeWeight: 1.0;
	morphExtent: (self defaultExtent x*0.6)@(self defaultExtent y * 0.1) ;
	addMorph: (LabelMorph contents: 'Purchase history');
	addMorph: (LabelMorph contents: 'Checkout').
		
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 1;
	axisEdgeWeight: 0.0;
	morphExtent: (self defaultExtent x)@(self defaultExtent y * 0.1) ;
	addMorph: (LabelMorph contents:'Welcome, ',username,'!!');
	addMorph: headerButtonsMorph.
	
	^firstRowLayoutMorph.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:43:11'!
defaultExtent

	^ 1035@485
	! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:43:03'!
initializeWith: aTitle and: aUsername and: aPassword and: aCartID 
	
	username _ aUsername.
	password _ aPassword.
	counters _ OrderedCollection new.
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (CatalogWindowModel new).
	self morphExtent: self defaultExtent.
	self buildMorphicWindow.
	self openInWorld.
			
	"self model when: #authenticationResponse send: #login to: self."
	
	"Investigar:
	self model when: #newWordsArrived send: #refreshListOfWords:and: to: self."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogWindow class' category: 'TusLibros-Graphics'!
CatalogWindow class
	instanceVariableNames: ''!

!CatalogWindow class methodsFor: 'instance creation' stamp: 'MP 11/20/2021 19:57:41'!
openWithUser: aUsername andPass: aPassword andCart: aCartID 
	
	^self new initializeWith: 'TusLibros - shop' and: aUsername and: aPassword and: aCartID.! !


!classDefinition: #LoginWindow category: 'TusLibros-Graphics'!
Panel subclass: #LoginWindow
	instanceVariableNames: 'userTextBoxMorph passwordTextBoxMorph errorMessageMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 13:25:14'!
build1stRow
	| firstRowLayoutMorph |
	
	userTextBoxMorph := TextModelMorph textProvider: self model textGetter: #username textSetter: #username:. 
	userTextBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | userTextBoxMorph innerTextMorph acceptContents ] .
	userTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 200 ; morphHeight: 20. 
		
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	morphExtent: 475@1;
	addMorph: (LabelMorph contents:'Username:');
	addMorph: userTextBoxMorph.
	
	^firstRowLayoutMorph.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 13:25:45'!
build1stRow1rstColumn
	| firstRowsFirstColumn |
		
	firstRowsFirstColumn := LayoutMorph newColumn .
	firstRowsFirstColumn separation: 1;
	axisEdgeWeight: 0;
	morphExtent: self minimumExtent;
	addMorph: self build1stRow ;
	addMorph: self build2ndRow .
	
	^firstRowsFirstColumn.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 13:25:07'!
build2ndRow
	| secondRowLayoutMorph |
	
	passwordTextBoxMorph := TextModelMorph textProvider: self model textGetter: #password textSetter: #password:. 
	passwordTextBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | passwordTextBoxMorph innerTextMorph acceptContents ] .
	passwordTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 200 ; morphHeight: 20. 
		
	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	morphExtent: 475@1;
	addMorph: (LabelMorph contents:'Password: ');
	addMorph: passwordTextBoxMorph.
	
	^secondRowLayoutMorph.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 11:34:35'!
build3rdRow
	| loginButtonMorph thirdRowLayoutMorph |
	
	loginButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #authenticate  label: 'Create Cart'.
	
	thirdRowLayoutMorph := LayoutMorph newRow.
	thirdRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	morphExtent: self minimumExtent;
 	addMorph: loginButtonMorph.
	
	^thirdRowLayoutMorph.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 11:34:40'!
build4rdRow
	| thirdRowLayoutMorph |
	
	errorMessageMorph := LabelMorph contents: '' font: FontFamily defaultFamilyAndPointSize emphasis: AbstractFont boldCode.
	errorMessageMorph color: Color red.
	
	thirdRowLayoutMorph := LayoutMorph newRow.
	thirdRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	morphExtent: self minimumExtent;
 	addMorph: errorMessageMorph.
	
	^thirdRowLayoutMorph.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 13:26:42'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 1;
	axisEdgeWeight: 0;
	morphExtent: self defaultExtent ;
	addMorph: self build1stRow1rstColumn ;
	"addMorph: self build1stRow;
	addMorph: self build2ndRow;"
	addMorph: self build3rdRow;
	addMorph: self build4rdRow.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 13:22:41'!
defaultExtent

	^ 475@485
	! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 11:34:52'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (LoginWindowModel new).
	self morphExtent: self defaultExtent.
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #authenticationResponse send: #login to: self.
	
	"Investigar:
	self model when: #newWordsArrived send: #refreshListOfWords:and: to: self."! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 11:34:56'!
login
	errorMessageMorph contents: self model response.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoginWindow class' category: 'TusLibros-Graphics'!
LoginWindow class
	instanceVariableNames: ''!

!LoginWindow class methodsFor: 'instance creation' stamp: 'AF 11/27/2021 13:05:38'!
open
	
	^self new initializeWith: 'TusLibros - login'.! !


!classDefinition: #CatalogWindowModel category: 'TusLibros-Graphics'!
Object subclass: #CatalogWindowModel
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!


!classDefinition: #ItemCounterModel category: 'TusLibros-Graphics'!
Object subclass: #ItemCounterModel
	instanceVariableNames: 'value id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:41:42'!
id

	^ id! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:41:35'!
initializeWith: counterId

	value _ '0'.
	id _ counterId.! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:41:50'!
value

	^ value.! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 12:24:09'!
value: aValue
	[
		|num|
		num _ aValue asNumber asInteger.
		value _ num asString. 
	] on: Error do: [].! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 12:23:31'!
valueDown

	|newValue|

	newValue _ self value asNumber asInteger -1.
	newValue >= 0 ifTrue: [self value: newValue asString.
					    self triggerEvent: #updateCounter with: self].
	
! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 12:23:38'!
valueUp

	self value: (self value asNumber asInteger +1) asString.
	self triggerEvent: #updateCounter with: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemCounterModel class' category: 'TusLibros-Graphics'!
ItemCounterModel class
	instanceVariableNames: ''!

!ItemCounterModel class methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 23:12:48'!
newWith: counterId
	^ self new initializeWith: counterId.! !


!classDefinition: #LoginWindowModel category: 'TusLibros-Graphics'!
Object subclass: #LoginWindowModel
	instanceVariableNames: 'username password response'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 11:34:06'!
authenticate

	|client notDecodedResponse respDict |
	client _ WebClient new.
	notDecodedResponse _ (client httpGet: 'http://localhost:8080/createCart?clientId=',self username,'&password=',self password ).
	respDict _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
	(respDict at: 'status') = 0
		ifTrue: [
			|cartId|
			cartId _ respDict at: 'cartId'.
			CatalogWindow openWithUser: username andPass: password andCart: cartId.
		] 
		ifFalse: [
			response _ respDict at: 'errorDescription'.
		].
	
	
	client close.
	
	self triggerEvent: #authenticationResponse! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:59:51'!
initialize

	username := ''.
	password := '' "Dont do this at home kids".! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 17:56:49'!
password
	^ password.
	! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:29:31'!
password: aPassword
	password _ aPassword asString.
	^ true.
	! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:02:58'!
response
	^ response.
	! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 17:51:54'!
username
	^ username.
	! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:29:38'!
username: aUsername
	username _ aUsername asString.
	^ true.
	! !
