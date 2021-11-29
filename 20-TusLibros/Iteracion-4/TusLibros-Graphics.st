!classDefinition: #CatalogWindow category: 'TusLibros-Graphics'!
Panel subclass: #CatalogWindow
	instanceVariableNames: 'counterTextMorphs cartListMorph counterModels cartItemsQuantityMorphs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/29/2021 14:35:28'!
buildCatalogColumn

  	| bodyLayoutMorph |

 	bodyLayoutMorph := LayoutMorph newColumn.
  	bodyLayoutMorph separation: 1@1;
  	axisEdgeWeight: 0.0;
  	morphExtent: (self defaultExtent x * 0.5)@(self defaultExtent y * 0.70) ;
	addMorph: (self build2ColumnListHeaderWithExtent: bodyLayoutMorph morphExtent withLabels: 'Book Title' and: 'Price');
	addMorph: (self buildCatalogMorphWith: bodyLayoutMorph morphExtent);
	addMorph: (self buildButtonRowWith: bodyLayoutMorph morphExtent andAction: #addToCart andLabel: 'Add to cart' andModel: self).

    
    	^bodyLayoutMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/29/2021 15:02:36'!
buildCatalogItemRowWithName: aBookName withPrice: aPrice withExtent: anExtent 

	| itemMorph |
	itemMorph := LayoutMorph newRow.
	itemMorph separation: 0@0; 
	morphWidth: anExtent x; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildTableItem: aBookName ownerExtent: itemMorph morphExtent);
	addMorph: (self buildTableItem: aPrice ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCounterMorph: aBookName).


	^ itemMorph.
! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/29/2021 14:58:27'!
buildCatalogMorphWith: anExtent
	
	| scrollMorph catalog |
	
	scrollMorph _ self buildScrollableListWith: anExtent.
	
	catalog _ self model catalog.
	catalog keys do: [: aTitle | scrollMorph scroller addMorph: (self buildCatalogItemRowWithName: aTitle withPrice: (catalog at: aTitle) asString withExtent: scrollMorph morphExtent).].
	
	^ scrollMorph.
	
	! !


!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/29/2021 14:59:37'!
buildCartItemRowWith: aQuantity of: aBookTitle withExtent: anExtent

	| itemMorph quantityMorph |
	itemMorph := LayoutMorph newRow.
	itemMorph separation: 0@0; 
	morphWidth: anExtent x; 
	axisEdgeWeight: 0.0;
	color: Color veryLightGray ;
	addMorph: (self buildTableItem: aBookTitle ownerExtent: itemMorph morphExtent).
	
	
	quantityMorph _ (self buildTableItem: aQuantity asString ownerExtent: itemMorph morphExtent).
	
	itemMorph addMorph: quantityMorph.
	
	cartItemsQuantityMorphs add: aBookTitle -> quantityMorph.
	

	^ itemMorph.! !

!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/29/2021 15:03:13'!
buildCartListColumn

	| cartListColumnMorph |
		
	cartListColumnMorph := LayoutMorph newColumn.
	cartListColumnMorph separation: 1@1;
	axisEdgeWeight: 0.0;
	morphExtent: (self defaultExtent x * 0.4)@(self defaultExtent y * 0.70).
	
	cartListMorph := (self buildCartListMorphWith: cartListColumnMorph morphExtent).
	
	cartListColumnMorph addMorph: cartListMorph;
	addMorph: (self buildButtonRowWith: cartListColumnMorph morphExtent andAction: #checkOut andLabel: 'Checkout' andModel: self model).

	
	^cartListColumnMorph.! !

!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/29/2021 14:57:42'!
buildCartListMorphWith: anExtent

	| scrollMorph |
	
	scrollMorph _ self buildScrollableListWith: anExtent.

	scrollMorph scroller addMorph: (self build2ColumnListHeaderWithExtent: scrollMorph morphExtent withLabels: 'Book Title' and: 'Quantity' ).
	
	^ scrollMorph.
! !


!CatalogWindow methodsFor: 'counters' stamp: 'AF 11/28/2021 16:50:07'!
buildCounterMorph: anId
	| numberInputMorph counterMorph arrowDown arrowUp counter arrowsMorph counterId |
	
	counterId _ anId. 
	counter _ ItemCounterModel newWith: counterId.
	numberInputMorph := TextModelMorph textProvider: counter textGetter: #value textSetter: #value:.
	numberInputMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | numberInputMorph innerTextMorph acceptContents.] .
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

!CatalogWindow methodsFor: 'counters' stamp: 'AF 11/28/2021 16:50:12'!
updateCounterTextMorphBasedOn: aCounterModel  
	
	| textMorph counterId counterValue |
	
	counterId _ aCounterModel id.
	counterValue _ aCounterModel value.
	
	textMorph _ (counterTextMorphs at: counterId) innerTextMorph.
	textMorph contents: counterValue.
	textMorph hasUnacceptedEdits: true.
	textMorph acceptContents.
	textMorph resetTextComposition; updateFromTextComposition.
! !


!CatalogWindow methodsFor: 'shop' stamp: 'AF 11/27/2021 17:35:31'!
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

