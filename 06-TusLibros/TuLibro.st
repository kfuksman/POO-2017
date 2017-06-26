!classDefinition: #TuLibroTests category: #TuLibro!
TestCase subclass: #TuLibroTests
	instanceVariableNames: 'aCart catalogWithElements emptyCatalog cartWithEmptyCatalog cashier cartWithElements aValidCard anInvalidCard anInvoice anExpiredCard merchant aBook rest dataLogin merchantRest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!TuLibroTests methodsFor: 'rest' stamp: 'kf 6/25/2017 11:37:47'!
testR01

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	self assert: (rest listCart: idCart ) isEmpty 
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'kf 6/25/2017 11:38:12'!
testR02
	
	self should: [rest createCartWithClientId: 2 password: 1.] 
			raise: Error 
		 withExceptionDo: [:anError |
					anError messageText = RestMock invalidUser.
					self toDo: 'falta chequear que no se cree el carrito sin romper encapsulamiento'.
			].
	
	
	
	

	! !

!TuLibroTests methodsFor: 'rest' stamp: 'kf 6/25/2017 11:38:49'!
testR03
	

	self should: [rest createCartWithClientId: 1 password: 2.] 
			raise: Error 
		 withExceptionDo: [:anError |
					anError messageText = RestMock invalidUser.
					self toDo: 'falta chequear que no se cree el carrito sin romper encapsulamiento'.
			].
	
	
	
	

	! !

!TuLibroTests methodsFor: 'rest' stamp: 'kf 6/25/2017 11:38:59'!
testR04

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest addToCard: idCart isbn: 1 withQuantity: 1.
	
	self assert: ((rest listCart: idCart ) contents: 1).
	self assert: (rest listCart: idCart ) elements  = 1.
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'kf 6/25/2017 11:39:06'!
testR05

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	self should: [rest addToCard: idCart isbn: 0 withQuantity: 1.]  
		raise:  Error
	 withExceptionDo: [:anError | 
				anError messageText  = Cart invalidISBN.
					self assert: (rest listCart: idCart ) elements  = 0.
		].
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'kf 6/25/2017 11:40:45'!
testR06

	| idCart  |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	self should: [rest addToCard: idCart isbn: 10 withQuantity: 1.]  
		raise:  Error
	 withExceptionDo: [:anError | 
				self assert: (anError messageText  = 'No pertenece al catalogo').
					self assert: (rest listCart: idCart ) elements  = 0.
		].
	! !

!TuLibroTests methodsFor: 'rest' stamp: 'kf 6/25/2017 12:40:49'!
testR07

	| idCart  bag |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest addToCard: idCart isbn: 1 withQuantity: 1.
	
	bag:= Bag new.
	bag add:1.
	
	anInvoice := Invoice withElements: bag.

	self assert: (rest checkout: idCart withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin') = 1 .
	self assert: (rest checkout: idCart withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin') = 2	.! !

!TuLibroTests methodsFor: 'rest' stamp: 'kf 6/25/2017 12:49:04'!
testR08

	| idCart  bag |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest addToCard: idCart isbn: 1 withQuantity: 1.
	
	bag:= Bag new.
	bag add:1.
	
	anInvoice := Invoice withElements: bag.
	
	self should: [rest checkout: idCart withNumberCard: 12345679301 withExpirationDate: Date today withNameHolder: 'kevin'] 
				raise: Error  
				withExceptionDo: [:anError | 
					self assert: (rest transactions isEmpty).
					].
				
	self should: [rest checkout: idCart withNumberCard: 12345679301 withExpirationDate: (Date - 60 days) today withNameHolder: 'kevin'] 
				raise: Error  
				withExceptionDo: [:anError | 
					self assert: (rest transactions isEmpty).
					].
				
	self should: [rest checkout: idCart withNumberCard: 12345679301 withExpirationDate: (Date today) withNameHolder: ''] 
				raise: Error  
				withExceptionDo: [:anError | 
					self assert: (rest transactions isEmpty).
					].! !

!TuLibroTests methodsFor: 'rest' stamp: 'kf 6/25/2017 12:50:20'!
testR09

	| idCart  bag |
	
	idCart := rest createCartWithClientId: 1 password: 1.
	
	rest addToCard: idCart isbn: 1 withQuantity: 1000.
	
	bag:= Bag new.
	bag add:1.
	
	anInvoice := Invoice withElements: bag.
	
	self should: [rest checkout: idCart withNumberCard: 123456789301 withExpirationDate: Date today withNameHolder: 'kevin'] 
				raise: Error  
				withExceptionDo: [:anError | 
					self assert: (rest transactions isEmpty).
					].
			! !

!TuLibroTests methodsFor: 'rest' stamp: 'KF 6/25/2017 21:08:22'!
testR10
	
	self should: [rest listCart: 1 ] 
			raise: Error 
		 withExceptionDo: [:anError |
					self assert: anError messageText = RestMock invalidCart.
			].
	
	
	
	

	! !


!TuLibroTests methodsFor: 'card' stamp: 'kf 6/25/2017 09:19:15'!
test13AValidCardIsNotExpired

	
	self deny: ((Card withNumber: 123456789913 withName: 'kevin' withExpirationDate: (Date today + 1 days)) isExpiredOn: Date today)
! !

!TuLibroTests methodsFor: 'card' stamp: 'kf 6/25/2017 09:19:31'!
test14AValidCardWithAYearDifferenceIsNotExpired

	
	
	self deny: ((Card withNumber: 123456789913  withName: 'kevin' withExpirationDate: (Date today + 380 days))  isExpiredOn: Date today)
 

! !

!TuLibroTests methodsFor: 'card' stamp: 'kf 6/25/2017 09:19:36'!
test15AnInvalidCardWithAYearDifferenceIsExpired

	self assert: ((Card withNumber: 123456789913  withName: 'kevin' withExpirationDate: (Date today - 367 days))  isExpiredOn: Date today)
! !

!TuLibroTests methodsFor: 'card' stamp: 'kf 6/25/2017 09:19:40'!
test16AnInvalidCardWithAMonthDifferenceIsExpired
	 
	self assert: ((Card withNumber: 123456789913  withName: 'kevin' withExpirationDate: (Date today - 32 days)) isExpiredOn: Date today).
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

!TuLibroTests methodsFor: 'cashier' stamp: 'kf 6/25/2017 12:16:42'!
testCa01
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) elements = anInvoice elements! !

!TuLibroTests methodsFor: 'cashier' stamp: 'kf 6/25/2017 12:21:48'!
testCa02
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) total = anInvoice total! !

