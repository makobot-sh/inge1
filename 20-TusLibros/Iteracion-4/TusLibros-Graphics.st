!classDefinition: #CatalogWindow category: 'TusLibros-Graphics'!
Panel subclass: #CatalogWindow
	instanceVariableNames: 'counterTextMorphs cartListMorph counterModels cartItemsQuantityMorphs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/28/2021 16:34:33'!
buildAddToCartRowWith: anExtent

    | checkoutButton checkoutRow |
    
        checkoutButton := PluggableButtonMorph model: self stateGetter: nil action: #addToCart label: 'Add to cart'.

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

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/28/2021 14:48:02'!
buildCatalogItemRowWithName: aBookName withPrice: aPrice withExtent: anExtent 

	| itemMorph |
	itemMorph := LayoutMorph newRow.
	itemMorph separation: 1@1; 
	morphWidth: anExtent x; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: aBookName ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCatalogTableItem: aPrice ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCounterMorph: aBookName).

	"TO DO: falta agregar boton para agregar al carrito"

	^ itemMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/28/2021 14:44:33'!
buildCatalogListHeaderWithExtent: anExtent
	
	| catalogMorph |
	
	catalogMorph := LayoutMorph newRow.
	catalogMorph separation: 1@1; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: 'Book name' ownerExtent: anExtent);
	addMorph: (self buildCatalogTableItem: 'Price' ownerExtent: anExtent).
	^ catalogMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/28/2021 14:47:14'!
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
	catalog keys do: [: aTitle | catalogMorph addMorph: (self buildCatalogItemRowWithName: aTitle withPrice: (catalog at: aTitle) asString withExtent: scrollMorph morphExtent).].
	
	^ scrollMorph.! !

!CatalogWindow methodsFor: 'catalog' stamp: 'AF 11/27/2021 17:51:38'!
buildCatalogTableItem: aName ownerExtent: anExtent 
	
	| itemMorph |
	
	itemMorph := LabelMorph contents: aName font: FontFamily defaultFamilyAndPointSize.
	itemMorph morphWidth: (anExtent x *0.3).
	^ itemMorph! !


!CatalogWindow methodsFor: 'auxiliary' stamp: 'AF 11/28/2021 16:50:07'!
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

!CatalogWindow methodsFor: 'auxiliary' stamp: 'AF 11/28/2021 16:50:12'!
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


!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/28/2021 16:53:44'!
buildCartItemRowWith: aQuantity of: aBookTitle withExtent: anExtent

	| itemMorph quantityMorph |
	itemMorph := LayoutMorph newRow.
	itemMorph separation: 1@1; 
	morphWidth: anExtent x; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: aBookTitle ownerExtent: itemMorph morphExtent);
	addMorph: (self buildCatalogTableItem: '' ownerExtent: itemMorph morphExtent).
	
	quantityMorph _ (self buildCatalogTableItem: aQuantity asString ownerExtent: itemMorph morphExtent).
	
	itemMorph addMorph: quantityMorph.
	
	cartItemsQuantityMorphs add: aBookTitle -> quantityMorph.
	

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

!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/28/2021 14:50:07'!
buildCartListHeaderWithExtent: anExtent

	| catalogMorph |
	
	catalogMorph := LayoutMorph newRow.
	catalogMorph separation: 1@1; 
	axisEdgeWeight: 0.0;
	addMorph: (self buildCatalogTableItem: 'Book name' ownerExtent: anExtent);
	addMorph: (self buildCatalogTableItem: '' ownerExtent: anExtent);
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

!CatalogWindow methodsFor: 'cart' stamp: 'AF 11/28/2021 17:30:32'!
buildCheckoutRowWith: anExtent
	| checkoutButton checkoutRow |
	
	checkoutButton := PluggableButtonMorph model: self model stateGetter: nil action: #checkOut  label: 'Checkout'.
	
	checkoutRow := LayoutMorph newRow.
	checkoutRow separation: 0@0;
	axisEdgeWeight: 0.5;
	morphExtent: (anExtent x) @ (anExtent y * 0.2);
 	addMorph: checkoutButton.
	
	^checkoutRow.! !