!CatalogWindow methodsFor: 'shop' stamp: 'AF 11/28/2021 20:58:03'!
buildShopHeader

	| firstRowLayoutMorph headerButtonsMorph |
		
	headerButtonsMorph := LayoutMorph newRow.
	headerButtonsMorph separation: 25@1;
	axisEdgeWeight: 1.0;
	morphExtent: (self defaultExtent x * 0.5)@(self defaultExtent y * 0.3);
	addMorph: (PluggableButtonMorph model: self stateGetter: nil action: #purchaseHistory label: 'Purchase history');
	addMorph: (PluggableButtonMorph model: self stateGetter: nil action: #logout label: 'Logout').
	
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25@1;
	axisEdgeWeight: 0.0;
	morphExtent: (self defaultExtent x)@(self defaultExtent y * 0.3);
	addMorph:  (LabelMorph contents:'Welcome, ',self model username,'!!');
	addMorph: headerButtonsMorph.
	
	^firstRowLayoutMorph.! !


!CatalogWindow methodsFor: 'generic morphs' stamp: 'AF 11/29/2021 14:59:37'!
build2ColumnListHeaderWithExtent: anExtent withLabels: firstColumnName and: secondColumnName
	
	| listHeaderMorph |
	
	listHeaderMorph := LayoutMorph newRow.
	listHeaderMorph separation: 1@1; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildTableItem: firstColumnName ownerExtent: anExtent);
	addMorph: (self buildTableItem: secondColumnName ownerExtent: anExtent).
	
	^ listHeaderMorph.
! !

!CatalogWindow methodsFor: 'generic morphs' stamp: 'AF 11/29/2021 14:51:42'!
buildButtonRowWith: anExtent andAction: anAction andLabel: aString andModel: aModel 

    | button row |
    
        button := PluggableButtonMorph model: aModel stateGetter: nil action: anAction label: aString .

        row := LayoutMorph newRow.
        row separation: 25@0;
        axisEdgeWeight: 1.0;
        morphExtent: (anExtent x) @ (anExtent y * 0.2);
        addMorph: button.

        ^row.

! !

!CatalogWindow methodsFor: 'generic morphs' stamp: 'AF 11/29/2021 14:56:43'!
buildScrollableListWith: anExtent

	| columnMorph scrollMorph |
	
	columnMorph := LayoutMorph newColumn.
	columnMorph separation: 0; 
	axisEdgeWeight: 0.0.
	
	scrollMorph := PluggableScrollPane new.
	scrollMorph morphExtent: anExtent;
	scroller: columnMorph.

	^scrollMorph.
	
! !

!CatalogWindow methodsFor: 'generic morphs' stamp: 'AF 11/29/2021 14:59:37'!
buildTableItem: aName ownerExtent: anExtent 
	
	| itemMorph |
	
	itemMorph := LabelMorph contents: aName font: FontFamily defaultFamilyAndPointSize.
	itemMorph morphWidth: (anExtent x * 0.4).
	^ itemMorph! !


!CatalogWindow methodsFor: 'events' stamp: 'AF 11/29/2021 16:23:19'!
retrieveQuantityMorphFor: aBook

	^ cartItemsQuantityMorphs at: aBook ifAbsent:[cartListMorph scroller addMorph: (self buildCartItemRowWith: 0
																				         of: aBook
																	   		     withExtent: cartListMorph morphExtent).
										cartItemsQuantityMorphs at: aBook.]! !

!CatalogWindow methodsFor: 'events' stamp: 'AF 11/29/2021 13:30:24'!
subscribeToEvents

	self model when: #booksAddedToCart evaluate: [self updateCartContents].
	self model when: #checkOutSuccessful evaluate: [:aTicket | CheckoutWindow openWithTicket: aTicket for: self model username and: self model password.
													self delete].
	self model when: #MultipleErrors evaluate: [:anErrorLabel :aCollectionOfErrorMessages | ErrorWindow openWith: anErrorLabel 
																						    and: aCollectionOfErrorMessages].	
	self model when: #Error evaluate: [:anErrorDescription | ErrorWindow openWith: anErrorDescription]! !

!CatalogWindow methodsFor: 'events' stamp: 'AF 11/29/2021 16:23:40'!
updateCartContents

	| cartContents |
	cartContents _ self model listCart.
	cartContents at: '' ifAbsent:[
	cartContents associationsDo: [:aBookQuantityAssociation | |counterModel quantityMorph|
											   quantityMorph _ (self retrieveQuantityMorphFor: aBookQuantityAssociation key).
											   quantityMorph contents: aBookQuantityAssociation value asString.
											   counterModel _ (counterModels at: aBookQuantityAssociation key ) value: '0'.
											   self updateCounterTextMorphBasedOn: counterModel 
								 ]
						 ]! !


!CatalogWindow methodsFor: 'initialization' stamp: 'AF 11/27/2021 17:01:18'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 1@1;
	axisEdgeWeight: 0.0;
	morphExtent: self defaultExtent;
	addMorph: self buildShopHeader;
	addMorph: self buildShopBody.! !

!CatalogWindow methodsFor: 'initialization' stamp: 'AF 11/29/2021 14:15:05'!
defaultExtent

	^ 1100@500
	! !

