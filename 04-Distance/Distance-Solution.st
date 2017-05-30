!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro milQuinientosCentimetros quinientosCentimetros dosMetros otroMetro cienCentimetros cincoCentimetros tresMetros unKilometro dosKilometro tresKilometro minusMeter ceroMetros minusFiveCentimeter oneCentimeter twoHundredCentimeters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/29/2017 20:46:24'!
aatest19IntervaleMethodActsInAgreementWithHisStartAndEnd

	| collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	unMetro to: dosMetros  do: [:aDistance |  collection add: (aDistance + unMetro)].
	dosMetros to: tresMetros  do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/30/2017 00:49:04'!
setUp
		minusMeter  :=  Distance size: -1 in: Unit meter.
		minusFiveCentimeter := Distance size: -5 in: Unit centimeter.
		ceroMetros  :=  Distance size: 0 in: Unit meter.
		unMetro :=  Distance size: 1 in: Unit meter.
		otroMetro :=  Distance size: 1 in:  Unit meter.
		dosMetros :=  Distance size: 2 in: Unit meter.
		tresMetros :=  Distance size: 3 in: Unit meter.
		cienCentimetros := Distance size: 100 in: Unit centimeter.
		cincoCentimetros := Distance size: 5 in: Unit centimeter.
		unKilometro := Distance size: 1 in: Unit kilometer.
		dosKilometro := Distance size: 2 in: Unit kilometer.
		tresKilometro := Distance size: 3 in: Unit kilometer.
		oneCentimeter := Distance size: 1 in: Unit centimeter .
		twoHundredCentimeters := Distance size: 200 in: Unit centimeter.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:13:26'!
test01AnInstanceIsEqualToSelf
	self assert: unMetro = unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:13:01'!
test02TwoInstancesWithSameDistanceAreEqual
	self assert: unMetro = otroMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:12:42'!
test03DifferentDistancesAreNotEqual

	self deny: unMetro = dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:16:00'!
test04SumOfTwoDistancesIsEqualToAnotherDistance

	self assert: unMetro + unMetro = dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:15:53'!
test05SubstractionOfTwoDistancesIsEqualToAnotherDistance

	self assert: dosMetros - unMetro = unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:16:45'!
test06SumWithNegativeDistancePerformWell

	self assert: unMetro + minusMeter = ceroMetros 
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:20:24'!
test07MultiplicationWithIntegerIsEqualToAnotherDistance

	self assert: unMetro * 2 = dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:20:55'!
test08MultiplicationIsCommutativeWithDistance

	self assert:  2 * unMetro = dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:21:19'!
test09DivisionWithIntegerIsEqualToAnotherDistance

	self assert:  dosMetros / 2 = unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:22:59'!
test10ADistanceCanBeBiggerThanAnotherDistance

	self assert: dosMetros > unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:24:48'!
test11ASmallDistanceCantBeBiggerThanABigDistance

	self deny: unMetro > dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:23:52'!
test12ADistanceCanBeBiggerOrEqualThanAnotherDistance

	self assert: unMetro >= unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:25:12'!
test13ADistanceCanBeSmallerThanAnotherDistance

	self assert:  unMetro < dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:25:33'!
test14ADistanceCanBeSmallerOrEqualThanAnotherDistance

	self assert:  unMetro <= unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:26:39'!
test15AnIntervalSizeInMeterIsEqualToTheDistanceBetweenHisDistances

	self assert: (unMetro to: tresMetros) size = 3
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/26/2017 13:27:12'!
test16AnIntervalSizeWithAnotherStepIsEqualToTheDistanceBetweenHisDistances

	self assert: ( unMetro to: dosMetros by: cincoCentimetros) size = 21
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/29/2017 21:50:45'!
test17IntervaleActsInAgreementWithHisStartAndEndDistances

	| collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	(unMetro to: dosMetros by: cincoCentimetros) do: [:aDistance |  collection add: aDistance + unMetro].
	(dosMetros to: tresMetros by: cincoCentimetros)  do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2017 12:49:00'!
test18IntervalesWithStepActsInAgreementWithTheirStartAndEnd

	| collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	unMetro to: dosMetros  by: cincoCentimetros do: [:aDistance |  collection add: (aDistance + unMetro)].
	dosMetros to: tresMetros   by: cincoCentimetros do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/29/2017 21:51:59'!
test19IntervaleMethodActsInAgreementWithHisStartAndEnd

	| collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	(unMetro to: dosMetros) do: [:aDistance |  collection add: (aDistance + unMetro)].
	(dosMetros to: tresMetros)  do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2017 12:54:59'!
