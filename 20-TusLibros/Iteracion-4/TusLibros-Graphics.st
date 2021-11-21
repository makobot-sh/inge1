!classDefinition: #CatalogWindow category: 'TusLibros-Graphics'!
Panel subclass: #CatalogWindow
	instanceVariableNames: 'username password counters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CatalogWindow methodsFor: 'catalog' stamp: 'MP 11/20/2021 22:39:13'!
buildCatalogItemMorphWithName: aBookName withISBN: anISBN withExtent: anExtent 

	| itemMorph |
	itemMorph := LayoutMorph newRow.
	itemMorph separation: 1; 
	morphWidth: anExtent x; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: aBookName ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCatalogTableItem: anISBN ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCounterMorph).

	^ itemMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'MP 11/20/2021 21:35:36'!
buildCatalogListHeaderWithExtent: anExtent
	
	| catalogMorph |
	
	catalogMorph := LayoutMorph newRow.
	catalogMorph separation: 1; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: 'Book name' ownerExtent: anExtent);
	addMorph: (self buildCatalogTableItem: 'ISBN' ownerExtent: anExtent).
	^ catalogMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'MP 11/20/2021 21:35:55'!
buildCatalogMorph
	
	| catalogMorph p |
	
	catalogMorph := LayoutMorph newColumn.
	p := PluggableScrollPane new.
	p morphExtent: (self defaultExtent x*0.6)@(self defaultExtent y * 0.60);
	scroller: catalogMorph.
	
	catalogMorph separation: 1; 
	morphExtent: catalogMorph morphExtent;
	axisEdgeWeight: 0.0.
	catalogMorph addMorph: (self buildCatalogListHeaderWithExtent: p morphExtent).
	20 timesRepeat: [catalogMorph addMorph: (self buildCatalogItemMorphWithName: 'test' withISBN: 'ISBN' withExtent: p morphExtent).].
	
	^ p.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'MP 11/20/2021 21:31:06'!
buildCatalogTableItem: aName ownerExtent: anExtent 
	
	| itemMorph |
	
	itemMorph := LabelMorph contents: aName font: FontFamily defaultFamilyAndPointSize.
	itemMorph morphWidth: (anExtent x *0.25).
	^ itemMorph! !


!CatalogWindow methodsFor: 'auxiliary' stamp: 'MP 11/20/2021 23:32:17'!
buildCounterMorph
	| numberInputMorph counterMorph arrowDown arrowUp counter arrowsMorph counterId |
	
	counterId _ counters size +1. 
	counter _ ItemCounterModel newWith: counterId.
	numberInputMorph := TextModelMorph textProvider: counter textGetter: #value textSetter: #value:.
	numberInputMorph morphExtent: 50@20.
	counters add: numberInputMorph. 
	
	arrowUp := PluggableButtonMorph model: counter stateGetter: nil action: #valueUp  label: '^'.
	arrowUp morphExtent: 25@10. 
	
	arrowDown := PluggableButtonMorph model: counter stateGetter: nil action: #valueDown  label: 'v'.
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

!CatalogWindow methodsFor: 'auxiliary' stamp: 'MP 11/20/2021 23:41:29'!
updateCounter: aCounter

	(counters at: aCounter id) innerTextMorph contents: aCounter value.
	^ (counters at: aCounter id) innerTextMorph resetTextComposition; updateFromTextComposition .
	! !


!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 20:04:14'!
buildCartListMorph
	^ self shouldBeImplemented.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 20:57:14'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 25;
	axisEdgeWeight: 0.0;
	morphExtent: self defaultExtent;
	addMorph: self buildShopHeader;
	addMorph: self buildShopBody.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 20:59:00'!
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

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 21:00:17'!
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

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 19:58:33'!
defaultExtent

	^ 1035@485
	! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 23:14:22'!
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

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:13:55'!
build1stRow
	| firstRowLayoutMorph |
	
	userTextBoxMorph := TextModelMorph textProvider: self model textGetter: #username textSetter: #username:. 
	userTextBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | userTextBoxMorph innerTextMorph acceptContents ] .
	userTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 200 ; morphHeight: 20. 
		
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	morphExtent: self minimumExtent;
	addMorph: (LabelMorph contents:'Username:');
	addMorph: userTextBoxMorph.
	
	^firstRowLayoutMorph.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:14:06'!
build2ndRow
	| secondRowLayoutMorph |
	
	passwordTextBoxMorph := TextModelMorph textProvider: self model textGetter: #password textSetter: #password:. 
	passwordTextBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | passwordTextBoxMorph innerTextMorph acceptContents ] .
	passwordTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 200 ; morphHeight: 20. 
		
	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	morphExtent: self minimumExtent;
	addMorph: (LabelMorph contents:'Password:');
	addMorph: passwordTextBoxMorph.
	
	^secondRowLayoutMorph.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 19:17:15'!
build3rdRow
	| loginButtonMorph thirdRowLayoutMorph |
	
	loginButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #authenticate  label: 'Create Cart'.
	
	thirdRowLayoutMorph := LayoutMorph newRow.
	thirdRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	morphExtent: self minimumExtent;
 	addMorph: loginButtonMorph.
	
	^thirdRowLayoutMorph.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 21:23:14'!
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

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:26:27'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 1;
	axisEdgeWeight: 0;
	morphExtent: self minimumExtent;
	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow;
	addMorph: self build4rdRow.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 17:39:07'!
defaultExtent

	^ 1035@485
	! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:15:38'!
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

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:22:37'!
login
	errorMessageMorph contents: self model response.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoginWindow class' category: 'TusLibros-Graphics'!
LoginWindow class
	instanceVariableNames: ''!

!LoginWindow class methodsFor: 'instance creation' stamp: 'MP 11/20/2021 19:10:19'!
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

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 23:15:50'!
id
	^ id! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 22:47:15'!
initialize
	value _ '0'! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 23:13:03'!
initializeWith: counterId
	value _ '0'.
	id _ counterId.! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 22:26:15'!
value
	^ value.! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 22:56:25'!
value: aValue
	[
		|num|
		num _ aValue asNumber asInteger.
		value _ num asString. 
		self triggerEvent: #updateCounter with: self.
	] on: Error do: [].
	^ value.! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 22:56:48'!
valueDown
	value _ (value asNumber asInteger -1) asString.
	self triggerEvent: #updateCounter with: self.
	^ value.! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 23:17:28'!
valueUp
	value _ (value asNumber asInteger +1) asString.
	self triggerEvent: #updateCounter with: self.
	^ value.! !

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

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 19:56:08'!
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
