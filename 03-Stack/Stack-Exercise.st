!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #ComponentStack category: #'Stack-Exercise'!
Object subclass: #ComponentStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ComponentStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:08:28'!
isEmptyStack

	self subclassResponsibility! !

!ComponentStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:08:40'!
popStack

	self subclassResponsibility! !

!ComponentStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:09:23'!
pushStack: anOOStack  with: anObject  

	self subclassResponsibility! !

!ComponentStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:08:37'!
topStack

	self subclassResponsibility! !


!classDefinition: #BaseStack category: #'Stack-Exercise'!
ComponentStack subclass: #BaseStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:00:43'!
isEmptyStack
	^true! !

!BaseStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 08:57:11'!
popStack: anOOStack 
	self error: OOStack stackEmptyErrorDescription ! !

!BaseStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:02:16'!
pushStack: anOOStack  with: anObject  
	
	ElementStack new initializeFor: anObject on: anOOStack with: self! !

!BaseStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:02:26'!
topStack
	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #ElementStack category: #'Stack-Exercise'!
ComponentStack subclass: #ElementStack
	instanceVariableNames: 'value previousElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:06:58'!
initializeFor: anObject on: anOOStack with: anElementDown 
	
	value := anObject.
	anOOStack topStack: self.
	anOOStack increaseSize.
	previousElement := anElementDown.! !

!ElementStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:00:26'!
isEmptyStack
	^false! !

!ElementStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:07:10'!
popStack: anOOStack 
	
	anOOStack topStack: previousElement.
	anOOStack decreaseSize.
	^ value! !

!ElementStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:01:25'!
pushStack: anOOStack  with: anObject  
	
	ElementStack new initializeFor: anObject on: anOOStack with: self! !

!ElementStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:02:35'!
topStack
	^value! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topStack size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 08:46:05'!
decreaseSize
	size := size - 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 08:45:09'!
increaseSize
	size := size +1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 08:43:48'!
initialize
	topStack := BaseStack new.
	size := 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:00:38'!
isEmpty

	^topStack isEmptyStack! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 08:39:34'!
pop
	^topStack popStack:self! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:01:46'!
push: anElement
	topStack pushStack: self with: anElement! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 08:43:32'!
size 
	^ size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 09:04:10'!
top
	^topStack topStack! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'kf 5/5/2017 08:36:04'!
topStack: anElementStack 
	topStack := anElementStack! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !
