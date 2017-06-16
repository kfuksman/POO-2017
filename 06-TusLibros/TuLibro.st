!classDefinition: #TuLibroTests category: #TuLibro!
TestCase subclass: #TuLibroTests
	instanceVariableNames: 'aCart catalogWithElements emptyCatalog cartWithEmptyCatalog cashier cartWithElements aValidCard anValidCard anInvalidCard anInvoice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 19:56:13'!
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
	
	aValidCard :=  Card withNumber: 1  withName: 'kevin' withExpirationDate: (Date today + 1 days).
	
	anInvoice := 2.
! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:11:03'!
test01ACartIsInitializeEmpty
	self assert: aCart isEmpty.! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:11:24'!
test02ACartWithElementsIsNotEmpty
	aCart add: 1.
	self deny: aCart isEmpty.! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:11:56'!
test03ACartKnowsWhenHasOneElement
	aCart add: 1.
	self assert: aCart elements = 1! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:12:27'!
test04ACartKnowsWhenHasAnyElementQuantity
	aCart add: 1.
	aCart add: 2.
	self assert: aCart elements = 2! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:13:02'!
test05ACartWithAQuantityOfOneElementCountsGood
	aCart add: 1 quantity: 2.
	aCart add: 2.
	self assert: aCart elements = 3! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:13:42'!
test06ACartKnowWhenHasOneContent
	aCart add: 1 quantity: 2.
	self assert: (aCart contents: 1)! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:14:07'!
test07ACartKnowHowManyContentsHas
	aCart add: 1 quantity: 2.
	self deny: (aCart contents: 2)! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:16:00'!
test08ACartKnowWhenAContentGotTwoElements
	aCart add: 1 quantity: 2.
	self assert: (aCart quantityOf: 1 ) = 2! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:16:25'!
test09ACartKnowHowManyElementsGotFromAContent

	aCart add: 1 quantity: 1.
	self assert: (aCart quantityOf: 1 ) = 1! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:17:10'!
test10ACartCantAddThingsThatAreNotInTheCatalog

	self should: [cartWithEmptyCatalog add: 1] 
		raise: Error 
		withExceptionDo: [:anError |
								anError messageText = 'No pertenece al catalogo'.
								self assert: cartWithEmptyCatalog isEmpty .
							 ].! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:17:54'!
test11ACashierCantHaveNoElementsToCash

	self should: [cashier cost: cartWithEmptyCatalog ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [:anError |
								anError messageText = 'No me pases un cart vacio'.
							 ].! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:18:21'!
test12ACashierCanCountACartCost

	self assert: (cashier cost: cartWithElements ) = 2! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:19:00'!
test13AValidCardIsNotExpired

	
	self deny: (Card withNumber: 1  withName: 'kevin' withExpirationDate: (Date today + 1 days)) isExpired 
! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:20:32'!
test14AValidCardWithAYearDifferenceIsNotExpired

	
	
	self deny: (Card withNumber: 1  withName: 'kevin' withExpirationDate: (Date today + 380 days)) isExpired 

! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:19:40'!
test15AnInvalidCardWithAYearDifferenceIsExpired

	self assert: (Card withNumber: 1  withName: 'kevin' withExpirationDate: (Date today - 367 days)) isExpired ! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:21:17'!
test16AnInvalidCardWithAMonthDifferenceIsExpired
	 
	self assert: (Card withNumber: 1  withName: 'kevin' withExpirationDate: (Date today - 32 days)) isExpired 
			! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:22:13'!
test17ACashierCanDoCheckoutWithACartWithElements

	self shouldnt: [cashier checkOut: cartWithElements withCard: anValidCard ]
		  raise: Error - MessageNotUnderstood 
! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:22:44'!
test18ACheckoutReturnAnInvoice
	
	self assert: (cashier checkOut: cartWithElements withCard: anValidCard ) = anInvoice! !


!classDefinition: #Card category: #TuLibro!
Object subclass: #Card
	instanceVariableNames: 'cardNumber cardHolder expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Card methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:04:55'!
isExpired

|actualMonthYear|
	
	actualMonthYear := Month month: (Date today monthIndex ) year:  (Date today yearNumber ).
	(expirationDate yearNumber < actualMonthYear yearNumber) ifTrue: [^true].
	((expirationDate monthIndex < actualMonthYear monthIndex ) and: [expirationDate yearNumber = actualMonthYear yearNumber]) ifTrue: [^true].

^false! !

!Card methodsFor: 'as yet unclassified' stamp: 'kf 6/16/2017 14:13:12'!
isExpiredOn: aDate
	(expirationDate yearNumber < aDate yearNumber) ifTrue: [^true].
	((expirationDate monthIndex < aDate monthIndex ) and: [expirationDate yearNumber = aDate yearNumber]) ifTrue: [^true].

^false! !

!Card methodsFor: 'as yet unclassified' stamp: 'kf 6/14/2017 00:09:35'!
withNumber: acardNumber withName: acardHolder withExpirationDate: amonthOfYear 
	cardNumber := acardNumber.
	cardHolder := acardHolder.
	expirationDate := amonthOfYear .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TuLibro!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:03:46'!
withNumber: cardNumber withName: cardHolder withExpirationDate: monthYear 
	
	
	^self new withNumber: cardNumber withName: cardHolder withExpirationDate: monthYear ! !


!classDefinition: #Cart category: #TuLibro!
Object subclass: #Cart
	instanceVariableNames: 'elements catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 19:18:49'!
add: anElement
	self add: anElement quantity: 1.
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 19:18:31'!
add: anElement quantity: aQuantity 
	self assert: aQuantity isInteger.
	self assert:  aQuantity  > 0.
	
	self assert: (catalog includes: anElement) description: [self error: 'No pertenece al catalogo'].
	
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

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 19:18:12'!
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

!Cashier methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 19:54:34'!
checkOut: aCart withCard: aCard 
	|cost|
	 cost := self cost: aCart.
	
	self debit: cost toCard: aCard.
	
	^ cost! !

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

!Cashier methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 19:36:56'!
debit: aSmallInteger toCard: anUndefinedObject ! !


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


!classDefinition: #Invoice category: #TuLibro!
Object subclass: #Invoice
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Invoice methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 19:38:05'!
isInvoice
	^ true.! !