!CatalogWindow methodsFor: 'initialization' stamp: 'AF 11/29/2021 13:30:24'!
initializeWith: aTitle and: aUsername and: aPassword and: aCartID 
	
	
	counterModels := Dictionary new.
	counterTextMorphs := Dictionary new.
	cartItemsQuantityMorphs := Dictionary new.

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (CatalogWindowModel with: aUsername and: aPassword and: aCartID).
	self morphExtent: self defaultExtent.
	self buildMorphicWindow.
	self openInWorld.
			
	self subscribeToEvents
	
	"Investigar:
	self model when: #newWordsArrived send: #refreshListOfWords:and: to: self."! !


!CatalogWindow methodsFor: 'button actions' stamp: 'AF 11/28/2021 16:47:39'!
addToCart

	|booksToAdd|

	booksToAdd  _ Dictionary new.	
	counterModels associationsDo: [:aBookCounterAssociation | aBookCounterAssociation value value asNumber > 0 
												    ifTrue:[booksToAdd add: aBookCounterAssociation key -> aBookCounterAssociation value value asNumber]].
	
	self model addToCart: booksToAdd .! !

!CatalogWindow methodsFor: 'button actions' stamp: 'AF 11/28/2021 19:38:37'!
logout
	
	LoginWindow open .
	self delete.! !

!CatalogWindow methodsFor: 'button actions' stamp: 'AF 11/28/2021 20:59:01'!
purchaseHistory	

	PurchaseHistoryWindow openFor: self model username and: self model password.
! !

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

!ErrorWindow methodsFor: 'error display' stamp: 'AF 11/29/2021 15:48:52'!
ErrorRowFor: anISBN text: anErrorMessage
    
    | morph |
    morph _ LayoutMorph  newRow.
    morph separation: 0@0;
    axisEdgeWeight: 0.0;
    addMorph: (LabelMorph contents: (anISBN, ': ', anErrorMessage)).
    ^ morph! !

!ErrorWindow methodsFor: 'error display' stamp: 'AF 11/27/2021 20:28:50'!
buildErrorsMorph 

    | errorsMorph |
    errorsMorph := LayoutMorph newColumn.
    errorsMorph separation: 0@5;
    axisEdgeWeight: 0.0.
    dictionaryOfErrors keysAndValuesDo: [:isbn :err | errorsMorph addMorph: (self ErrorRowFor: isbn text: err)].
    ^ errorsMorph.! !


!ErrorWindow methodsFor: 'initialization' stamp: 'AF 11/28/2021 22:21:24'!
buildDefaultMorphicWindow: anErrorDescription

    self layoutMorph beColumn;
    separation: 10@10;
    axisEdgeWeight: 0.5;
    morphExtent: self defaultExtent;
    addMorph: (LabelMorph contents: anErrorDescription).! !

!ErrorWindow methodsFor: 'initialization' stamp: 'AF 11/28/2021 13:32:29'!
buildMorphicWindowForMultipleErrors
    
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

!ErrorWindow methodsFor: 'initialization' stamp: 'AF 11/28/2021 19:03:03'!
defaultExtent

	^600@200.! !

!ErrorWindow methodsFor: 'initialization' stamp: 'AF 11/28/2021 13:36:11'!
initializeWith: anErrorDescription

    self titleMorph showButtonsNamed: #( close collapse ).
    self setLabel: 'Error' .
    self model: nil.
    self morphExtent: self defaultExtent.
    self buildDefaultMorphicWindow: anErrorDescription .
    self openInWorld.! !

!ErrorWindow methodsFor: 'initialization' stamp: 'AF 11/28/2021 13:32:29'!
initializeWith: aName and: aDictionaryOfErrors 
    
    dictionaryOfErrors := aDictionaryOfErrors.

    self titleMorph showButtonsNamed: #( close collapse ).
    self setLabel: aName.
    self model: nil.
    self morphExtent: self defaultExtent.
    self buildMorphicWindowForMultipleErrors.
    self openInWorld.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorWindow class' category: 'TusLibros-Graphics'!
ErrorWindow class
	instanceVariableNames: ''!

!ErrorWindow class methodsFor: 'instance creation' stamp: 'AF 11/28/2021 13:33:21'!
openWith: anErrorDescription

	^self new initializeWith: anErrorDescription .! !

!ErrorWindow class methodsFor: 'instance creation' stamp: 'AF 11/27/2021 20:32:25'!
openWith: aTitle and: aDictionaryOfErrors

	^self new initializeWith: aTitle and: aDictionaryOfErrors .! !


!classDefinition: #LoginWindow category: 'TusLibros-Graphics'!
Panel subclass: #LoginWindow
	instanceVariableNames: 'userTextBoxMorph passwordTextBoxMorph errorMessageMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!LoginWindow methodsFor: 'login result' stamp: 'AF 11/27/2021 20:56:03'!
loginErrorWith: anErrorMessage

	errorMessageMorph contents: anErrorMessage .! !

!LoginWindow methodsFor: 'login result' stamp: 'AF 11/27/2021 20:56:29'!
loginSuccessfulFor: aUsername with:aPassword andObtaining: aCartId

	CatalogWindow openWithUser: aUsername andPass: aPassword andCart: aCartId.
	self delete! !


