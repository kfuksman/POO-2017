!classDefinition: #TuLibroTests category: #TuLibro!
TestCase subclass: #TuLibroTests
	instanceVariableNames: 'aCart catalogWithElements emptyCatalog cartWithEmptyCatalog cashier cartWithElements aValidCard anInvalidCard anInvoice anExpiredCard merchant aBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!TuLibroTests methodsFor: 'card' stamp: 'kf 6/18/2017 11:05:08'!
test13AValidCardIsNotExpired

	
	self deny: ((Card withNumber: 1  withName: 'kevin' withExpirationDate: (Date today + 1 days)) isExpiredOn: Date today)
! !

!TuLibroTests methodsFor: 'card' stamp: 'kf 6/18/2017 11:05:22'!
test14AValidCardWithAYearDifferenceIsNotExpired

	
	
	self deny: ((Card withNumber: 1  withName: 'kevin' withExpirationDate: (Date today + 380 days))  isExpiredOn: Date today)
 

! !

!TuLibroTests methodsFor: 'card' stamp: 'kf 6/18/2017 11:05:30'!
test15AnInvalidCardWithAYearDifferenceIsExpired

	self assert: ((Card withNumber: 1  withName: 'kevin' withExpirationDate: (Date today - 367 days))  isExpiredOn: Date today)
! !

!TuLibroTests methodsFor: 'card' stamp: 'kf 6/18/2017 11:04:24'!
test16AnInvalidCardWithAMonthDifferenceIsExpired
	 
	self assert: ((Card withNumber: 1  withName: 'kevin' withExpirationDate: (Date today - 32 days)) isExpiredOn: Date today).
			! !

!TuLibroTests methodsFor: 'card' stamp: 'kf 6/22/2017 19:28:24'!
testcard01
	 
	self should: [Card withNumber: 123456789101  withName: '' withExpirationDate: Date today.] 
	raise: Error
	withExceptionDo: [:anError | self assert: (anError messageText = Card invalidName)].
	
! !

!TuLibroTests methodsFor: 'card' stamp: 'kf 6/22/2017 19:26:18'!
testcard02
	 
	self should: [Card withNumber: 1234567891  withName: 'ker' withExpirationDate: Date today.] 
	raise: Error
	withExceptionDo: [:anError | self assert: (anError messageText = Card invalidNumber)].
	
! !


!TuLibroTests methodsFor: 'cashier' stamp: 'kf 6/18/2017 12:54:31'!
test18ACheckoutReturnAnInvoice
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) = anInvoice! !

!TuLibroTests methodsFor: 'cashier' stamp: 'kf 6/18/2017 12:55:21'!
test24
	
	
	merchant addValidCard: anExpiredCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: anExpiredCard withBook: aBook.
	
	self should: [cashier checkOutOnDate: (Date today) withMerchant: merchant ]  
		 raise: Error 
		 withExceptionDo: [:anError | self assert: anError messageText = Card expiredError.
								self assert: aBook isEmpty.
						]! !

!TuLibroTests methodsFor: 'cashier' stamp: 'kf 6/18/2017 12:57:44'!
test25
	
	
	merchant addValidCard: aValidCard withAmount: 0.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self should: [cashier checkOutOnDate: (Date today) withMerchant: merchant ]  
		 raise: Error 
		 withExceptionDo: [:anError | self assert: anError messageText = Card withoutBalance .
								self assert: aBook isEmpty.
						]! !

!TuLibroTests methodsFor: 'cashier' stamp: 'kf 6/18/2017 12:58:42'!
test26
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) = anInvoice.
	self deny: aBook isEmpty ! !

!TuLibroTests methodsFor: 'cashier' stamp: 'kf 6/19/2017 20:52:42'!
test27

	merchant putOutService.
	merchant addValidCard: aValidCard withAmount: 0.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self should: [cashier checkOutOnDate: (Date today) withMerchant: merchant ]  
		 raise: Error 
		 withExceptionDo: [:anError | self assert: anError messageText = MerchantProcesorMock outService .
								self assert: aBook isEmpty.
						]! !


!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:11:03'!
test01ACartIsInitializeEmpty
	self assert: aCart isEmpty.! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:11:24'!
test02ACartWithElementsIsNotEmpty
	aCart add: 1.
	self deny: aCart isEmpty.! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:11:56'!
test03ACartKnowsWhenHasOneElement
	aCart add: 1.
	self assert: aCart elements = 1! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:12:27'!
