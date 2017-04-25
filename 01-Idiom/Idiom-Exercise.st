!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'a 4/25/2017 01:57:48'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook  |
	
	customerBook := CustomerBook  new.
	
	self assert: [ customerBook addCustomerNamed: 'John Lennon'.] shouldBeEndOn: 50.! !

!IdiomTest methodsFor: 'testing' stamp: 'a 4/25/2017 01:57:39'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.

	self assert: [customerBook removeCustomerNamed: paulMcCartney.] shouldBeEndOn: 100.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'kf 4/24/2017 20:59:37'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
		
	self assert:[ customerBook addCustomerNamed: ''.] on: Error do: 
	[:anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!IdiomTest methodsFor: 'testing' stamp: 'kf 4/24/2017 21:02:42'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assert: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!IdiomTest methodsFor: 'as yet unclassified' stamp: 'kf 4/24/2017 21:02:07'!
assert: aBlockClosure on: error do: aBlockClosureCheck

	[ aBlockClosure value. self fail ]
		on: error
		do: [ :anError | aBlockClosureCheck value:anError.]! !

!IdiomTest methodsFor: 'as yet unclassified' stamp: 'a 4/25/2017 01:57:18'!
assert: aClosure shouldBeEndOn: aTime 
	 self assert: aClosure timeToRun < aTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IdiomTest class' category: #'Idiom-Exercise'!
IdiomTest class
	instanceVariableNames: 'testSuite'!


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
