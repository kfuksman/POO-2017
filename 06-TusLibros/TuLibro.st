!classDefinition: #TuLibroTests category: #TuLibro!
TestCase subclass: #TuLibroTests
	instanceVariableNames: 'aCart catalogWithElements emptyCatalog cartWithEmptyCatalog cashier cartWithElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:29:44'!
setUp
	catalogWithElements := Catalog new.
	catalogWithElements  put: 1 withPrice: 1.
	catalogWithElements  put: 2 withPrice: 1.
		
	emptyCatalog := Catalog new.
	
	aCart := Cart withCatalog: catalogWithElements.
	cartWithEmptyCatalog := Cart withCatalog: emptyCatalog.
	cartWithElements := Cart withCatalog: catalogWithElements .
	cartWithElements add: 1.
	cartWithElements add: 2.
	
	cashier := Cashier new.
! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:39:04'!
test01
	self assert: aCart isEmpty.! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:39:11'!
test02
	aCart add: 1.
	self deny: aCart isEmpty.! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:39:16'!
test03
	aCart add: 1.
	self assert: aCart elements = 1! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:39:21'!
test04
	aCart add: 1.
	aCart add: 2.
	self assert: aCart elements = 2! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:39:26'!
test05
	aCart add: 1 quantity: 2.
	aCart add: 2.
	self assert: aCart elements = 3! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:39:32'!
test06
	aCart add: 1 quantity: 2.
	self assert: (aCart contents: 1)! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:39:36'!
test07
	aCart add: 1 quantity: 2.
	self deny: (aCart contents: 2)! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:39:41'!
test08
	aCart add: 1 quantity: 2.
	self assert: (aCart quantityOf: 1 ) = 2! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:39:46'!
test09

	aCart add: 1 quantity: 1.
	self assert: (aCart quantityOf: 1 ) = 1! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:41:54'!
test10

	self should: [cartWithEmptyCatalog add: 1] 
		raise: Error 
		withExceptionDo: [:anError |
								anError messageText = 'No pertenece al catalogo'.
								self assert: cartWithEmptyCatalog isEmpty .
							 ].! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:57:22'!
test11

	self should: [cashier cost: cartWithEmptyCatalog ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [:anError |
								anError messageText = 'No me pases un cart vacio'.
							 ].! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:32:51'!
test12

	self assert: (cashier cost: cartWithElements ) = 2! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:31:36'!
test13

	
	self shouldnt:[ Card withNumber: 1  withName: 'kevin' withExpirationDate: (Month month:01 year: 2018).]  raise: Error  description:  'expiro'
! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:28:39'!
test14

	|aCard |
	
	self should: [Card withNumber: 1  withName: 'kevin' withExpirationDate: (Month month:12 year: 2012).] 
			raise: Error
			withExceptionDo: [:anError | anError messageText = 'expiro'.
									self assert: aCard = nil.
								]
! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:35:24'!
test15

	|aCard |
	
	self should: [Card withNumber: 1  withName: 'kevin' withExpirationDate: (Month month:1 year: 2015).] 
			raise: Error
			withExceptionDo: [:anError | anError messageText = 'expiro'.
									self assert: aCard = nil.
								]
! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:48:05'!
test16

	| month today |
	today := Date today.
	month := MonthOfYear today: today.
	
	self assert: month month = today monthIndex .! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:49:30'!
test17

	| month today |
	today := Date today.
	month := MonthOfYear today: today.
	
	self assert: month month = today monthIndex .! !


!classDefinition: #Card category: #TuLibro!
Object subclass: #Card
	instanceVariableNames: 'cardNumber cardHolder expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Card methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:10:16'!
isValid
	self shouldBeImplemented! !

!Card methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:09:35'!
withNumber: acardNumber withName: acardHolder withExpirationDate: amonthOfYear 
	cardNumber := acardNumber.
	cardHolder := acardHolder.
	expirationDate := amonthOfYear .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TuLibro!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:34:47'!
withNumber: cardNumber withName: cardHolder withExpirationDate: monthYear 
	
	|actualMonthYear|
	
	actualMonthYear := Month month: (Date today monthIndex ) year:  (Date today yearNumber ).
	(monthYear yearNumber < actualMonthYear yearNumber) ifTrue: [self error: 'expiro'].
	((monthYear monthIndex < actualMonthYear monthIndex ) and: [monthYear yearNumber = actualMonthYear yearNumber]) ifTrue: [self error: 'expiro'].

	^self new withNumber: cardNumber withName: cardHolder withExpirationDate: monthYear ! !


!classDefinition: #Cart category: #TuLibro!
Object subclass: #Cart
	instanceVariableNames: 'elements catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:21:40'!
add: anElement
	self add: anElement quantity: 1.
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:26:19'!
add: anElement quantity: aQuantity 
	self assert: aQuantity isInteger.
	self assert:  aQuantity  > 0.
	
	(catalog includes: anElement) ifFalse: [self error: 'No pertenece al catalogo'].
	
	elements add: anElement withOccurrences: aQuantity.
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:30:06'!
catalog
	^ catalog ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:07:58'!
contents: anElement
		^ elements includes: anElement .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 20:09:40'!
elements
	^ elements size ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 20:04:38'!
initialize
	elements := Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 19:59:44'!
isEmpty
	^ elements isEmpty .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 20:10:23'!
quantityOf: anElement
	^ elements occurrencesOf: anElement 
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 22:37:53'!
withCatalog: anOrderedCollection 
	catalog := anOrderedCollection.
	elements := Bag new.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TuLibro!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'class initialization' stamp: 'kf 6/13/2017 22:37:17'!
withCatalog: anOrderedCollection 
	^ self new withCatalog: anOrderedCollection ! !


!classDefinition: #Cashier category: #TuLibro!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:32:41'!
cost: aCart 
	|catalog cost|
	
	aCart isEmpty  ifTrue: [	self error: 'No me pases un cart vacio'.].

	catalog := aCart catalog.
	cost := 0.
	(catalog contents) do:[:element | 
								cost := cost + (catalog cost: element)
							 ].

	^ cost.
! !


!classDefinition: #Catalog category: #TuLibro!
Object subclass: #Catalog
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Catalog methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:30:42'!
contents
	^ elements contents ! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:31:56'!
cost: anElement
	^ elements at: anElement ! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:26:51'!
includes: anElement 
	^ elements includesKey: anElement ! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:25:33'!
initialize
	elements := Dictionary new.! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'kf 6/13/2017 23:25:04'!
put: anElement withPrice: price 
	elements at: anElement put: price.! !


!classDefinition: #MonthOfYear category: #TuLibro!
Object subclass: #MonthOfYear
	instanceVariableNames: 'month year'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!MonthOfYear methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:48:00'!
month
	^month ! !

!MonthOfYear methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:06:58'!
month: aMonth year: aYear
	month := aMonth.
	year := aYear.! !

!MonthOfYear methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:45:29'!
monthClass
	^ Month month: month year: year ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MonthOfYear class' category: #TuLibro!
MonthOfYear class
	instanceVariableNames: ''!

!MonthOfYear class methodsFor: 'class initialization' stamp: 'kf 6/14/2017 00:06:35'!
month: aMonth year: aYear
	^ self new month: aMonth year: aYear! !

!MonthOfYear class methodsFor: 'class initialization' stamp: 'kf 6/14/2017 00:44:45'!
today: today
	^ self new month: today monthIndex year: today yearNumber ! !