!TuLibroTests methodsFor: 'cashier' stamp: 'kf 6/25/2017 12:22:34'!
testCa03
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self deny: (cashier checkOutOnDate: Date today withMerchant: merchant ) total = 1! !

!TuLibroTests methodsFor: 'cashier' stamp: 'kf 6/25/2017 12:29:08'!
testca04
	
	merchant addValidCard: aValidCard.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) = anInvoice.
	self deny: aBook isEmpty.
	self assert: (aBook includes: anInvoice).! !

!TuLibroTests methodsFor: 'cashier' stamp: 'KF 6/25/2017 21:00:02'!
testca05
	
	merchant addValidCard: aValidCard.
	
	cartWithElements := Cart withCatalog: catalogWithElements .
	cartWithElements add: 1 quantity: 100.
	
	anInvoice := Invoice withElements: (cartWithElements products ) withTotal: 100.
	
	cashier := self cashierWithCart: cartWithElements withCard: aValidCard withBook: aBook.
	
	self assert: (cashier checkOutOnDate: Date today withMerchant: merchant ) = anInvoice.
	self deny: aBook isEmpty.
	self assert: (aBook includes: anInvoice).! !

!TuLibroTests methodsFor: 'cashier' stamp: 'KF 6/25/2017 21:04:59'!
testca06
	
	merchant addValidCard: aValidCard withAmount: 50.
	
	cartWithElements := Cart withCatalog: catalogWithElements .
	cartWithElements add: 1 quantity: 100.
	
	
	
	self should: [cashier checkOutOnDate: Date today withMerchant: merchant ] 
		raise: Error withExceptionDo: [:anError | 
				self assert: aBook isEmpty.
			]
	
! !


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

!TuLibroTests methodsFor: 'setUp' stamp: 'kf 6/25/2017 12:24:20'!
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
		
	anInvoice := Invoice withElements: (cartWithElements products ) withTotal: 2.
	
	merchant :=MerchantProcesorMock withDate: Date today.

	aBook := OrderedCollection new.
	
	dataLogin := Dictionary new.
	dataLogin at: 1 put:1.
	
	merchantRest :=MerchantProcesorMock withDate: Date today.
	merchantRest addValidCard:  (Card withNumber: 123456789301  withName: 'kevin' withExpirationDate: (Date today)) withAmount: 	100.
	rest := RestMock withCatalog: catalogWithElements withDataLogin: dataLogin withTime: (Date today) withMerchant: merchantRest withBook: aBook.! !


!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 11:10:59'!
toDo: aString 
! !


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

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 11:33:41'!
add: anElement quantity: aQuantity 
	self assert: aQuantity isInteger description: [self error: 'Invalid isbn'].
	self assert:  aQuantity  > 0 description: [self error: 'Invalid isbn'].
	
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

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:11:37'!
products 
	^ elements! !

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


!Cart class methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 11:35:02'!
invalidISBN
	^ 'invalid isbn'! !


!classDefinition: #Cashier category: #TuLibro!
Object subclass: #Cashier
	instanceVariableNames: 'cart card book'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:30:35'!
checkOutOnDate: aDate withMerchant: aMerchantProcesor
	
	|cost invoice |
	
	self assert: (card isExpiredOn: aDate) not description: [self error: Card expiredError ].
	
	cost := self cost.
	
	self debit: aMerchantProcesor withAmount: cost.	
	invoice := Invoice withElements: cart products withTotal: cost.
	book add: invoice.
	
	^ invoice! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'KF 6/25/2017 21:01:00'!
cost
	|catalog cost|
	
	cart isEmpty  ifTrue: [	self error: 'No me pases un cart vacio'.].

	catalog := cart catalog.
	cost := 0.
	(cart products) do:[:element | 
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
	instanceVariableNames: 'elements total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Invoice methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:17:36'!
= anInvoice

	^ elements  = anInvoice elements .! !

!Invoice methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:14:18'!
elements
	^ elements ! !

!Invoice methodsFor: 'as yet unclassified' stamp: 'kf 6/15/2017 19:38:05'!
isInvoice
	^ true.! !

!Invoice methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:22:00'!
total
	^ total! !

!Invoice methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:14:04'!
withElements: aBag 
	elements := aBag .! !

!Invoice methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:23:43'!
withElements: aBag withTotal: aTotal 
	elements := aBag.
	total := aTotal .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Invoice class' category: #TuLibro!
Invoice class
	instanceVariableNames: 'elements'!

!Invoice class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 12:13:38'!
withElements: aBag 
	^ self new withElements: aBag .! !

!Invoice class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 12:23:18'!
withElements: aBag withTotal: aTotal
	^ self new withElements: aBag withTotal: aTotal! !


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


!classDefinition: #RestMock category: #TuLibro!
Object subclass: #RestMock
	instanceVariableNames: 'catalog carts dataLogin time book merchant transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!RestMock methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 11:30:48'!
addToCard: cartId isbn: isbn withQuantity: aQuantity 
	
	| cart |
	cart:= self listCart: cartId.
	cart add: isbn quantity: aQuantity .
	^ true.! !

!RestMock methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:39:53'!
checkout: cartId withNumberCard: numberCard withExpirationDate: anExpirationDate withNameHolder: aNameHolder

	| aCart aCashier aCard |
	
	aCard := Card withNumber:  numberCard withName: aNameHolder withExpirationDate: anExpirationDate .
	
	aCart := self listCart: cartId.
	
	aCashier := Cashier withCart: aCart withCard: aCard withBook: book .
	
	transactions add: (aCashier checkOutOnDate: time withMerchant: merchant).
	
	^ transactions size.
! !

!RestMock methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 11:13:16'!
createCartWithClientId: clientId password: password 

	self assert: (dataLogin at: clientId  ifAbsent: [self error: RestMock invalidUser ]) = password description: [self error: RestMock invalidUser].
	
	carts addLast: (Cart withCatalog: catalog).
	^ carts size.! !

!RestMock methodsFor: 'as yet unclassified' stamp: 'KF 6/25/2017 23:49:46'!
listCart: idCart
	[ ^carts at: idCart .] on: Error do: [self error: RestMock invalidCart ].! !

!RestMock methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:42:31'!
transactions
	^ transactions ! !

!RestMock methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 12:40:15'!
withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate withMerchant: aMerchantProcesorMock withBook: aBook 
	catalog := aCatalog.
	dataLogin := aDictionary.
	carts  := OrderedCollection new.
	time := aDate.
	merchant := aMerchantProcesorMock.
	book  := aBook .
	transactions := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestMock class' category: #TuLibro!
RestMock class
	instanceVariableNames: ''!

!RestMock class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 10:52:05'!
withCatalog: aCatalog 
	^ self new withCatalog: aCatalog .! !

!RestMock class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 11:02:03'!
withCatalog: aCatalog withDataLogin: aDictionary 
	^self new withCatalog: aCatalog withDataLogin: aDictionary.! !

!RestMock class methodsFor: 'class initialization' stamp: 'kf 6/25/2017 11:41:42'!
withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate 
	^ self new withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate ! !


!RestMock class methodsFor: 'as yet unclassified' stamp: 'KF 6/25/2017 21:08:06'!
invalidCart
	^ 'invalid cart'! !

!RestMock class methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 11:08:03'!
invalidUser
	^ 'Invalid user/password'! !

!RestMock class methodsFor: 'as yet unclassified' stamp: 'kf 6/25/2017 11:57:49'!
withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate withMerchant: aMerchantProcesorMock withBook: anOrderedCollection 
	^ self new withCatalog: aCatalog withDataLogin: aDictionary withTime: aDate withMerchant: aMerchantProcesorMock withBook: anOrderedCollection ! !