!LoginWindow methodsFor: 'initialization' stamp: 'AF 11/27/2021 13:26:42'!
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

!LoginWindow methodsFor: 'initialization' stamp: 'AF 11/27/2021 13:22:41'!
defaultExtent

	^ 475@485
	! !

!LoginWindow methodsFor: 'initialization' stamp: 'AF 11/28/2021 14:26:17'!
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


!LoginWindow methodsFor: 'building window' stamp: 'AF 11/27/2021 21:01:44'!
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

!LoginWindow methodsFor: 'building window' stamp: 'AF 11/27/2021 13:25:45'!
build1stRow1rstColumn
	| firstRowsFirstColumn |
		
	firstRowsFirstColumn := LayoutMorph newColumn .
	firstRowsFirstColumn separation: 1;
	axisEdgeWeight: 0;
	morphExtent: self minimumExtent;
	addMorph: self build1stRow ;
	addMorph: self build2ndRow .
	
	^firstRowsFirstColumn.! !

!LoginWindow methodsFor: 'building window' stamp: 'AF 11/27/2021 13:25:07'!
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

!LoginWindow methodsFor: 'building window' stamp: 'AF 11/27/2021 11:34:35'!
build3rdRow
	| loginButtonMorph thirdRowLayoutMorph |
	
	loginButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #authenticate  label: 'Create Cart'.
	
	thirdRowLayoutMorph := LayoutMorph newRow.
	thirdRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	morphExtent: self minimumExtent;
 	addMorph: loginButtonMorph.
	
	^thirdRowLayoutMorph.! !

!LoginWindow methodsFor: 'building window' stamp: 'AF 11/27/2021 11:34:40'!
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoginWindow class' category: 'TusLibros-Graphics'!
LoginWindow class
	instanceVariableNames: ''!

!LoginWindow class methodsFor: 'instance creation' stamp: 'AF 11/27/2021 13:05:38'!
open
	
	^self new initializeWith: 'TusLibros - login'.! !


!classDefinition: #SummaryWindow category: 'TusLibros-Graphics'!
Panel subclass: #SummaryWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!SummaryWindow methodsFor: 'list building' stamp: 'AF 11/29/2021 16:04:06'!
buildItem: aName ownerExtent: anExtent 
	
	| itemMorph |
	
	itemMorph := LabelMorph contents: aName font: FontFamily defaultFamilyAndPointSize.
	itemMorph morphWidth: (anExtent x *0.45).
	^ itemMorph! !

!SummaryWindow methodsFor: 'list building' stamp: 'AF 11/29/2021 16:04:00'!
buildListHeaderWithExtent: anExtent

	    | headerMorph |
	    
	    headerMorph := LayoutMorph newRow.
	    headerMorph separation: 0@0; 
	    axisEdgeWeight: 0.5;
	    addMorph: (self buildItem: 'Book name' ownerExtent: anExtent);
	    addMorph: (self buildItem: 'Spent' ownerExtent: anExtent).
	    ^ headerMorph.! !

!SummaryWindow methodsFor: 'list building' stamp: 'AF 11/29/2021 16:11:36'!
buildListMorphWith: anExtent

	self subclassResponsibility.! !

!SummaryWindow methodsFor: 'list building' stamp: 'AF 11/29/2021 16:03:45'!
buildListRowWith: aBook and: anAmountSpent andExtent: anExtent
	    | rowMorph |
	    
	    rowMorph := LayoutMorph newRow.
	    rowMorph separation: 0@0; 
	    morphExtent: anExtent;
	    axisEdgeWeight: 0.5;
	    addMorph: (self buildItem: aBook ownerExtent: anExtent);
	    addMorph: (self buildItem: anAmountSpent ownerExtent: anExtent).
	    ^ rowMorph.! !


!SummaryWindow methodsFor: 'events' stamp: 'AF 11/29/2021 16:07:11'!
subscribeToEvents
	
	self subclassResponsibility .
! !


!SummaryWindow methodsFor: 'initialization' stamp: 'AF 11/29/2021 16:06:44'!
buildMorphicWindow
       
	
	self subclassResponsibility .
! !

!SummaryWindow methodsFor: 'initialization' stamp: 'AF 11/29/2021 16:06:21'!
defaultExtent
	 ^ 600@500
! !

!SummaryWindow methodsFor: 'initialization' stamp: 'AF 11/29/2021 16:06:56'!
initializeWith: aTicket for: aUsername and: aPassword  
       
	
	self subclassResponsibility .
! !


!classDefinition: #CheckoutWindow category: 'TusLibros-Graphics'!
SummaryWindow subclass: #CheckoutWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CheckoutWindow methodsFor: 'initialization' stamp: 'AF 11/29/2021 15:59:33'!
buildMorphicWindow
       
	
	self layoutMorph beColumn;
	separation: 10;
 	axisEdgeWeight: 0.0;
 	morphExtent: self defaultExtent;
	addMorph:  (LabelMorph contents: 'Checkout');
	addMorph: (self buildListMorphWith: self defaultExtent );
	addMorph:  (LabelMorph contents: 'Total spent: $', self model ticketTotal);
	addMorph: self buildButtons.
	
