!classDefinition: #TuLibroTests category: #TuLibro!
TestCase subclass: #TuLibroTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 19:41:55'!
test01
	|aCart|
	
	aCart := Cart new.
	self assert: aCart isEmpty.! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 19:53:23'!
test02
	|aCart|
	
	aCart := Cart new.
	aCart add: 1.
	self deny: aCart isEmpty.! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 19:57:23'!
test03
	|aCart|
	
	aCart := Cart new.
	aCart add: 1.
	self assert: aCart elements = 1! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 19:58:38'!
test04
	|aCart|
	
	aCart := Cart new.
	aCart add: 1.
	aCart add: 2.
	self assert: aCart elements = 2! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:04:29'!
test05
	|aCart|
	
	aCart := Cart new.
	aCart add: 1 quantity: 2.
	aCart add: 2.
	self assert: aCart elements = 3! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:27:35'!
test06
	|aCart|
	
	aCart := Cart new.
	aCart add: 1 quantity: 2.
	self assert: (aCart contents: 1)! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:28:03'!
test07
	|aCart|
	
	aCart := Cart new.
	aCart add: 1 quantity: 2.
	self deny: (aCart contents: 2)! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:28:56'!
test08
	|aCart|
	
	aCart := Cart new.
	aCart add: 1 quantity: 2.
	self assert: (aCart quantityOf: 1 ) = 2! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:29:30'!
test09
	|aCart|
	
	aCart := Cart new.
	aCart add: 1 quantity: 1.
	self assert: (aCart quantityOf: 1 ) = 1! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:34:16'!
test10
	|aCart|
	
	aCart := Cart new.
	aCart add: 1 quantity: 1.

	self
		should: [aCart quantityOf: 2]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Elemento no presente']! !

!TuLibroTests methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:35:48'!
test11
	|aCart|
	
	aCart := Cart new.
	aCart add: 1 quantity: 1.

	self
		should: [aCart contents: 2]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Elemento no presente']! !


!classDefinition: #Cart category: #TuLibro!
Object subclass: #Cart
	instanceVariableNames: 'element elements elementsQuantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TuLibro'!

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:21:40'!
add: anElement
	self add: anElement quantity: 1.
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:19:29'!
add: anElement quantity: aQuantity 
	elements addLast: anElement.
	elementsQuantity addLast:aQuantity! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:37:21'!
contents: anElement
	|select|
	select := elements select: [:element| anElement  = element ].
	
	(select size = 0) ifTrue: [self error: 'Elemento no presente'].
	
	^ true
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:21:08'!
elements
	|total|
	total := 0.
	elementsQuantity do: [:element | total := total + element].
	^ total.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:19:50'!
initialize
	elements := OrderedCollection new.
	elementsQuantity := OrderedCollection new.	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 19:59:44'!
isEmpty
	^ elements isEmpty .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'kf 6/11/2017 23:35:33'!
quantityOf: anElement
	1 to: elements size do: [:position | ((elements at: position)  = anElement) ifTrue: [^ elementsQuantity at: position ]].
	self error: 'Elemento no presente'! !
