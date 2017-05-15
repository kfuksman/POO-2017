!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'private' stamp: 'kf 5/15/2017 20:11:10'!
assertBounds: aLiveCells with: aPoint 

	self 
		should: [ GameOfLife withLiveCells: aLiveCells withSize: aPoint]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = GameOfLife cellOutOfRange ]! !

!GOLTest methodsFor: 'private' stamp: 'kf 5/15/2017 20:03:55'!
assertDead: aPoint in: aGameOfLife 

	self assert:(aGameOfLife isDeadAt: aPoint) ! !

!GOLTest methodsFor: 'private' stamp: 'kf 5/15/2017 20:05:06'!
assertLive: aPoint in: gameOfLife

	self deny: (gameOfLife isDeadAt: aPoint) ! !

!GOLTest methodsFor: 'private' stamp: 'kf 5/15/2017 20:52:33'!
initializateAndDoNextGenerationwithLiveCells: aLiveCells withSize: aPoint 
	
	|gameOfLife|
	
	gameOfLife := GameOfLife withLiveCells: aLiveCells withSize: aPoint.
	gameOfLife nextGeneration.
	
	^ gameOfLife
	! !


!GOLTest methodsFor: 'tests' stamp: 'kf 5/15/2017 20:53:07'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := self initializateAndDoNextGenerationwithLiveCells: { 1@1. } withSize: 3@3.
	
	self assertDead: 1@1 in: gameOfLife! !

!GOLTest methodsFor: 'tests' stamp: 'kf 5/15/2017 20:53:27'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := self initializateAndDoNextGenerationwithLiveCells: { 1@1. 2@0. 1@0. } withSize: 3@3.
	
	self assertLive: 1@1 in: gameOfLife! !

!GOLTest methodsFor: 'tests' stamp: 'kf 5/15/2017 20:53:58'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := self initializateAndDoNextGenerationwithLiveCells: { 1@1. 2@0. 1@0. 1@2. } withSize: 3@3.
	
	self assertLive: 1@1 in: gameOfLife! !

!GOLTest methodsFor: 'tests' stamp: 'kf 5/15/2017 20:51:44'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := self initializateAndDoNextGenerationwithLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.

	self assertDead: 1@1 in: gameOfLife.! !

!GOLTest methodsFor: 'tests' stamp: 'kf 5/15/2017 20:52:22'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife |
	
	gameOfLife := self initializateAndDoNextGenerationwithLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	
	self assertLive: 1@1 in: gameOfLife.! !

!GOLTest methodsFor: 'tests' stamp: 'kf 5/15/2017 20:12:24'!
test06CreateCellOutsideBoundsXNegative

	self assertBounds: {2@0. 1@0. -1@4} with: 3@3.! !

!GOLTest methodsFor: 'tests' stamp: 'kf 5/15/2017 20:12:51'!
test07CreateCellOutsideBoundsXPositive
		
	self assertBounds: { 2@0. 1@0. 4@1 }  with: 3@3.! !

!GOLTest methodsFor: 'tests' stamp: 'kf 5/15/2017 20:13:17'!
test08CreateCellOutsideBoundsYPositive

	self assertBounds: { 2@0. 1@0. 1@4 }  with: 3@3.! !

!GOLTest methodsFor: 'tests' stamp: 'kf 5/15/2017 20:13:29'!
test09CreateCellOutsideBoundsYNegative

	self assertBounds: { 2@0. 1@0. 1@-1 }  with: 3@3.! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'private' stamp: 'kf 5/15/2017 20:41:02'!
deadCells
	
	| deadCells |
	
	deadCells _ OrderedCollection new.
	0 to: size x do: [ :x |
		0 to: size y do: [ :y | deadCells add: x@y]].
		aliveCells do: [:aCell | deadCells remove: aCell].
		^deadCells 
	! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/11/2017 21:11:17'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/11/2017 19:57:05'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]! !

!GameOfLife methodsFor: 'private' stamp: 'kf 5/15/2017 19:41:52'!
initializeWith: aCollectionOfAliveCells withSize: aSize

	size := aSize.
	aliveCells := aCollectionOfAliveCells.
	! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/10/2017 10:28:24'!
isDeadAt: aCell

	^(aliveCells includes: aCell) not! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !


!GameOfLife methodsFor: 'accessing' stamp: 'kf 5/15/2017 20:37:10'!
nextGeneration
	
	aliveCells := (aliveCells select: [ :aCell | self hasToSurvive: aCell ]) union:
		(self deadCells select: [ :aDeadCell | self hasToResurrect: aDeadCell ])! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'kf 5/15/2017 19:50:55'!
cellOutOfRange
	^ 'Cell out of range'! !

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'kf 5/15/2017 19:52:15'!
withLiveCells: aCollectionOfAliveCells withSize: aPoint 

		(aCollectionOfAliveCells allSatisfy: [:aCell |
		(aCell x between: 0 and: aPoint x) and: [ aCell y between: 0 and: aPoint y]]) ifFalse: [ self error: self cellOutOfRange ].
	
	^self new initializeWith: aCollectionOfAliveCells withSize: aPoint ! !
