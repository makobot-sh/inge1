!classDefinition: #CatalogWindow category: 'TusLibros-Graphics'!
Panel subclass: #CatalogWindow
	instanceVariableNames: 'counterTextMorphs cartListMorph counterModels'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 19:54:52'!
buildAddToCartRowWith: anExtent

    | checkoutButton checkoutRow |
    
        checkoutButton := PluggableButtonMorph model: self model stateGetter: nil action: #addToCart label: 'Add to cart'.

        checkoutRow := LayoutMorph newRow.
        checkoutRow separation: 25@0;
        axisEdgeWeight: 1.0;
        morphExtent: (anExtent x) @ (anExtent y * 0.2);
        addMorph: checkoutButton.

        ^checkoutRow.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 17:45:16'!
buildCatalogColumn

  	| bodyLayoutMorph |

 	bodyLayoutMorph := LayoutMorph newColumn.
  	bodyLayoutMorph separation: 1@1;
  	axisEdgeWeight: 0.0;
  	morphExtent: (self defaultExtent x * 0.5)@(self defaultExtent y * 0.70) ;
	addMorph: (self buildCatalogMorphWith: bodyLayoutMorph morphExtent);
	addMorph: (self buildAddToCartRowWith: bodyLayoutMorph morphExtent).

    
    	^bodyLayoutMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 18:54:59'!
buildCatalogItemRowWithName: aBookName withISBN: anISBN withExtent: anExtent 

	| itemMorph |
	itemMorph := LayoutMorph newRow.
	itemMorph separation: 1@1; 
	morphWidth: anExtent x; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: aBookName ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCatalogTableItem: anISBN ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCounterMorph: anISBN).

	"TO DO: falta agregar boton para agregar al carrito"

	^ itemMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 16:15:09'!
buildCatalogListHeaderWithExtent: anExtent
	
	| catalogMorph |
	
	catalogMorph := LayoutMorph newRow.
	catalogMorph separation: 1@1; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: 'Book name' ownerExtent: anExtent);
	addMorph: (self buildCatalogTableItem: 'ISBN' ownerExtent: anExtent).
	^ catalogMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 18:47:50'!
buildCatalogMorphWith: anExtent
	
	| catalogMorph scrollMorph catalog |
	
	catalogMorph := LayoutMorph newColumn.
	scrollMorph := PluggableScrollPane new.
	scrollMorph morphExtent: anExtent;
	scroller: catalogMorph.
	
	catalogMorph separation: 1@1; 
	axisEdgeWeight: 0.0.
	catalogMorph addMorph: (self buildCatalogListHeaderWithExtent: scrollMorph morphExtent).
	
	catalog _ self model catalog.
	catalog keys do: [: anISBN | catalogMorph addMorph: (self buildCatalogItemRowWithName: (catalog at: anISBN) withISBN: anISBN withExtent: scrollMorph morphExtent).].
	
	^ scrollMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 17:51:38'!
buildCatalogTableItem: aName ownerExtent: anExtent 
	
	| itemMorph |
	
	itemMorph := LabelMorph contents: aName font: FontFamily defaultFamilyAndPointSize.
	itemMorph morphWidth: (anExtent x *0.3).
	^ itemMorph! !


!CatalogWindow methodsFor: 'auxiliary' stamp: 'AF 11/27/2021 22:20:44'!
buildCounterMorph: anId
	| numberInputMorph counterMorph arrowDown arrowUp counter arrowsMorph counterId |
	
	counterId _ anId. 
	counter _ ItemCounterModel newWith: counterId.
	numberInputMorph := TextModelMorph textProvider: counter textGetter: #value textSetter: #value:.
	numberInputMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | numberInputMorph innerTextMorph acceptContents.
															self model updateLocalCartAt: counterId with: counter value asNumber.] .
	numberInputMorph morphExtent: 50@20.
	counterModels add: counterId -> counter.
	counterTextMorphs add: counterId -> numberInputMorph. 
	
	arrowUp := PluggableButtonMorph model: counter stateGetter: nil action: #valueUp  label: (Character arrowUp asString).
	arrowUp morphExtent: 25@10. 
	
	arrowDown := PluggableButtonMorph model: counter stateGetter: nil action: #valueDown  label: (Character arrowDown asString) .
	arrowDown morphExtent: 25@10.
	
	counter when: #updateCounter send: #updateCounterTextMorphBasedOn: to: self with: counter.
	
	arrowsMorph := LayoutMorph newColumn.
	arrowsMorph separation: 0.001;
	morphExtent: 25@20;
	addMorph: arrowUp;
	addMorph: arrowDown.
		
	counterMorph := LayoutMorph newRow. 
	counterMorph separation: 0.001;
	morphExtent: 100@50;
	addMorph: numberInputMorph;
	addMorph: arrowsMorph.
	
	^ counterMorph.! !

!CatalogWindow methodsFor: 'auxiliary' stamp: 'AF 11/27/2021 22:12:27'!
updateCounterTextMorphBasedOn: aCounterModel  
	
	| textMorph counterId counterValue |
	
	counterId _ aCounterModel id.
	counterValue _ aCounterModel value.
	
	textMorph _ (counterTextMorphs at: counterId) innerTextMorph.
	textMorph contents: counterValue.
	textMorph hasUnacceptedEdits: true.
	textMorph acceptContents.
	textMorph resetTextComposition; updateFromTextComposition.
	self model updateLocalCartAt: counterId with: counterValue asNumber.
! !


!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/27/2021 21:17:34'!
buildCartItemRowWith: aQuantity of: anISBN withExtent: anExtent

	| itemMorph |
	itemMorph := LayoutMorph newRow.
	itemMorph separation: 1@1; 
	morphWidth: anExtent x; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: '           ' ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCatalogTableItem: anISBN ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCatalogTableItem: aQuantity asString ownerExtent: itemMorph morphExtent).
	
	"TO DO: falta agregar boton para agregar al carrito"

	^ itemMorph.! !

!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/27/2021 20:23:39'!
buildCartListColumn

	| cartListColumnMorph |
		
	cartListColumnMorph := LayoutMorph newColumn.
	cartListColumnMorph separation: 1@1;
	axisEdgeWeight: 0.0;
	morphExtent: (self defaultExtent x * 0.4)@(self defaultExtent y * 0.70).
	
	cartListMorph := (self buildCartListMorphWith: cartListColumnMorph morphExtent).
	
	cartListColumnMorph addMorph: cartListMorph;
	addMorph: (self buildCheckoutRowWith: cartListColumnMorph morphExtent).

	
	^cartListColumnMorph.! !

!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/27/2021 17:49:48'!
buildCartListHeaderWithExtent: anExtent

	| catalogMorph |
	
	catalogMorph := LayoutMorph newRow.
	catalogMorph separation: 1@1; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: 'Book name' ownerExtent: anExtent);
	addMorph: (self buildCatalogTableItem: 'ISBN' ownerExtent: anExtent);
	addMorph: (self buildCatalogTableItem: 'Quantity' ownerExtent: anExtent).
	^ catalogMorph.! !

!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/27/2021 20:24:47'!
buildCartListMorphWith: anExtent

	| rightColumnMorph scrollMorph |
	
	rightColumnMorph := LayoutMorph newColumn.
	
	scrollMorph := PluggableScrollPane new.
	scrollMorph morphExtent: (anExtent x) @ (anExtent y);
	scroller: rightColumnMorph.
	
	rightColumnMorph separation: 1@1; 
	axisEdgeWeight: 0.0.
	rightColumnMorph addMorph: (self buildCartListHeaderWithExtent: scrollMorph morphExtent).

	
	^ scrollMorph.! !

!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/27/2021 17:24:12'!
buildCheckoutRowWith: anExtent
	| checkoutButton checkoutRow |
	
	checkoutButton := PluggableButtonMorph model: self model stateGetter: nil action: nil  label: 'Checkout'.
	
	checkoutRow := LayoutMorph newRow.
	checkoutRow separation: 0@0;
	axisEdgeWeight: 0.5;
	morphExtent: (anExtent x) @ (anExtent y * 0.2);
 	addMorph: checkoutButton.
	
	^checkoutRow.! !


!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 17:01:18'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 1@1;
	axisEdgeWeight: 0.0;
	morphExtent: self defaultExtent;
	addMorph: self buildShopHeader;
	addMorph: self buildShopBody.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 17:35:31'!
buildShopBody

	| bodyLayoutMorph catalogColumn cartListColumn |
		
	catalogColumn := self buildCatalogColumn.
	cartListColumn := self buildCartListColumn.
		
	bodyLayoutMorph := LayoutMorph newRow.
	bodyLayoutMorph separation: 1@1;
	axisEdgeWeight: 0.0;
	morphExtent: (self defaultExtent x)@(self defaultExtent y * 0.9) ;
	addMorph: catalogColumn;
	addMorph: cartListColumn.
	
	^bodyLayoutMorph.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 18:49:02'!
buildShopHeader

	| firstRowLayoutMorph headerButtonsMorph |
		
	headerButtonsMorph := LayoutMorph newRow.
	headerButtonsMorph separation: 25@1;
	axisEdgeWeight: 1.0;
	morphExtent: (self defaultExtent x * 0.5)@(self defaultExtent y * 0.3);
	addMorph: (LabelMorph contents: 'Purchase history');
	addMorph: (LabelMorph contents: 'Checkout').
	
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25@1;
	axisEdgeWeight: 0.0;
	morphExtent: (self defaultExtent x)@(self defaultExtent y * 0.3);
	addMorph:  (LabelMorph contents:'Welcome, ',self model username,'!!');
	addMorph: headerButtonsMorph.
	
	^firstRowLayoutMorph.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 16:38:21'!
