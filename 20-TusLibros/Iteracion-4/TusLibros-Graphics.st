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

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:16:45'!
build3rdRow
	| loginButtonMorph thirdRowLayoutMorph |
	
	loginButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #authenticate  label: 'login'.
	
	thirdRowLayoutMorph := LayoutMorph newRow.
	thirdRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	morphExtent: self minimumExtent;
 	addMorph: loginButtonMorph.
	
	^thirdRowLayoutMorph.! !

!LoginWindow methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:42:24'!
build4rdRow
	| thirdRowLayoutMorph |
	
	errorMessageMorph := LabelMorph contents: '' font: Preferences standardMenuFont emphasis: AbstractFont boldCode.
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

!LoginWindow class methodsFor: 'instance creation' stamp: 'MP 11/20/2021 17:34:15'!
open
	
	^self new initializeWith: 'TusLibros login window'.! !


!classDefinition: #LoginWindowModel category: 'TusLibros-Graphics'!
Object subclass: #LoginWindowModel
	instanceVariableNames: 'username password response'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Graphics'!

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 18:51:25'!
authenticate
	|client notDecodedResponse respDict |
	client _ WebClient new.
	notDecodedResponse _ (client httpGet: 'http://localhost:8080/createCart?clientId=',self username,'&password=',self password ).
	respDict _ WebUtils jsonMapFrom: (notDecodedResponse content) readStream.
	response _ respDict at: 'errorDescription' ifAbsent: [''].
	client close.
	
	self triggerEvent: #authenticationResponse! !

!LoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MP 11/20/2021 17:53:35'!
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