test20IntervaleWithNegativeDistanceAndStepWorksCorrectly

	| collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	(unMetro to: minusMeter by: minusFiveCentimeter) do: [:aDistance |  collection add: (aDistance + unMetro)].
	(dosMetros to: ceroMetros by: minusFiveCentimeter) do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2017 13:08:47'!
test21DistanceAndStepMustHaveTheSameMathematicSign

	| collection |
	collection := OrderedCollection new.
	self
		should: [unMetro to: dosMetros by: minusFiveCentimeter do: [:aDistance |  collection add: aDistance].]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = DistanceInterval stepInADifferentWayError]! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2017 13:08:16'!
test22StepCantBeZeroMeter
	| collection |
	collection := OrderedCollection new.
	self
		should: [dosMetros to: unMetro by: ceroMetros do: [:aDistance |  collection add: aDistance].]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = DistanceInterval zeroStepError]! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2017 13:07:29'!
test23DistanceFactoryCreateInstancesCorrectly

	|distanceFactory|
	
	distanceFactory := DistanceFactory new.
	
	self assert: distanceFactory minusOneMeter = minusMeter.
	self assert: distanceFactory oneCentimeter = oneCentimeter.
	self assert: distanceFactory oneHundredCentimeters = cienCentimetros.
	self assert: distanceFactory oneMeter = unMetro .	
	self assert: distanceFactory twoHundredCentimeters = twoHundredCentimeters.
	self assert: distanceFactory twoMeters = dosMetros .
	self assert: distanceFactory zeroMeters = ceroMetros .
! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'comparing' stamp: 'kf 5/23/2017 20:55:36'!
< aDistance 
	^ value < aDistance valueMeter! !

!Distance methodsFor: 'comparing' stamp: 'RB 5/30/2017 00:50:17'!
<= aDistance 
	^ (self > aDistance) not! !

!Distance methodsFor: 'comparing' stamp: 'kf 5/29/2017 20:47:43'!
= aDistance
	^ value = aDistance valueMeter! !

!Distance methodsFor: 'comparing' stamp: 'RB 5/30/2017 00:53:11'!
> aDistance 
	^ value > aDistance valueMeter! !

!Distance methodsFor: 'comparing' stamp: 'RB 5/30/2017 00:51:09'!
>= aDistance 
	^ (self < aDistance) not! !


!Distance methodsFor: 'initialization' stamp: 'RB 5/30/2017 00:48:09'!
size: aNumber in: anUnit 
	value := aNumber * anUnit scale! !


!Distance methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:21:23'!
valueMeter
	^ value! !


!Distance methodsFor: 'converting' stamp: 'RB 5/30/2017 00:48:33'!
adaptToNumber: rcvr andSend: selector 

		^ self class new size: (rcvr  perform: selector with: value) in: (Unit meterScale: 1)! !


!Distance methodsFor: 'intervals' stamp: 'kf 5/25/2017 18:12:04'!
to: aDistance 
	^ DistanceInterval from: self to: aDistance! !

!Distance methodsFor: 'intervals' stamp: 'kf 5/25/2017 18:19:33'!
to: aDistance by: aDistance2 
	^ DistanceInterval from: self to: aDistance  by: aDistance2! !

!Distance methodsFor: 'intervals' stamp: 'kf 5/29/2017 20:46:10'!
to: aDistance by: aDistance2 do: aBlockClosure 
	(self to: aDistance by: aDistance2) do: aBlockClosure ! !

!Distance methodsFor: 'intervals' stamp: 'kf 5/29/2017 20:47:34'!
to: aDistance do: aBlockClosure 
	(self to: aDistance) do: aBlockClosure ! !


!Distance methodsFor: 'arithmetic' stamp: 'RB 5/30/2017 00:48:18'!
* anInteger 
	^ self class size: value * anInteger  in: (Unit meterScale: 1)! !

!Distance methodsFor: 'arithmetic' stamp: 'RB 5/30/2017 00:48:23'!
+ aDistance 
	^ self class size: value + aDistance valueMeter in: (Unit meterScale: 1)! !

!Distance methodsFor: 'arithmetic' stamp: 'RB 5/30/2017 00:48:28'!
- aDistance 
	^ self class size: value - aDistance valueMeter in: (Unit meterScale: 1)! !

!Distance methodsFor: 'arithmetic' stamp: 'RB 5/30/2017 00:48:30'!
/ anInteger 
	^ self class size: value / anInteger  in: (Unit meterScale: 1)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'instance creation' stamp: 'RB 5/30/2017 00:49:18'!