test04ACartKnowsWhenHasAnyElementQuantity
	aCart add: 1.
	aCart add: 2.
	self assert: aCart elements = 2! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:13:02'!
test05ACartWithAQuantityOfOneElementCountsGood
	aCart add: 1 quantity: 2.
	aCart add: 2.
	self assert: aCart elements = 3! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:13:42'!
test06ACartKnowWhenHasOneContent
	aCart add: 1 quantity: 2.
	self assert: (aCart contents: 1)! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:14:07'!
test07ACartKnowHowManyContentsHas
	aCart add: 1 quantity: 2.
	self deny: (aCart contents: 2)! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:16:00'!
test08ACartKnowWhenAContentGotTwoElements
	aCart add: 1 quantity: 2.
	self assert: (aCart quantityOf: 1 ) = 2! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:16:25'!
test09ACartKnowHowManyElementsGotFromAContent

	aCart add: 1 quantity: 1.
	self assert: (aCart quantityOf: 1 ) = 1! !

!TuLibroTests methodsFor: 'cart' stamp: 'kf 6/15/2017 20:17:10'!
test10ACartCantAddThingsThatAreNotInTheCatalog

	self should: [cartWithEmptyCatalog add: 1] 
		raise: Error 
		withExceptionDo: [:anError |
								anError messageText = 'No pertenece al catalogo'.
								self assert: cartWithEmptyCatalog isEmpty .
							 ].! !


!TuLibroTests methodsFor: 'merchant' stamp: 'kf 6/18/2017 16:47:10'!
test19
	
	self should: [merchant debit: 100 withCard: anExpiredCard .] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| anError messageText = Card expiredError]! !

!TuLibroTests methodsFor: 'merchant' stamp: 'kf 6/18/2017 11:19:20'!
test20
	
	merchant addValidCard: aValidCard.
	
	self shouldnt: [merchant debit: 100 withCard: aValidCard .] 
	       raise: Error - MessageNotUnderstood 
		 ! !

!TuLibroTests methodsFor: 'merchant' stamp: 'kf 6/18/2017 12:50:54'!
test21
	
	self should: [merchant debit: 100 withCard: aValidCard .] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: (anError messageText = Card invalidCard )]! !

!TuLibroTests methodsFor: 'merchant' stamp: 'kf 6/18/2017 12:51:02'!
test22
	
	
	merchant addValidCard: aValidCard withAmount: 50.
	
		self should: [merchant debit: 100 withCard: aValidCard .] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: (anError messageText = Card withoutBalance )]! !

!TuLibroTests methodsFor: 'merchant' stamp: 'kf 6/18/2017 12:51:09'!
test23
		
		merchant addValidCard: aValidCard withAmount: 50.
		self should: [merchant debit: 100 withCard: aValidCard .] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: (anError messageText = Card withoutBalance )]! !

!TuLibroTests methodsFor: 'merchant' stamp: 'kf 6/18/2017 13:02:42'!
testM01

		
		merchant putOutService.
		
		self should: [merchant debit: 100 withCard: aValidCard .] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: (anError messageText = MerchantProcesorMock outService )]! !


!TuLibroTests methodsFor: 'setUp' stamp: 'kf 6/18/2017 11:36:06'!
cashierWithCart: aCart withCard: aCard withBook: aBook 
	^ Cashier withCart: aCart withCard: aCard withBook: aBook ! !

!TuLibroTests methodsFor: 'setUp' stamp: 'kf 6/22/2017 19:31:12'!
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
	
	aValidCard :=  Card withNumber: 123456789101  withName: 'kevin' withExpirationDate: (Date today + 1 days).
	anExpiredCard := Card withNumber: 213456789101  withName: 'kevin' withExpirationDate: (Date today - 60 days).
		
	anInvoice := 2.
	
	merchant :=MerchantProcesorMock withDate: Date today.

	aBook := OrderedCollection new.! !


!classDefinition: #Card category: #TuLibro!
Object subclass: #Card
	instanceVariableNames: 'cardNumber cardHolder expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Card methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 11:07:57'!
= aCard

	(aCard isKindOf: self class) ifFalse: [^false].
	^ cardNumber = aCard cardNumber! !

!Card methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 11:19:47'!
cardNumber
	^ cardNumber ! !

!Card methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 20:04:55'!
isExpired