!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 16:47:39'!
addToCart

	|booksToAdd|

	booksToAdd  _ Dictionary new.	
	counterModels associationsDo: [:aBookCounterAssociation | aBookCounterAssociation value value asNumber > 0 
												    ifTrue:[booksToAdd add: aBookCounterAssociation key -> aBookCounterAssociation value value asNumber]].
	
	self model addToCart: booksToAdd .! !

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

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:58:03'!
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

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 16:38:21'!
defaultExtent

	^ 1335@685
	! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 22:12:46'!
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
			
	self model when: #booksAddedToCart evaluate: [self updateCartContents].
	self model when: #checkOutSuccessful evaluate: [:aTicket | CheckoutWindow openWithTicket: aTicket for: self model username and: self model password.
													self delete].
	self model when: #MultipleErrors evaluate: [:anErrorLabel :aCollectionOfErrorMessages | ErrorWindow openWith: anErrorLabel 
																						    and: aCollectionOfErrorMessages].	
	self model when: #Error evaluate: [:anErrorDescription | ErrorWindow openWith: anErrorDescription]
	
	"Investigar:
	self model when: #newWordsArrived send: #refreshListOfWords:and: to: self."! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:38:37'!
logout
	
	LoginWindow open .
	self delete.! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:59:01'!
purchaseHistory	

	PurchaseHistoryWindow openFor: self model username and: self model password.
! !

!CatalogWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 22:18:32'!
updateCartContents

	| cartContents |
	cartContents _ self model listCart.
	cartContents at: '' ifAbsent:[
	cartContents associationsDo: [:aBookQuantityAssociation | |counterModel quantityMorph|
											   quantityMorph _ (cartItemsQuantityMorphs at: aBookQuantityAssociation key ifAbsent:[
											   						cartListMorph scroller addMorph: (self buildCartItemRowWith: 0
																						     of: aBookQuantityAssociation key
																			   		 withExtent: cartListMorph morphExtent).
											    						cartItemsQuantityMorphs at: aBookQuantityAssociation key.]).
											   quantityMorph contents: aBookQuantityAssociation value asString.
											   counterModel _ (counterModels at: aBookQuantityAssociation key ) value: '0'.
											   self updateCounterTextMorphBasedOn: counterModel 
								 ]
						 ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogWindow class' category: 'TusLibros-Graphics'!
CatalogWindow class
	instanceVariableNames: ''!

!CatalogWindow class methodsFor: 'instance creation' stamp: 'MP 11/20/2021 19:57:41'!
openWithUser: aUsername andPass: aPassword andCart: aCartID 
	
	^self new initializeWith: 'TusLibros - shop' and: aUsername and: aPassword and: aCartID.! !


!classDefinition: #CheckoutWindow category: 'TusLibros-Graphics'!
Panel subclass: #CheckoutWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:12:45'!
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

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'Chiro 11/27/2021 18:09:00'!
buildCheckoutHeader
	| firstRowLayoutMorph |
		
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25@1;
	axisEdgeWeight: 0.0;
	morphExtent: (self defaultExtent x)@1;
	addMorph:  (LabelMorph contents: 'test').
	
	^firstRowLayoutMorph.! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:47:37'!
buildMorphicWindow
       
	
	self layoutMorph beColumn;
	separation: 10;
 	axisEdgeWeight: 0.0;
 	morphExtent: self defaultExtent;
	addMorph:  (LabelMorph contents: 'Checkout');
	addMorph: (self buildTicketMorphWith: self defaultExtent );
	addMorph:  (LabelMorph contents: 'Total spent: $', self model ticketTotal);
	addMorph: self buildButtons.
	
! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 21:22:31'!
buildTicketHeaderWithExtent: anExtent
	    | headerMorph |
	    
	    headerMorph := LayoutMorph newRow.
	    headerMorph separation: 0@0; 
	    axisEdgeWeight: 0.5;
	    addMorph: (self buildTicketItem: 'Book name' ownerExtent: anExtent);
	    addMorph: (self buildTicketItem: 'Spent' ownerExtent: anExtent).
	    ^ headerMorph.! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 18:51:09'!
buildTicketItem: aName ownerExtent: anExtent 
	
	| itemMorph |
	
	itemMorph := LabelMorph contents: aName font: FontFamily defaultFamilyAndPointSize.
	itemMorph morphWidth: (anExtent x *0.45).
	^ itemMorph! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:51:56'!
buildTicketListRowWith: aBook and: anAmountSpent andExtent: anExtent
	    | rowMorph |
	    
	    rowMorph := LayoutMorph newRow.
	    rowMorph separation: 0@0; 
	    morphExtent: anExtent;
	    axisEdgeWeight: 0.5;
	    addMorph: (self buildTicketItem: aBook ownerExtent: anExtent);
	    addMorph: (self buildTicketItem: anAmountSpent ownerExtent: anExtent).
	    ^ rowMorph.! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 18:52:56'!
buildTicketMorphWith: anExtent

    	| ticketListMorph scrollMorph |
    
    	ticketListMorph := LayoutMorph newColumn.
   	scrollMorph := PluggableScrollPane new.
    	scrollMorph morphExtent: (anExtent x *0.9) @ (anExtent y /2);
    	scroller: ticketListMorph.
    
    	ticketListMorph separation: 0@0; 
    	axisEdgeWeight: 0.5.
    	ticketListMorph addMorph: (self buildTicketHeaderWithExtent: scrollMorph morphExtent).
	self model ticket associationsDo: [:anAssociation | ticketListMorph addMorph: (self buildTicketListRowWith: anAssociation key 
																				and: anAssociation value asString 
																				andExtent: scrollMorph morphExtent).].


    
    	^scrollMorph.! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 18:43:20'!
defaultExtent
	 ^ 600@500
! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:31:35'!
initializeWith: aTicket for: aUsername and: aPassword  

 
 	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: 'Thanks for your purchase!!'.
	self model: (CheckoutWindowModel with: aTicket for: aUsername and: aPassword ).
	self morphExtent: self defaultExtent.
 	self buildMorphicWindow.
 	self openInWorld.


	self model when: #newPurchase evaluate: [:aCartId | CatalogWindow openWithUser: self model username andPass: self model password andCart: aCartId.
											 	self delete.].
	self model when: #logout evaluate: [self logout ].! !

!CheckoutWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:09:12'!
logout
	
	LoginWindow open .
	self delete.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckoutWindow class' category: 'TusLibros-Graphics'!
CheckoutWindow class
	instanceVariableNames: ''!

!CheckoutWindow class methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:20:11'!
openWithTicket: aTicket for: aUsername and: aPassword  
  
 	^self new initializeWith: aTicket for: aUsername and: aPassword .
! !


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

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 22:21:24'!
buildDefaultMorphicWindow: anErrorDescription

    self layoutMorph beColumn;
    separation: 10@10;
    axisEdgeWeight: 0.5;
    morphExtent: self defaultExtent;
    addMorph: (LabelMorph contents: anErrorDescription).! !

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 20:28:50'!
buildErrorsMorph 

    | errorsMorph |
    errorsMorph := LayoutMorph newColumn.
    errorsMorph separation: 0@5;
    axisEdgeWeight: 0.0.
    dictionaryOfErrors keysAndValuesDo: [:isbn :err | errorsMorph addMorph: (self ErrorRowFor: isbn text: err)].
    ^ errorsMorph.! !

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 13:32:29'!
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

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:03:03'!
defaultExtent

	^600@200.! !

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 13:36:11'!
initializeWith: anErrorDescription

    self titleMorph showButtonsNamed: #( close collapse ).
    self setLabel: 'Error' .
    self model: nil.
    self morphExtent: self defaultExtent.
    self buildDefaultMorphicWindow: anErrorDescription .
    self openInWorld.! !

!ErrorWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 13:32:29'!
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

!ErrorWindow class methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 13:33:21'!
openWith: anErrorDescription

	^self new initializeWith: anErrorDescription .! !

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

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 14:26:17'!
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


!classDefinition: #PurchaseHistoryWindow category: 'TusLibros-Graphics'!
Panel subclass: #PurchaseHistoryWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!PurchaseHistoryWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:54:51'!
buildItem: aName ownerExtent: anExtent 
	
	| itemMorph |
	
	itemMorph := LabelMorph contents: aName font: FontFamily defaultFamilyAndPointSize.
	itemMorph morphWidth: (anExtent x *0.45).
	^itemMorph! !

!PurchaseHistoryWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 21:23:53'!
buildListHeaderWithExtent: anExtent 

	| headerMorph |
	    
	headerMorph := LayoutMorph newRow.
	headerMorph separation: 0@0; 
	axisEdgeWeight: 0.5;
	addMorph: (self buildItem: 'Book name' ownerExtent: anExtent);
	addMorph: (self buildItem: 'Spent' ownerExtent: anExtent).
	^ headerMorph.! !

!PurchaseHistoryWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 21:21:55'!
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

!PurchaseHistoryWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:52:57'!
buildListRowWith: aBook and: anAmountSpent andExtent: anExtent
	    | rowMorph |
	    
	    rowMorph := LayoutMorph newRow.
	    rowMorph separation: 0@0; 
	    morphExtent: anExtent;
	    axisEdgeWeight: 0.5;
	    addMorph: (self buildItem: aBook ownerExtent: anExtent);
	    addMorph: (self buildItem: anAmountSpent ownerExtent: anExtent).
	    ^ rowMorph.! !

!PurchaseHistoryWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:49:18'!
buildMorphicWindow
       
	
	self layoutMorph beColumn;
	separation: 10;
 	axisEdgeWeight: 0.0;
 	morphExtent: self defaultExtent;
	addMorph:  (LabelMorph contents: 'Purchase History');
	addMorph: (self buildListMorphWith: self defaultExtent );
	addMorph:  (LabelMorph contents: 'Total spent: $', self model purchasesTotal).! !

!PurchaseHistoryWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:39:13'!
defaultExtent
	 ^ 600@500
! !

!PurchaseHistoryWindow methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 22:28:02'!
initializeFor: aUsername and: aPassword
 
 	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: 'Purchase History'.
	self model: (PurchaseHistoryWindowModel for: aUsername and: aPassword ).
	self morphExtent: self defaultExtent.
 	self buildMorphicWindow.
 	self openInWorld.

	
	self model when: #Error evaluate: [:anErrorDescription | ErrorWindow openWith: anErrorDescription.
												self delete ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseHistoryWindow class' category: 'TusLibros-Graphics'!
PurchaseHistoryWindow class
	instanceVariableNames: ''!

!PurchaseHistoryWindow class methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:15:50'!
openFor: aUsername and: aPassword  
  
 	^self new initializeFor: aUsername and: aPassword .
! !


!classDefinition: #CatalogWindowModel category: 'TusLibros-Graphics'!
Object subclass: #CatalogWindowModel
	instanceVariableNames: 'username password cartId catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 21:57:30'!