defaultExtent

	^ 1335@685
	! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 22:06:19'!
initializeWith: aTitle and: aUsername and: aPassword and: aCartID 

	counterModels := Dictionary new.
	counterTextMorphs := Dictionary new.
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (CatalogWindowModel with: aUsername and: aPassword and: aCartID ).
	self morphExtent: self defaultExtent.
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #booksAddedToCart evaluate: [:aValue | self updateBooksSentSuccessfuly: aValue].
	
	"Investigar:
	self model when: #newWordsArrived send: #refreshListOfWords:and: to: self."! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 22:12:19'!
updateBooksSentSuccessfuly: aCollectionOfBooksAndQuantitys

	aCollectionOfBooksAndQuantitys do: [:anAssociation | |counterModel|
											   cartListMorph scroller addMorph: (self buildCartItemRowWith: anAssociation value 
																						   of: anAssociation key
																						withExtent: cartListMorph morphExtent).
											  counterModel _ (counterModels at: anAssociation key) value: '0'.
											  self updateCounterTextMorphBasedOn: counterModel 
								]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogWindow class' category: 'TusLibros-Graphics'!
CatalogWindow class
	instanceVariableNames: ''!

!CatalogWindow class methodsFor: 'instance creation' stamp: 'MP 11/20/2021 19:57:41'!
openWithUser: aUsername andPass: aPassword andCart: aCartID 
	
	^self new initializeWith: 'TusLibros - shop' and: aUsername and: aPassword and: aCartID.! !


!classDefinition: #ErrorWindow category: 'TusLibros-Graphics'!
Panel subclass: #ErrorWindow
	instanceVariableNames: 'dictionaryOfErrors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:28:45'!
ErrorRowFor: isbn text: err
    
    | morph |
    morph _ LayoutMorph  newRow.
    morph separation: 0@0;
    axisEdgeWeight: 0.0;
    addMorph: (LabelMorph contents: (isbn, ': ', err)).
    ^ morph! !

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:28:50'!
buildErrorsMorph 

    | errorsMorph |
    errorsMorph := LayoutMorph newColumn.
    errorsMorph separation: 0@5;
    axisEdgeWeight: 0.0.
    dictionaryOfErrors keysAndValuesDo: [:isbn :err | errorsMorph addMorph: (self ErrorRowFor: isbn text: err)].
    ^ errorsMorph.! !

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:28:35'!
buildMorphicWindow
    
    | errorsMorph scrollMorph |
    errorsMorph := self buildErrorsMorph.
    
    scrollMorph := PluggableScrollPane new.
    scrollMorph morphExtent: self defaultExtent*0.8;
    scroller: errorsMorph.
    
    self layoutMorph beColumn;
    separation: 10@10;
    axisEdgeWeight: 0.0;
    morphExtent: self defaultExtent;
    addMorph: scrollMorph.! !

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:28:23'!
defaultExtent

	^800@300.! !

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:27:28'!
initializeWith: aName and: aDictionaryOfErrors 
    
    dictionaryOfErrors := aDictionaryOfErrors.

    self titleMorph showButtonsNamed: #( close collapse ).
    self setLabel: aName.
    self model: nil.
    self morphExtent: self defaultExtent.
    self buildMorphicWindow.
    self openInWorld.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorWindow class' category: 'TusLibros-Graphics'!
ErrorWindow class
	instanceVariableNames: ''!

!ErrorWindow class methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:32:25'!
openWith: aTitle and: aDictionaryOfErrors

	^self new initializeWith: aTitle and: aDictionaryOfErrors .! !


!classDefinition: #LoginWindow category: 'TusLibros-Graphics'!
Panel subclass: #LoginWindow
	instanceVariableNames: 'userTextBoxMorph passwordTextBoxMorph errorMessageMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 21:01:44'!
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

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:56:40'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (LoginWindowModel new).
	self morphExtent: self defaultExtent.
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #authenticationFailure evaluate: [:anErrorDescription | self loginErrorWith: anErrorDescription].
	self model when: #authenticationSuccess evaluate: [:aUsername :aPassword :aCartId | self loginSuccessfulFor: aUsername with:aPassword andObtaining: aCartId ].
	
	"Investigar:
	self model when: #newWordsArrived send: #refreshListOfWords:and: to: self."! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:56:03'!
loginErrorWith: anErrorMessage

	errorMessageMorph contents: anErrorMessage .! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:56:29'!
loginSuccessfulFor: aUsername with:aPassword andObtaining: aCartId

	CatalogWindow openWithUser: aUsername andPass: aPassword andCart: aCartId.
	self delete! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoginWindow class' category: 'TusLibros-Graphics'!
LoginWindow class
	instanceVariableNames: ''!

!LoginWindow class methodsFor: 'instance creation' stamp: 'AF 11/27/2021 13:05:38'!
open
	
	^self new initializeWith: 'TusLibros - login'.! !


!classDefinition: #CatalogWindowModel category: 'TusLibros-Graphics'!
Object subclass: #CatalogWindowModel
	instanceVariableNames: 'username password cartId catalog localCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 21:09:56'!
addToCart

	|client notDecodedResponse respDict raisedErrors xxxx |
	client _ WebClient new.
	xxxx _ OrderedCollection new.
	raisedErrors _ Dictionary new.
	localCart keysAndValuesDo: [:anISBN :aQuantity | aQuantity = 0 ifFalse:[
	
		notDecodedResponse _ (client httpGet: 'http://localhost:8080/addToCart?cartId=',cartId asString,'&bookIsbn=', anISBN,'&bookQuantity=', aQuantity asString).
		respDict _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
		(respDict at: 'status') = 0
			ifTrue: [
				xxxx add: anISBN -> aQuantity.
			] 
			ifFalse: [
				raisedErrors add: anISBN -> (respDict at: 'errorDescription').
			]
		]
	].
	
	client close.
	
	raisedErrors ifNotEmpty: [ErrorWindow openWith: 'The following books could not be added' and: raisedErrors].
	
	xxxx ifNotEmpty: [self triggerEvent: #booksAddedToCart with: xxxx.]! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 19:27:11'!
cartId

	^cartId.! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 18:41:04'!
catalog

	^catalog.
! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 18:52:10'!
fetchCatalog

	| dict |
	dict _ Dictionary new.
	
	dict add: '00000000' -> 'Moby Dick';
	add: '00000001' -> 'Winnie Pooh';
	add: '00000002' -> 'Haikyuu!!!!';
	add: '00000003' -> 'Eragon';
	add: '00000004' -> 'The Shining';
	add: '00000005' -> 'Eldest';
	add: '00000006' -> 'Legado'.
	
	
	^dict.! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 19:16:24'!
initializeWith: aUser and: aPassword and: aCartId

	username := aUser.
	password  := aPassword .
	cartId := aCartId .

	catalog := self fetchCatalog.

	localCart := Dictionary new.! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 19:15:06'!
updateLocalCartAt: anISBN with: anAmount

	localCart add: anISBN -> anAmount.
	! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 18:49:17'!
username 

	^username.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogWindowModel class' category: 'TusLibros-Graphics'!
CatalogWindowModel class
	instanceVariableNames: ''!

!CatalogWindowModel class methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 17:56:16'!
with: aUser and: aPassword and: aCartId

	^self basicNew initializeWith: aUser and: aPassword and: aCartId.! !


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

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 21:20:27'!
reset

	|newValue|

	newValue _ 0.
	self value: newValue asString.
	self triggerEvent: #updateCounter with: self.	
! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/26/2021 19:41:50'!
value

	^ value.! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 22:01:14'!
value: aValue
	[
		|num|
		num _ aValue asNumber asInteger.
		num >= 0 ifTrue: [value _ num asString].
	] on: Error do: [].! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 22:01:22'!
valueDown

	|newValue|

	newValue _ self value asNumber asInteger -1.
	newValue >= 0 ifTrue: [self value: newValue asString.
					    self triggerEvent: #updateCounter with: self].
	
! !

!ItemCounterModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 22:01:30'!
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

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 21:05:36'!
authenticate

	|client notDecodedResponse respDict |
	client _ WebClient new.
	notDecodedResponse _ (client httpGet: 'http://localhost:8080/createCart?clientId=',self username,'&password=',self password ).
	respDict _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
	(respDict at: 'status') = 0
		ifTrue: [
			|cartId|
			cartId _ respDict at: 'cartId'.
			
			self triggerEvent: #authenticationSuccess  withArguments: {username copy. password copy. cartId.}
			
		] 
		ifFalse: [
			
			self triggerEvent: #authenticationFailure with: (respDict at: 'errorDescription').
		].
	
	
	client close.
	
	! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:58:13'!
initialize

	username := ''.
	password := '' "Dont do this at home kids".! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 17:56:49'!
password
	^ password.
	! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:58:03'!
password: aPassword

	password _ aPassword asString.

	! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 17:51:54'!
username
	^ username.
	! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:57:54'!
username: aUsername

	username _ aUsername asString.

	! !