! !

!CheckoutWindow methodsFor: 'initialization' stamp: 'AF 11/29/2021 16:05:22'!
initializeWith: aTicket for: aUsername and: aPassword  

 
 	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: 'Thanks for your purchase!!'.
	self model: (CheckoutWindowModel with: aTicket for: aUsername and: aPassword ).
	self morphExtent: self defaultExtent.
 	self buildMorphicWindow.
 	self openInWorld.


	self subscribeToEvents.! !


!CheckoutWindow methodsFor: 'buttons' stamp: 'AF 11/29/2021 15:52:39'!
buildButtons

	| checkoutButton checkoutRow checkoutButton2|

	checkoutButton := PluggableButtonMorph model: self stateGetter: nil action: #logout  label: 'Logout'.
	checkoutButton2 := PluggableButtonMorph model: self model stateGetter: nil action: #newPurchase  label: 'New Purchase'.

	checkoutRow := LayoutMorph newRow.
	checkoutRow separation: 50@0;
	axisEdgeWeight: 0.5;
	morphExtent: self defaultExtent;
	addMorph: checkoutButton;
	addMorph: checkoutButton2.

	^checkoutRow.
	! !

!CheckoutWindow methodsFor: 'buttons' stamp: 'AF 11/28/2021 19:09:12'!
logout
	
	LoginWindow open .
	self delete.! !


!CheckoutWindow methodsFor: 'events' stamp: 'AF 11/29/2021 16:05:22'!
subscribeToEvents

	self model when: #newPurchase evaluate: [:aCartId | CatalogWindow openWithUser: self model username andPass: self model password andCart: aCartId.
											 	self delete.].
	self model when: #logout evaluate: [self logout ]! !


!CheckoutWindow methodsFor: 'list building' stamp: 'AF 11/29/2021 16:11:17'!
buildListMorphWith: anExtent

    	| listMorph scrollMorph |
    
    	listMorph := LayoutMorph newColumn.
   	scrollMorph := PluggableScrollPane new.
    	scrollMorph morphExtent: (anExtent x *0.9) @ (anExtent y /2);
    	scroller: listMorph.
    
    	listMorph separation: 0@0; 
    	axisEdgeWeight: 0.5.
    	listMorph addMorph: (self buildListHeaderWithExtent: scrollMorph morphExtent).
	self model ticket associationsDo: [:anAssociation | listMorph addMorph: (self buildListRowWith: anAssociation key 
																				and: anAssociation value asString 
																				andExtent: scrollMorph morphExtent).].


    
    	^scrollMorph.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckoutWindow class' category: 'TusLibros-Graphics'!
CheckoutWindow class
	instanceVariableNames: ''!

!CheckoutWindow class methodsFor: 'instance creation' stamp: 'AF 11/28/2021 19:20:11'!
openWithTicket: aTicket for: aUsername and: aPassword  
  
 	^self new initializeWith: aTicket for: aUsername and: aPassword .
! !


!classDefinition: #PurchaseHistoryWindow category: 'TusLibros-Graphics'!
SummaryWindow subclass: #PurchaseHistoryWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!PurchaseHistoryWindow methodsFor: 'initialization' stamp: 'AF 11/28/2021 20:49:18'!
buildMorphicWindow
       
	
	self layoutMorph beColumn;
	separation: 10;
 	axisEdgeWeight: 0.0;
 	morphExtent: self defaultExtent;
	addMorph:  (LabelMorph contents: 'Purchase History');
	addMorph: (self buildListMorphWith: self defaultExtent );
	addMorph:  (LabelMorph contents: 'Total spent: $', self model purchasesTotal).! !

!PurchaseHistoryWindow methodsFor: 'initialization' stamp: 'AF 11/29/2021 16:05:35'!
initializeFor: aUsername and: aPassword
 
 	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: 'Purchase History'.
	self model: (PurchaseHistoryWindowModel for: aUsername and: aPassword ).
	self morphExtent: self defaultExtent.
 	self buildMorphicWindow.
 	self openInWorld.

	
	self subscribeToEvents! !


!PurchaseHistoryWindow methodsFor: 'events' stamp: 'AF 11/29/2021 16:05:35'!
subscribeToEvents

	^ self model when: #Error evaluate: [:anErrorDescription | ErrorWindow openWith: anErrorDescription.
												self delete ]! !


!PurchaseHistoryWindow methodsFor: 'list building' stamp: 'AF 11/29/2021 16:11:27'!
buildListMorphWith: anExtent

    	| listMorph scrollMorph |
    
    	listMorph := LayoutMorph newColumn.
   	scrollMorph := PluggableScrollPane new.
    	scrollMorph morphExtent: (anExtent x *0.9) @ (anExtent y /2);
    	scroller: listMorph.
    
    	listMorph separation: 0@0; 
    	axisEdgeWeight: 0.5.
    	listMorph addMorph: (self buildListHeaderWithExtent: scrollMorph morphExtent).
	self model purchases associationsDo: [:anAssociation | listMorph addMorph: (self buildListRowWith: anAssociation key 
																				and: anAssociation value asString 
																				andExtent: scrollMorph morphExtent).].


    
    	^scrollMorph.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseHistoryWindow class' category: 'TusLibros-Graphics'!