addToCart: aDictionaryOfBooksAndQuantitys

	|client notDecodedResponse respDict raisedErrors booksAdded |
	client _ WebClient new.
	booksAdded _ OrderedCollection new.
	raisedErrors _ Dictionary new.
	aDictionaryOfBooksAndQuantitys keysAndValuesDo: [:anISBN :aQuantity | aQuantity = 0 ifFalse:[
		|encodedISBN|
		encodedISBN _ self encodeSpacesForUrl: anISBN.
		notDecodedResponse _ (client httpGet: 'http://localhost:8080/addToCart?cartId=',cartId asString,'&bookIsbn=', encodedISBN ,'&bookQuantity=', aQuantity asString).
		respDict _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
		(respDict at: 'status') = 0
			ifTrue: [
				booksAdded add: anISBN -> aQuantity.
			] 
			ifFalse: [
				raisedErrors add: anISBN -> (respDict at: 'errorDescription').
			]
		]
	].
	
	client close.
	
	raisedErrors ifNotEmpty: [self triggerEvent: #MultipleErrors withArguments: { 'The following books could not be added'. raisedErrors}].
	
	self triggerEvent: #booksAddedToCart! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 19:27:11'!
cartId

	^cartId.! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/27/2021 18:41:04'!
catalog

	^catalog.
! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 22:21:54'!
checkOut

	|client notDecodedResponse responseDictionary cced cco cnn |
	client _ WebClient new.
	
	cnn _ '1111222233334444'.
	cced _ self encodeSpacesForUrl: (Month month: DateAndTime now monthIndex year: DateAndTime now yearNumber + 1) asString.
	cco _ self encodeSpacesForUrl: 'Juan Perez'.

	notDecodedResponse _ (client httpGet: 'http://localhost:8080/checkOutCart?cartId=',cartId asString,
			    										    '&ccn=', cnn, 
			    										  '&cced=', cced,
			    										   '&cco=', cco).
	responseDictionary _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
	(responseDictionary at: 'status') = 0
		ifTrue: [
			self triggerEvent: #checkOutSuccessful with: (responseDictionary at: 'ticket')
		] 
		ifFalse: [
			self triggerEvent: #Error with: (responseDictionary at: 'errorDescription')
		].
	
	client close.
	! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 16:24:54'!
encodeSpacesForUrl: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 22:10:18'!
fetchCatalog

	|client notDecodedResponse responseDictionary errorRaised|
	client _ WebClient new.
	
	catalog _ Dictionary new.
	notDecodedResponse _ (client httpGet: 'http://localhost:8080/fetchCatalog').
	responseDictionary _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
	(responseDictionary at: 'status') = 0
		ifTrue: [
			catalog _ responseDictionary at: 'catalog'
		] 
		ifFalse: [
			errorRaised _ (responseDictionary at: 'errorDescription'),' - It was not possible to retrieve the catalog'.
			self triggerEvent: #Error with: errorRaised.			
		].
			
	client close.
	! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 16:50:54'!
initializeWith: aUser and: aPassword and: aCartId

	username := aUser.
	password  := aPassword .
	cartId := aCartId .

	self fetchCatalog.

! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 22:10:42'!
listCart

	|client notDecodedResponse responseDictionary cartContents |
	client _ WebClient new.
	
	cartContents _ Dictionary new.
	notDecodedResponse _ (client httpGet: 'http://localhost:8080/listCart?cartId=',cartId asString).
	responseDictionary _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
	(responseDictionary at: 'status') = 0
		ifTrue: [
			cartContents _ responseDictionary at: 'cartContents'
		] 
		ifFalse: [
			self triggerEvent: #Error with: (responseDictionary at: 'errorDescription')
		].
			
	client close.
	
	^cartContents.! !

!CatalogWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:30:45'!
password

	^password.! !

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


!classDefinition: #CheckoutWindowModel category: 'TusLibros-Graphics'!
Object subclass: #CheckoutWindowModel
	instanceVariableNames: 'ticket username password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!CheckoutWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:21:58'!
initializeWith: aTicket for: aUsername and: aPassword  


	ticket _ aTicket.
	username _ aUsername.
	password _ aPassword.! !

!CheckoutWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:27:40'!
newPurchase

	|client notDecodedResponse respDict |
	client _ WebClient new.
	notDecodedResponse _ (client httpGet: 'http://localhost:8080/createCart?clientId=',username,'&password=',password ).
	respDict _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
	(respDict at: 'status') = 0
		ifTrue: [
			|cartId|
			cartId _ respDict at: 'cartId'.
			
			self triggerEvent: #newPurchase  with: cartId
			
		] 
		ifFalse: [
			
			self triggerEvent: #logout
		].
	
	
	client close.! !

!CheckoutWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:33:24'!
password
	
	^password! !

!CheckoutWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 18:55:20'!
ticket
	
	^ticket! !

!CheckoutWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 18:51:56'!
ticketTotal

	|total|
	
	total _ 0.

	ticket valuesDo: [:aPartialAmountSpent | total _ total + aPartialAmountSpent ].
	
	^total asString.! !

!CheckoutWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:33:07'!
username

	^username! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckoutWindowModel class' category: 'TusLibros-Graphics'!
CheckoutWindowModel class
	instanceVariableNames: ''!

!CheckoutWindowModel class methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 19:21:24'!
with: aTicket for: aUsername and: aPassword  

	^self new initializeWith: aTicket for: aUsername and: aPassword.! !


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


!classDefinition: #PurchaseHistoryWindowModel category: 'TusLibros-Graphics'!
Object subclass: #PurchaseHistoryWindowModel
	instanceVariableNames: 'username password purchases errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!PurchaseHistoryWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:19:03'!
initializeFor: aUsername and: aPassword

	username _ aUsername.
	password  _ aPassword.
	
	
	self listPurchases.! !

!PurchaseHistoryWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 22:25:58'!
listPurchases

	|client notDecodedResponse responseDictionary |
	client _ WebClient new.
	
	purchases _ Dictionary new.
	notDecodedResponse _ (client httpGet: 'http://localhost:8080/listPurchases?clientId=', username,'&password=', password).
	responseDictionary _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
	(responseDictionary at: 'status') = 0
		ifTrue: [
			purchases _ responseDictionary at: 'purchases'
		] 
		ifFalse: [
			self triggerEvent: #Error with: (responseDictionary at: 'errorDescription')
		].
			
	client close.

	! !

!PurchaseHistoryWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 21:24:01'!
purchases

	^purchases! !

!PurchaseHistoryWindowModel methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 21:26:45'!
purchasesTotal
	
	|total|
	
	total _ 0.
	purchases associationsDo: [: anAssociation | total _ total + anAssociation value].
	
	^total asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseHistoryWindowModel class' category: 'TusLibros-Graphics'!
PurchaseHistoryWindowModel class
	instanceVariableNames: ''!

!PurchaseHistoryWindowModel class methodsFor: 'as yet unclassified' stamp: 'AF 11/28/2021 20:17:32'!
for: aUsername and: aPassword 

	^self new initializeFor: aUsername and: aPassword .! !