|actualMonthYear|
	
	actualMonthYear := Month month: (Date today monthIndex ) year:  (Date today yearNumber ).
	(expirationDate yearNumber < actualMonthYear yearNumber) ifTrue: [^true].
	((expirationDate monthIndex < actualMonthYear monthIndex ) and: [expirationDate yearNumber = actualMonthYear yearNumber]) ifTrue: [^true].

^false! !

!Card methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 11:04:49'!
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

!Card class methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 11:50:06'!
expiredError
	^ 'La tarjeta expiro'! !

!Card class methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 12:49:53'!
invalidCard
	^ 'Tarjeta invalida' ! !

!Card class methodsFor: 'as yet unclassified' stamp: 'kf 6/22/2017 19:22:26'!
invalidName
	^ 'Nombre invalido'! !

!Card class methodsFor: 'as yet unclassified' stamp: 'kf 6/22/2017 19:26:36'!
invalidNumber
	^ 'invalid number'! !

!Card class methodsFor: 'as yet unclassified' stamp: 'kf 6/22/2017 19:31:21'!
withNumber: cardNumber withName: cardHolder withExpirationDate: monthYear 
	
	self assert: (cardHolder isEmpty) not description: [self error: (Card invalidName) ].
	self assert: (cardNumber decimalDigitLength  = 12) description: [self error: (Card invalidNumber )].
	^self new withNumber: cardNumber withName: cardHolder withExpirationDate: monthYear ! !

!Card class methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 12:50:30'!
withoutBalance
	^ 'Sin Saldo'! !


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
	instanceVariableNames: 'cart card book'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 12:59:19'!
checkOutOnDate: aDate withMerchant: aMerchantProcesor
	
	|cost|
	
	self assert: (card isExpiredOn: aDate) not description: [self error: Card expiredError ].
	
	cost := self cost.
	
	self debit: aMerchantProcesor withAmount: cost.
		
	book add: cart.
	
	^ cost! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 11:44:02'!
cost
	|catalog cost|
	
	cart isEmpty  ifTrue: [	self error: 'No me pases un cart vacio'.].

	catalog := cart catalog.
	cost := 0.
	(catalog contents) do:[:element | 
								cost := cost + (catalog cost: element)
							 ].

	^ cost.
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 12:48:12'!
debit: aMerchantProcesor withAmount: amountToDebit

	 aMerchantProcesor debit: amountToDebit withCard: card 
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 11:46:55'!
withCart: aCart withCard: aCard withBook: aBook 
	cart := aCart.
	card := aCard.
	book := aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TuLibro!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'class initialization' stamp: 'kf 6/18/2017 11:39:26'!
withCart: aCart withCard: aCard withBook: anUndefinedObject 
	^ self new withCart: aCart withCard: aCard withBook: anUndefinedObject ! !


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


!classDefinition: #MerchantProcesorMock category: #TuLibro!
Object subclass: #MerchantProcesorMock
	instanceVariableNames: 'card today amount outService'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!MerchantProcesorMock methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 16:48:37'!
addValidCard: aCard
	card := aCard.
	amount := 1000000000000.! !

!MerchantProcesorMock methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 16:48:34'!
addValidCard: aCard withAmount: anAmount 
	card := aCard .
	amount := anAmount.! !

!MerchantProcesorMock methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 13:05:47'!
debit: amountToDebit withCard: aCard 

	self assert: (outService not) description: [self error: MerchantProcesorMock 	outService ].

	self assert: (aCard isExpiredOn: today) not description: [ self error:  Card expiredError ].

	self assert: (card = aCard) description: [self error: Card invalidCard.].
	
	self assert: (amountToDebit < amount) description: [self error: Card withoutBalance] .
	
	
	^ true.
! !

!MerchantProcesorMock methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 13:04:15'!
putOutService
	outService := true.! !

!MerchantProcesorMock methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 16:48:44'!
withDate: aDate 
	today := aDate.
	outService  := false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcesorMock class' category: #TuLibro!
MerchantProcesorMock class
	instanceVariableNames: ''!

!MerchantProcesorMock class methodsFor: 'class initialization' stamp: 'kf 6/18/2017 11:17:35'!
withDate: aDate 
	^ self new withDate: aDate.! !


!MerchantProcesorMock class methodsFor: 'as yet unclassified' stamp: 'kf 6/18/2017 13:03:33'!
outService
	^ 'Sin servicio'! !