PurchaseHistoryWindow class
	instanceVariableNames: ''!

!PurchaseHistoryWindow class methodsFor: 'instance creation' stamp: 'AF 11/28/2021 20:15:50'!
openFor: aUsername and: aPassword  
  
 	^self new initializeFor: aUsername and: aPassword .
! !


!classDefinition: #CatalogWindowModel category: 'TusLibros-Graphics'!
Object subclass: #CatalogWindowModel
	instanceVariableNames: 'username password cartId catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CatalogWindowModel methodsFor: 'accessing' stamp: 'AF 11/27/2021 19:27:11'!
cartId

	^cartId.! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'AF 11/27/2021 18:41:04'!
catalog

	^catalog.
! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'AF 11/28/2021 19:30:45'!
password

	^password.! !

!CatalogWindowModel methodsFor: 'accessing' stamp: 'AF 11/27/2021 18:49:17'!
username 

	^username.! !


!CatalogWindowModel methodsFor: 'requests' stamp: 'AF 11/29/2021 15:16:49'!
addToCart: aDictionaryOfBooksAndQuantitys

	|raisedErrors |

	raisedErrors _ TusLibrosRequestSender new add: aDictionaryOfBooksAndQuantitys ToCart: cartId asString.
	
	raisedErrors ifNotEmpty: [self triggerEvent: #MultipleErrors withArguments: { 'The following books could not be added'. raisedErrors}].
	
	self triggerEvent: #booksAddedToCart! !

!CatalogWindowModel methodsFor: 'requests' stamp: 'AF 11/29/2021 15:21:40'!
checkOut

	|responseDictionary |
	
	responseDictionary _ TusLibrosRequestSender new checkOut: cartId asString.
	
	(responseDictionary at: 'status') = 0
		ifTrue: [
			self triggerEvent: #checkOutSuccessful with: (responseDictionary at: 'ticket')
		] 
		ifFalse: [
			self triggerEvent: #Error with: (responseDictionary at: 'errorDescription')
		].
	

	! !

!CatalogWindowModel methodsFor: 'requests' stamp: 'AF 11/29/2021 15:24:13'!
fetchCatalog

	|responseDictionary errorRaised|
	
	catalog _ Dictionary new.

	responseDictionary _ TusLibrosRequestSender new fetchCatalog.
	
	(responseDictionary at: 'status') = 0
		ifTrue: [
			catalog _ responseDictionary at: 'catalog'
		] 
		ifFalse: [
			errorRaised _ (responseDictionary at: 'errorDescription'),' - It was not possible to retrieve the catalog'.
			self triggerEvent: #Error with: errorRaised.			
		].

	! !

!CatalogWindowModel methodsFor: 'requests' stamp: 'AF 11/29/2021 15:27:13'!
listCart

	|responseDictionary cartContents |
	
	cartContents _ Dictionary new.

	responseDictionary _ TusLibrosRequestSender new listCart: cartId asString.
	
	(responseDictionary at: 'status') = 0
		ifTrue: [
			cartContents _ responseDictionary at: 'cartContents'
		] 
		ifFalse: [
			self triggerEvent: #Error with: (responseDictionary at: 'errorDescription')
		].

	
	^cartContents.! !


!CatalogWindowModel methodsFor: 'initialization' stamp: 'AF 11/28/2021 16:50:54'!
initializeWith: aUser and: aPassword and: aCartId

	username := aUser.
	password  := aPassword .
	cartId := aCartId .

	self fetchCatalog.

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogWindowModel class' category: 'TusLibros-Graphics'!
CatalogWindowModel class
	instanceVariableNames: ''!

!CatalogWindowModel class methodsFor: 'instance creation' stamp: 'AF 11/27/2021 17:56:16'!
with: aUser and: aPassword and: aCartId

	^self basicNew initializeWith: aUser and: aPassword and: aCartId.! !


!classDefinition: #CheckoutWindowModel category: 'TusLibros-Graphics'!
Object subclass: #CheckoutWindowModel
	instanceVariableNames: 'ticket username password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CheckoutWindowModel methodsFor: 'accessing' stamp: 'AF 11/28/2021 19:33:24'!
password
	
	^password! !

!CheckoutWindowModel methodsFor: 'accessing' stamp: 'AF 11/28/2021 18:55:20'!
ticket
	
	^ticket! !

!CheckoutWindowModel methodsFor: 'accessing' stamp: 'AF 11/28/2021 19:33:07'!
username

	^username! !


!CheckoutWindowModel methodsFor: 'ticket operations' stamp: 'AF 11/28/2021 18:51:56'!
ticketTotal

	|total|
	
	total _ 0.

	ticket valuesDo: [:aPartialAmountSpent | total _ total + aPartialAmountSpent ].
	
	^total asString.! !


!CheckoutWindowModel methodsFor: 'initialization' stamp: 'AF 11/28/2021 19:21:58'!
initializeWith: aTicket for: aUsername and: aPassword  


	ticket _ aTicket.
	username _ aUsername.
	password _ aPassword.! !


!CheckoutWindowModel methodsFor: 'new purchase' stamp: 'AF 11/29/2021 15:45:07'!
newPurchase

	| respDict |

	respDict _ TusLibrosRequestSender new createCartFor: username and: password.
	(respDict at: 'status') = 0
		ifTrue: [
			|cartId|
			cartId _ respDict at: 'cartId'.
			
			self triggerEvent: #newPurchase  with: cartId
			
		] 
		ifFalse: [
			
			self triggerEvent: #logout
		].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckoutWindowModel class' category: 'TusLibros-Graphics'!
CheckoutWindowModel class
	instanceVariableNames: ''!

!CheckoutWindowModel class methodsFor: 'instance creation' stamp: 'AF 11/28/2021 19:21:24'!
with: aTicket for: aUsername and: aPassword  

	^self new initializeWith: aTicket for: aUsername and: aPassword.! !


!classDefinition: #ItemCounterModel category: 'TusLibros-Graphics'!
Object subclass: #ItemCounterModel
	instanceVariableNames: 'value id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!ItemCounterModel methodsFor: 'initialization' stamp: 'AF 11/26/2021 19:41:35'!
initializeWith: counterId

	value _ '0'.
	id _ counterId.! !


!ItemCounterModel methodsFor: 'value edit' stamp: 'AF 11/27/2021 21:20:27'!
reset

	|newValue|

	newValue _ 0.
	self value: newValue asString.
	self triggerEvent: #updateCounter with: self.	
! !

!ItemCounterModel methodsFor: 'value edit' stamp: 'AF 11/27/2021 22:01:14'!
value: aValue
	[
		|num|
		num _ aValue asNumber asInteger.
		num >= 0 ifTrue: [value _ num asString].
	] on: Error do: [].! !

!ItemCounterModel methodsFor: 'value edit' stamp: 'AF 11/27/2021 22:01:22'!
valueDown

	|newValue|

	newValue _ self value asNumber asInteger -1.
	newValue >= 0 ifTrue: [self value: newValue asString.
					    self triggerEvent: #updateCounter with: self].
	
! !

!ItemCounterModel methodsFor: 'value edit' stamp: 'AF 11/27/2021 22:01:30'!
valueUp

	self value: (self value asNumber asInteger +1) asString.
	self triggerEvent: #updateCounter with: self.
! !


!ItemCounterModel methodsFor: 'accessing' stamp: 'AF 11/26/2021 19:41:42'!
id

	^ id! !

!ItemCounterModel methodsFor: 'accessing' stamp: 'AF 11/26/2021 19:41:50'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemCounterModel class' category: 'TusLibros-Graphics'!
ItemCounterModel class
	instanceVariableNames: ''!

!ItemCounterModel class methodsFor: 'instance creation' stamp: 'MP 11/20/2021 23:12:48'!
newWith: counterId
	^ self new initializeWith: counterId.! !


!classDefinition: #LoginWindowModel category: 'TusLibros-Graphics'!
Object subclass: #LoginWindowModel
	instanceVariableNames: 'username password response'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!LoginWindowModel methodsFor: 'accessing' stamp: 'MP 11/20/2021 17:56:49'!
password
	^ password.
	! !

!LoginWindowModel methodsFor: 'accessing' stamp: 'MP 11/20/2021 17:51:54'!
username
	^ username.
	! !


!LoginWindowModel methodsFor: 'initialization' stamp: 'AF 11/27/2021 20:58:13'!
initialize

	username := ''.
	password := '' "Dont do this at home kids".! !


!LoginWindowModel methodsFor: 'autentication' stamp: 'AF 11/29/2021 15:36:43'!
authenticate

	|responseDictionary |

	responseDictionary _ TusLibrosRequestSender new createCartFor: self username and: self password.
	
	(responseDictionary at: 'status') = 0
		ifTrue: [
			|cartId|
			cartId _ responseDictionary at: 'cartId'.
			
			self triggerEvent: #authenticationSuccess  withArguments: {username copy. password copy. cartId.}
			
		] 
		ifFalse: [
			
			self triggerEvent: #authenticationFailure with: (responseDictionary at: 'errorDescription').
		].
	
	! !

!LoginWindowModel methodsFor: 'autentication' stamp: 'AF 11/27/2021 20:58:03'!
password: aPassword

	password _ aPassword asString.

	! !

!LoginWindowModel methodsFor: 'autentication' stamp: 'AF 11/27/2021 20:57:54'!
username: aUsername

	username _ aUsername asString.

	! !


!classDefinition: #PurchaseHistoryWindowModel category: 'TusLibros-Graphics'!
Object subclass: #PurchaseHistoryWindowModel
	instanceVariableNames: 'username password purchases errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!PurchaseHistoryWindowModel methodsFor: 'purchases' stamp: 'AF 11/29/2021 15:41:50'!
listPurchases

	|responseDictionary |
	
	purchases _ Dictionary new.
	
	responseDictionary _ TusLibrosRequestSender new listPurchasesOf: username and: password.
	(responseDictionary at: 'status') = 0
		ifTrue: [
			purchases _ responseDictionary at: 'purchases'
		] 
		ifFalse: [
			self triggerEvent: #Error with: (responseDictionary at: 'errorDescription')
		].


	! !

!PurchaseHistoryWindowModel methodsFor: 'purchases' stamp: 'AF 11/28/2021 21:24:01'!
purchases

	^purchases! !

!PurchaseHistoryWindowModel methodsFor: 'purchases' stamp: 'AF 11/28/2021 21:26:45'!
purchasesTotal
	
	|total|
	
	total _ 0.
	purchases associationsDo: [: anAssociation | total _ total + anAssociation value].
	
	^total asString.! !


!PurchaseHistoryWindowModel methodsFor: 'initialization' stamp: 'AF 11/28/2021 20:19:03'!
initializeFor: aUsername and: aPassword

	username _ aUsername.
	password  _ aPassword.
	
	
	self listPurchases.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseHistoryWindowModel class' category: 'TusLibros-Graphics'!
PurchaseHistoryWindowModel class
	instanceVariableNames: ''!

!PurchaseHistoryWindowModel class methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:17:32'!
for: aUsername and: aPassword 

	^self new initializeFor: aUsername and: aPassword .! !


!classDefinition: #TusLibrosRequestSender category: 'TusLibros-Graphics'!
Object subclass: #TusLibrosRequestSender
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!TusLibrosRequestSender methodsFor: 'initialization' stamp: 'AF 11/29/2021 15:30:35'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosRequestSender methodsFor: 'initialization' stamp: 'AF 11/29/2021 15:30:22'!
url
	
	^'http://localhost:', self port asString! !


!TusLibrosRequestSender methodsFor: 'sending requests' stamp: 'AF 11/29/2021 15:31:06'!
add: aDictionaryOfBooksAndQuantitys ToCart: aCartId

	|client notDecodedResponse responseDictionary raisedErrors |
	client _ WebClient new.
	raisedErrors _ Dictionary new.
	aDictionaryOfBooksAndQuantitys keysAndValuesDo: [:anISBN :aQuantity | aQuantity = 0 ifFalse:[
		|encodedISBN|
		encodedISBN _ self encodeSpacesForUrl: anISBN.
		notDecodedResponse _ (client httpGet: self url, '/addToCart?cartId=', aCartId,'&bookIsbn=', encodedISBN ,'&bookQuantity=', aQuantity asString).
		responseDictionary _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
		(responseDictionary at: 'status') = 0
			ifFalse: [
				raisedErrors add: anISBN -> (responseDictionary at: 'errorDescription').
			]
		]
	].
	
	client close.
	
	^raisedErrors .! !

!TusLibrosRequestSender methodsFor: 'sending requests' stamp: 'AF 11/29/2021 15:31:45'!
checkOut: aCartId

	|client notDecodedResponse cced cco cnn |
	client _ WebClient new.
	
	cnn _ '1111222233334444'.
	cced _ self encodeSpacesForUrl: (Month month: DateAndTime now monthIndex year: DateAndTime now yearNumber + 1) asString.
	cco _ self encodeSpacesForUrl: 'Juan Perez'.

	notDecodedResponse _ (client httpGet: self url, '/checkOutCart?cartId=', aCartId,
			    										    '&ccn=', cnn, 
			    										  '&cced=', cced,
			    										   '&cco=', cco).
	client close.
	
	^WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
	
	! !

!TusLibrosRequestSender methodsFor: 'sending requests' stamp: 'AF 11/29/2021 15:35:11'!
createCartFor: aUser and: aPassword

	|client notDecodedResponse |
	client _ WebClient new.
	notDecodedResponse _ (client httpGet: self url,'/createCart?clientId=', aUser,'&password=', aPassword ).
	client close.
	^WebUtils jsonMapFrom: (notDecodedResponse content) readStream.! !

!TusLibrosRequestSender methodsFor: 'sending requests' stamp: 'AF 11/29/2021 15:17:32'!
encodeSpacesForUrl: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!TusLibrosRequestSender methodsFor: 'sending requests' stamp: 'AF 11/29/2021 15:32:07'!
fetchCatalog

	|client notDecodedResponse |
	
	client _ WebClient new.
	
	notDecodedResponse _ (client httpGet: self url, '/fetchCatalog').
	
	client close.
	^WebUtils jsonMapFrom: (notDecodedResponse content) readStream.! !

!TusLibrosRequestSender methodsFor: 'sending requests' stamp: 'AF 11/29/2021 15:32:13'!
listCart: aCartId

	|client notDecodedResponse |
	client _ WebClient new.
	
	notDecodedResponse _ (client httpGet: self url, '/listCart?cartId=',aCartId).
	
	client close.
	
	^WebUtils jsonMapFrom: (notDecodedResponse content) readStream.! !

!TusLibrosRequestSender methodsFor: 'sending requests' stamp: 'AF 11/29/2021 15:42:50'!
listPurchasesOf: aUsername and: aPassword

	|client notDecodedResponse |
	client _ WebClient new.
	
	notDecodedResponse _ (client httpGet: self url, '/listPurchases?clientId=', aUsername ,'&password=', aPassword).
	
	client close.
	^WebUtils jsonMapFrom: (notDecodedResponse content) readStream.! !