size: anInteger in: anUnit 
	^ self new size: anInteger in: anUnit! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:23:34'!
minusOneMeter
	^ self createMeter: -1! !

!DistanceFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:24:30'!
oneCentimeter
	^ self createCentimeter: 1.! !

!DistanceFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:25:30'!
oneHundredCentimeters
	^ self createCentimeter: 100.! !

!DistanceFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:25:42'!
oneMeter
	^ self createMeter: 1! !

!DistanceFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:25:57'!
twoHundredCentimeters
	^ self createCentimeter: 200! !

!DistanceFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:26:14'!
twoMeters
	^ self createMeter: 2! !

!DistanceFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:26:29'!
zeroMeters
	^ self createMeter: 0.! !


!DistanceFactory methodsFor: 'private' stamp: 'RB 5/30/2017 00:48:42'!
createCentimeter: anInteger
	^ Distance size: anInteger in: Unit  centimeter.
	! !

!DistanceFactory methodsFor: 'private' stamp: 'RB 5/30/2017 00:48:44'!
createMeter: anInteger
	^ Distance size: anInteger  in: Unit meter.
	! !


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
Object subclass: #DistanceInterval
	instanceVariableNames: 'interval'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'initialization' stamp: 'RB 5/28/2017 03:39:59'!
from: startDistance to: finishDistance
	interval := Interval from: startDistance valueMeter to: finishDistance valueMeter! !

!DistanceInterval methodsFor: 'initialization' stamp: 'kf 5/25/2017 20:07:08'!
from: startDistance to: finishDistance by: intervalDistance
	interval := Interval from: startDistance valueMeter to: finishDistance valueMeter by: intervalDistance valueMeter ! !


!DistanceInterval methodsFor: 'accessing' stamp: 'RB 5/30/2017 00:48:47'!
at: position
	^ Distance size: (interval at: position) in: (Unit meter)! !

!DistanceInterval methodsFor: 'accessing' stamp: 'kf 5/25/2017 18:23:19'!
do: aBlock

	1 to: interval size do: [ :i |
		aBlock value: (self at: i) ]		! !

!DistanceInterval methodsFor: 'accessing' stamp: 'kf 5/25/2017 18:17:16'!
size
	^ interval size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'instance creation' stamp: 'RB 5/28/2017 03:38:05'!
from: startDistance to: finishDistance
	^ self new from: startDistance to: finishDistance! !

!DistanceInterval class methodsFor: 'instance creation' stamp: 'RB 5/28/2017 13:07:16'!
from: startDistance to: finishDistance by: intervalDistance
	self assert: [intervalDistance valueMeter ~~ 0] description: [self error: self zeroStepError].
	
	self assert: [(intervalDistance valueMeter > 0) ==((finishDistance valueMeter - startDistance valueMeter) > 0)] description: [self error: self stepInADifferentWayError].
	
	^ self new from: startDistance to: finishDistance by: intervalDistance! !


!DistanceInterval class methodsFor: 'exceptions' stamp: 'RB 5/28/2017 13:02:55'!
stepInADifferentWayError	
	^ 'Step and distance has to go the same way'! !

!DistanceInterval class methodsFor: 'exceptions' stamp: 'RB 5/28/2017 13:07:03'!
zeroStepError	
	^ 'Step cant be a zero distance'! !


!classDefinition: #Unit category: #'Distance-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'value scale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Unit methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:26:49'!
scale
	^ scale! !


!Unit methodsFor: 'initialization' stamp: 'kf 5/23/2017 20:35:02'!
withScale: anInteger 
	scale := anInteger! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Distance-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'instance creation' stamp: 'kf 5/23/2017 20:34:55'!
meterScale: anInteger 
	^ self new withScale: anInteger! !


!Unit class methodsFor: 'shortcuts instance creation' stamp: 'kf 5/23/2017 20:50:24'!
centimeter 
	^ self new withScale: 1/100! !

!Unit class methodsFor: 'shortcuts instance creation' stamp: 'kf 5/23/2017 20:50:35'!
kilometer
	^ self new withScale: 1000! !

!Unit class methodsFor: 'shortcuts instance creation' stamp: 'kf 5/23/2017 20:50:17'!
meter 
	^ self new withScale: 1! !

!Unit class methodsFor: 'shortcuts instance creation' stamp: 'kf 5/23/2017 20:50:49'!
milimeter
	^ self new withScale: 1/1000! !
