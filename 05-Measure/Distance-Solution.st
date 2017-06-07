!classDefinition: #Measure category: #'Distance-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'value unit realValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Measure methodsFor: 'comparing' stamp: 'kf 5/23/2017 20:55:36'!
< aDistance 
	^ value < aDistance valueMeter! !

!Measure methodsFor: 'comparing' stamp: 'kf 6/6/2017 01:01:06'!
= aMagnitude

	(aMagnitude isKindOf: self class) ifFalse:[^ false] .
	(aMagnitude unit base = unit base) ifFalse: [^ false].
	

	^ value = aMagnitude valueMeter! !


!Measure methodsFor: 'initialization' stamp: 'kf 6/3/2017 19:09:01'!
size: aNumber in: anUnit 
	value := anUnit adapt: aNumber.
	realValue := aNumber.
	unit := anUnit.! !


!Measure methodsFor: 'accessing' stamp: 'kf 6/3/2017 20:04:19'!
amount
	^ unit deconvert: value! !

!Measure methodsFor: 'accessing' stamp: 'kf 6/3/2017 19:29:13'!
printString
	|valueInScale|
	
	valueInScale := realValue .
		
	valueInScale = 1 ifTrue: [^valueInScale printString, ' ',unit name.].
	^ valueInScale printString, ' ',unit name,'s'.! !

!Measure methodsFor: 'accessing' stamp: 'kf 6/1/2017 19:38:09'!
unit
	^ unit! !

!Measure methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:21:23'!
valueMeter
	^ value! !


!Measure methodsFor: 'converting' stamp: 'kf 6/7/2017 12:36:53'!
adaptToNumber: rcvr andSend: selector 

		^ self class new size: (rcvr  perform: selector with: value) in: (DerivedUnit meter)! !


!Measure methodsFor: 'intervals' stamp: 'kf 5/25/2017 18:12:04'!
to: aDistance 
	^ DistanceInterval from: self to: aDistance! !

!Measure methodsFor: 'intervals' stamp: 'kf 5/25/2017 18:19:33'!
to: aDistance by: aDistance2 
	^ DistanceInterval from: self to: aDistance  by: aDistance2! !

!Measure methodsFor: 'intervals' stamp: 'kf 5/29/2017 20:46:10'!
to: aDistance by: aDistance2 do: aBlockClosure 
	(self to: aDistance by: aDistance2) do: aBlockClosure ! !

!Measure methodsFor: 'intervals' stamp: 'kf 5/29/2017 20:47:34'!
to: aDistance do: aBlockClosure 
	(self to: aDistance) do: aBlockClosure ! !


!Measure methodsFor: 'arithmetic' stamp: 'RB 6/7/2017 00:40:20'!
* aValue
	(aValue isKindOf: self class) ifTrue:[^self class size: value * aValue valueMeter in: (unit base * aValue unit base)].
	^ self class size: value * aValue in: (self unit).! !

!Measure methodsFor: 'arithmetic' stamp: 'kf 6/7/2017 13:02:01'!
+ aDistance 
	unit type = aDistance unit type ifTrue: [^ self class size: value + aDistance valueMeter in: unit base].
	^ComposeMeasure with: self and: aDistance  operation: #+ in: (unit base + aDistance unit base).! !

!Measure methodsFor: 'arithmetic' stamp: 'kf 6/7/2017 13:02:08'!
- aDistance 
	unit type = aDistance unit type ifTrue: [^ self class size: value - aDistance valueMeter in: unit base].
	^ComposeMeasure with: self and: aDistance  operation: #- in: (unit base - aDistance unit base).! !

!Measure methodsFor: 'arithmetic' stamp: 'kf 6/7/2017 12:05:57'!
/ aValue
	
	(aValue isKindOf: self class) ifTrue:[
			(aValue unit base = unit base) ifTrue: [^ value / aValue valueMeter].
		^self class size: value / aValue valueMeter in: (unit / aValue unit)].
	^ self class size: value / aValue  in: (self unit)! !

!Measure methodsFor: 'arithmetic' stamp: 'kf 6/1/2017 20:02:26'!
hash
	^ value! !


!Measure methodsFor: 'as yet unclassified' stamp: 'kf 6/3/2017 20:13:45'!
convertTo: anUnit 
	^ Measure size:  (anUnit deconvert: value) in: anUnit ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'kf 6/1/2017 20:27:59'!
negated
	^ Measure size: (self amount * -1) in: unit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Distance-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'instance creation' stamp: 'RB 5/30/2017 00:49:18'!
size: anInteger in: anUnit 
	^ self new size: anInteger in: anUnit! !


!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro milQuinientosCentimetros quinientosCentimetros dosMetros otroMetro cienCentimetros cincoCentimetros tresMetros unKilometro dosKilometro tresKilometro minusMeter ceroMetros minusFiveCentimeter oneCentimeter twoHundredCentimeters oneCelsius anotherCelsius twoCelsius oneFahrenheit treintaytresFahrenheit diezFahrenheit menosVeinteCelsius doceFahrenheit dosSetentayCuatroKelvin aDay twentyFourHours dosMetrosPorSegundo dosMetrosSobreSegundo peras manzanas oneHour twentythreeHours bananas unSegundo'
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

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:49:19'!
setUp
		minusMeter  :=  Measure size: -1 in: DerivedUnit meter.
		minusFiveCentimeter := Measure size: -5 in: DerivedUnit centimeter.
		ceroMetros  :=  Measure size: 0 in: DerivedUnit meter.
		unMetro :=  Measure size: 1 in: DerivedUnit meter.
		otroMetro :=  Measure size: 1 in:  DerivedUnit meter.
		dosMetros :=  Measure size: 2 in: DerivedUnit meter.
		tresMetros :=  Measure size: 3 in: DerivedUnit meter.
		cienCentimetros := Measure size: 100 in: DerivedUnit centimeter.
		cincoCentimetros := Measure size: 5 in: DerivedUnit centimeter.
		unKilometro := Measure size: 1 in: DerivedUnit kilometer.
		dosKilometro := Measure size: 2 in: DerivedUnit kilometer.
		tresKilometro := Measure size: 3 in: DerivedUnit kilometer.
		oneCentimeter := Measure size: 1 in: DerivedUnit centimeter .
		twoHundredCentimeters := Measure size: 200 in: DerivedUnit centimeter.
		
		oneCelsius := Measure size: 1 in: DerivedUnit celsius.
		anotherCelsius := Measure size: 1 in: DerivedUnit celsius.
		menosVeinteCelsius := Measure size: -20 in: DerivedUnit celsius.
		treintaytresFahrenheit := Measure size: 33 in: DerivedUnit fahrenheit.
		doceFahrenheit := Measure size: 12 in: DerivedUnit fahrenheit.
		dosSetentayCuatroKelvin := Measure size: 274 in: DerivedUnit kelvin.
		
		aDay := Measure size: 1 in: DerivedUnit day.
		oneHour :=  Measure size: 1 in: DerivedUnit hour.
		twentythreeHours := Measure size: 23 in: DerivedUnit hour.
		twentyFourHours := Measure size: 24 in: DerivedUnit hour.
		unSegundo := Measure size: 1 in: DerivedUnit second.
		
		dosMetrosPorSegundo := Measure size: 2 in: (DerivedUnit meter * DerivedUnit second).
		dosMetrosSobreSegundo := Measure size: 2 in: (DerivedUnit meter / DerivedUnit second).
		
		peras := BaseUnit withName: 'pera' withType: 'pera'. 
		manzanas := BaseUnit withName: 'manzana' withType: 'manzana'.
		bananas := BaseUnit withName: 'banana' withType: 'banana'.! !

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

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/1/2017 19:20:20'!
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

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/1/2017 19:22:23'!
test21DistanceAndStepMustHaveTheSameMathematicSign

	| collection |
	collection := OrderedCollection new.
	self
		should: [unMetro to: dosMetros by: minusFiveCentimeter do: [:aDistance |  collection add: aDistance].]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = DistanceInterval stepInADifferentWayError]! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/1/2017 19:22:35'!
test22StepCantBeZeroMeter
	| collection |
	collection := OrderedCollection new.
	self
		should: [dosMetros to: unMetro by: ceroMetros do: [:aDistance |  collection add: aDistance].]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = DistanceInterval zeroStepError]! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/2/2017 11:04:11'!
test23DistanceFactoryCreateInstancesCorrectly

	|distanceFactory|
	
	distanceFactory := MeasureFactory new.
	
	self assert: distanceFactory minusOneMeter = minusMeter.
	self assert: distanceFactory oneCentimeter = oneCentimeter.
	self assert: distanceFactory oneHundredCentimeters = cienCentimetros.
	self assert: distanceFactory oneMeter = unMetro .	
	self assert: distanceFactory twoHundredCentimeters = twoHundredCentimeters.
	self assert: distanceFactory twoMeters = dosMetros .
	self assert: distanceFactory zeroMeters = ceroMetros .
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/1/2017 20:35:29'!
test24

	self deny:  unMetro = oneCelsius! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/1/2017 20:35:45'!
test25

	self assert:  anotherCelsius = oneCelsius! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/2/2017 10:34:37'!
test26

	self assert: treintaytresFahrenheit = oneCelsius! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/2/2017 11:18:54'!
test27

	self assert: doceFahrenheit = menosVeinteCelsius.
	self assert: dosSetentayCuatroKelvin = oneCelsius.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/2/2017 11:22:38'!
test28

	self assert: aDay = twentyFourHours! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:37:41'!
test29

	self assert: unMetro = (1 * DerivedUnit meter)! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:39:05'!
test30

	self assert: (DerivedUnit meter * DerivedUnit second ) = (DerivedUnit meter * DerivedUnit second)
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:37:50'!
test31

	self deny: (DerivedUnit second * DerivedUnit second ) = (DerivedUnit meter * DerivedUnit meter)
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:38:14'!
test32

	self deny: (DerivedUnit meter * DerivedUnit second ) = (DerivedUnit meter * DerivedUnit meter)
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:37:20'!
test33

	self assert: (DerivedUnit meter / DerivedUnit second ) = (DerivedUnit meter / DerivedUnit second)
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:38:01'!
test34
	self assert: (DerivedUnit meter * DerivedUnit second * DerivedUnit second) = (DerivedUnit meter * DerivedUnit second * DerivedUnit second).
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:37:07'!
test35
	self assert: (DerivedUnit second * DerivedUnit meter * DerivedUnit meter) = (DerivedUnit meter * DerivedUnit second * DerivedUnit meter).
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/5/2017 14:14:26'!
test36
	self assert: dosMetrosPorSegundo = dosMetrosPorSegundo.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/5/2017 14:16:25'!
test37
	self deny: dosMetrosPorSegundo = dosMetrosSobreSegundo.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/5/2017 20:43:45'!
test38

	self assert: ((10 * peras) + (10 * manzanas)) = ((10 * peras) + (10 * manzanas))
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 19:49:58'!
test39

	self assert: ((10 * peras) - (10 * manzanas)) = ((10 * peras) - (10 * manzanas)).! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/5/2017 23:53:18'!
test40

	self assert: aDay - twentythreeHours  = oneHour .
	self assert: twentythreeHours - aDay   = (oneHour negated ).! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:13:00'!
test41

	self assert: ((aDay - twentythreeHours )+ (10*peras))  = (oneHour + (10*peras))! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:26:13'!
test42

	self deny: ((10*peras) - (10*manzanas)) = ((10*peras) - (10*bananas)).
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:12:03'!
test43
	
	self assert: (dosMetrosPorSegundo * oneCelsius)= (dosMetros * unSegundo * oneCelsius)
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:17:49'!
test44

	self assert: (((10*peras) - (10*manzanas)) + oneCelsius) = (((10*peras) - (10*manzanas)) + oneCelsius).
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:17:56'!
test45

	self assert: (((10*peras) + (10*manzanas)) - oneCelsius) = (((10*peras) + (10*manzanas)) - oneCelsius).
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:18:00'!
test46

	self assert: (((10*peras) + (10*manzanas)) * oneCelsius) = (((10*peras) + (10*manzanas)) * oneCelsius).
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:18:04'!
test47

	self assert: (((10*peras) + (10*manzanas)) / oneCelsius) = (((10*peras) + (10*manzanas)) / oneCelsius).
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:37:11'!
test48

	self assert: 1* DerivedUnit kilometer /(1 * DerivedUnit meter) = 1000
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 13:12:38'!
test49

	self assert: (((10*peras) + (10*manzanas)) + (10* peras)) = ((20*peras) + (10*manzanas))
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:24:59'!
test50

	self assert: (((10*peras) + (10*manzanas)) + (10* manzanas)) = (((20*manzanas) + (10*peras)))
	! !


!classDefinition: #ComposeMeasure category: #'Distance-Solution'!
Object subclass: #ComposeMeasure
	instanceVariableNames: 'firstMeasure secondMeasure operator unit measures operators'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:18:21'!
* aMeasure
	^ ComposeMeasure with: self and: aMeasure operation: #* in: (unit * aMeasure unit).
! !

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 13:15:28'!
+ aMeasure
	(unit firstUnit base = aMeasure unit base) ifTrue: [measures at: 1 put: (measures first + aMeasure). ^ self].
	(unit secondUnit base = aMeasure unit base) ifTrue: [measures at: 2 put: ((measures at:2) + aMeasure). ^ self].
	^ ComposeMeasure with: self and: aMeasure operation: #+ in: (unit + aMeasure unit).
! !

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:17:02'!
- aMeasure
	^ ComposeMeasure with: self and: aMeasure operation: #- in: (unit - aMeasure unit).
! !

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:18:29'!
/ aMeasure
	^ ComposeMeasure with: self and: aMeasure operation: #/ in: (unit / aMeasure unit).
! !

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 20:31:14'!
= aMeasure
	(aMeasure isKindOf: self class) ifFalse: [^false].
	(aMeasure unit = self unit) ifFalse: [^false].
	
		^ ((self firstMeasure = aMeasure firstMeasure )
	   and: [(self secondMeasure = aMeasure secondMeasure ) 
		and: [self operator = aMeasure operator.]])
	
	    or: ((self operator = aMeasure operator)  
			and: [self firstMeasure = aMeasure secondMeasure] 
			and: [self secondMeasure = aMeasure firstMeasure]).

	! !

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:58:07'!
firstMeasure
	^ measures first.
	! !

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 13:01:06'!
operator
	^operators first.! !

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 12:58:17'!
secondMeasure
	^ measures last.! !

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 20:29:01'!
unit
	^unit! !

!ComposeMeasure methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 13:00:43'!
with: aMeasure and: aMeasure2 operation: anOperator in: aComposeUnit
	measures := OrderedCollection new.
	measures add: aMeasure.
	measures add: aMeasure2.
	operators := OrderedCollection new.
	operators add: operator .
	unit := aComposeUnit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ComposeMeasure class' category: #'Distance-Solution'!
ComposeMeasure class
	instanceVariableNames: 'secondMeasure firstMeasure unit'!

!ComposeMeasure class methodsFor: 'class initialization' stamp: 'kf 6/7/2017 11:46:17'!
with: aMeasure and: aMeasure2 operation: anOperator in: aComposeUnit 
	aComposeUnit isSimpleUnit ifTrue: [^ Measure size: (aMeasure perform: anOperator with: aMeasure2 )  in: aComposeUnit ].
	^self new with: aMeasure and: aMeasure2 operation: anOperator in: aComposeUnit.! !


!classDefinition: #ComposeUnit category: #'Distance-Solution'!
Object subclass: #ComposeUnit
	instanceVariableNames: 'firstUnit secondUnit operator firstUnitConverter secondUnitConverter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:34:15'!
* anUnit
	^ ComposeUnit with: self and: anUnit base operator: #*.
! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:34:12'!
+ anUnit
	^ ComposeUnit with: self and: anUnit base operator: #+.
! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:34:18'!
- anUnit
	^ ComposeUnit with: self and: anUnit base operator: #-.
! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:34:22'!
/ anUnit
	^ ComposeUnit with: self and: anUnit base operator: #/.
! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:07:03'!
= aComposeUnit
	(aComposeUnit isKindOf: self class) ifFalse:[^ false] .
	
	^ ((self firstUnit = aComposeUnit firstUnit )
	   and: [(self secondUnit = aComposeUnit secondUnit ) 
		and: [self operator = aComposeUnit operator.]]) 
	
	    or: ((self operator = aComposeUnit operator)  
			and: [self firstUnit = aComposeUnit secondUnit] 
			and: [self secondUnit = aComposeUnit firstUnit]).
! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:04:58'!
adapt: aMeasure
	| finalValue |
	finalValue := firstUnitConverter value: aMeasure.
	^secondUnitConverter value: finalValue.! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/5/2017 20:37:37'!
adaptToNumber: rcvr andSend: selector 

		^ Measure size: rcvr in: self! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 01:03:19'!
base
	^ self! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:09:21'!
converter
	^[:value | value].! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:31:15'!
firstUnit
	^ firstUnit ! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 11:44:52'!
isSimpleUnit
 ^ false! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/4/2017 20:40:00'!
operator

	^ operator ! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:31:11'!
secondUnit
	^ secondUnit! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/4/2017 20:39:39'!
self
	self shouldBeImplemented! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 19:26:23'!
type
	^ firstUnit type,operator, secondUnit type! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:59:46'!
with: anUnit and: anUnit2 operator: anOperator
	firstUnit := anUnit.
	secondUnit := anUnit2.
	operator := anOperator.! !

!ComposeUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:10:10'!
with: anUnit and: anUnit2 operator: anOperator  withConverter: aConverter andConverter: aConverter2
	firstUnit := anUnit base.
	secondUnit := anUnit2 base.
	operator := anOperator.
	firstUnitConverter := aConverter.
	secondUnitConverter := aConverter2.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ComposeUnit class' category: #'Distance-Solution'!
ComposeUnit class
	instanceVariableNames: ''!

!ComposeUnit class methodsFor: 'class initialization' stamp: 'RB 6/7/2017 01:02:23'!
with: anUnit and: anUnit2 operator: aSymbol 
	(anUnit type  = anUnit2 type) ifTrue: [^ anUnit].
	^ self new with: anUnit and: anUnit2 operator: aSymbol withConverter: anUnit converter andConverter: anUnit2 converter.! !


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
Object subclass: #DistanceInterval
	instanceVariableNames: 'interval from to by'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'initialization' stamp: 'kf 6/1/2017 20:28:40'!
from: startDistance to: finishDistance
	interval := Interval from: startDistance valueMeter to: finishDistance valueMeter.
	from := startDistance.
	to := finishDistance.
	by := Measure size: 1 in: startDistance unit. ! !

!DistanceInterval methodsFor: 'initialization' stamp: 'kf 6/1/2017 19:54:54'!
from: startDistance to: finishDistance by: intervalDistance
	interval := Interval from: startDistance valueMeter to: finishDistance valueMeter by: intervalDistance valueMeter.
	
	from := startDistance.
	to := finishDistance.
	by := intervalDistance .! !


!DistanceInterval methodsFor: 'accessing' stamp: 'kf 6/7/2017 12:38:27'!
at: position
	^ Measure size: (interval at: position) in: (DerivedUnit meter)! !

!DistanceInterval methodsFor: 'accessing' stamp: 'kf 6/1/2017 19:55:39'!
by
	^ by! !

!DistanceInterval methodsFor: 'accessing' stamp: 'kf 5/25/2017 18:23:19'!
do: aBlock

	1 to: interval size do: [ :i |
		aBlock value: (self at: i) ]		! !

!DistanceInterval methodsFor: 'accessing' stamp: 'kf 6/1/2017 19:55:15'!
from
	^ from.! !

!DistanceInterval methodsFor: 'accessing' stamp: 'kf 5/25/2017 18:17:16'!
size
	^ interval size.! !

!DistanceInterval methodsFor: 'accessing' stamp: 'kf 6/1/2017 19:55:20'!
to
	^ to.! !

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


!classDefinition: #MeasureFactory category: #'Distance-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!MeasureFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:23:34'!
minusOneMeter
	^ self createMeter: -1! !

!MeasureFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:24:30'!
oneCentimeter
	^ self createCentimeter: 1.! !

!MeasureFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:25:30'!
oneHundredCentimeters
	^ self createCentimeter: 100.! !

!MeasureFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:25:42'!
oneMeter
	^ self createMeter: 1! !

!MeasureFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:25:57'!
twoHundredCentimeters
	^ self createCentimeter: 200! !

!MeasureFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:26:14'!
twoMeters
	^ self createMeter: 2! !

!MeasureFactory methodsFor: 'accessing' stamp: 'kf 5/27/2017 16:26:29'!
zeroMeters
	^ self createMeter: 0.! !


!MeasureFactory methodsFor: 'private' stamp: 'kf 6/7/2017 12:38:23'!
createCentimeter: anInteger
	^ Measure size: anInteger in: DerivedUnit  centimeter.
	! !

!MeasureFactory methodsFor: 'private' stamp: 'kf 6/7/2017 12:38:20'!
createMeter: anInteger
	^ Measure size: anInteger  in: DerivedUnit meter.
	! !


!classDefinition: #Unit category: #'Distance-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'name type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!


!classDefinition: #BaseUnit category: #'Distance-Solution'!
Unit subclass: #BaseUnit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:52:18'!
* anUnit 
	^ ComposeUnit with: self and: anUnit operator: #*.! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:52:24'!
+ anUnit 
	(self type = anUnit type) ifTrue:[^ self].
	^ ComposeUnit with: self and: anUnit operator: #+! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:52:28'!
- anUnit 
	(self type = anUnit type) ifTrue:[^ self].
	^ ComposeUnit with: self and: anUnit operator: #-! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:52:32'!
/ anUnit 
	^ ComposeUnit with: self and: anUnit operator: #/.! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:57:45'!
= anUnit
	^ name = anUnit name! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:52:41'!
adapt: aSmallInteger 
	^ aSmallInteger ! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:56:09'!
adaptToNumber: rcvr andSend: aSymbol 
		^ Measure size: rcvr in: self! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 01:01:32'!
base
	^ self! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:08:13'!
converter
	^[:value | value].! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 01:02:39'!
deconvert: aSmallInteger 
	^ aSmallInteger ! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:59:18'!
name
	^ name! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 01:05:51'!
printString
	^ name! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:54:14'!
type
	^ type! !

!BaseUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:45:04'!
withName: aString withType: aType
	name := aString.
	type := aType.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BaseUnit class' category: #'Distance-Solution'!
BaseUnit class
	instanceVariableNames: 'type'!

!BaseUnit class methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 19:14:14'!
celsius
	^ self withName: 'celsius' withType: 'grade'! !

!BaseUnit class methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:44:17'!
meter
	^ self withName: 'meter' withType: 'distance'! !

!BaseUnit class methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 19:15:30'!
minute
	^ self withName: 'minute' withType: 'time'! !

!BaseUnit class methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:44:43'!
withName: aString withType: aType 
	^ self new withName: aString withType: aType! !


!classDefinition: #DerivedUnit category: #'Distance-Solution'!
Unit subclass: #DerivedUnit
	instanceVariableNames: 'blockConverter blockDeconverter unitBase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DerivedUnit methodsFor: 'accessing' stamp: 'kf 6/1/2017 19:19:18'!
name
	^ name! !

!DerivedUnit methodsFor: 'accessing' stamp: 'kf 6/1/2017 19:30:29'!
printString
	^ name! !

!DerivedUnit methodsFor: 'accessing' stamp: 'kf 6/1/2017 20:46:50'!
type
	^ type! !


!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:50:51'!
* anUnit 
	^ ComposeUnit with: self and: anUnit operator: #*.! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:50:56'!
+ anUnit 
	(self type = anUnit type) ifTrue:[^ self base].
	^ ComposeUnit with: self and: anUnit operator: #+! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:51:00'!
- anUnit 
	(self type = anUnit type) ifTrue:[^ self base].
	^ ComposeUnit with: self and: anUnit operator: #-! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:51:05'!
/ anUnit 
	^ ComposeUnit with: self and: anUnit operator: #/.! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/2/2017 10:30:40'!
= anUnit
	^ name = anUnit name
	! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/3/2017 17:47:29'!
adapt: aMeasure 
	^ blockConverter value: aMeasure ! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/3/2017 20:31:31'!
adaptToNumber: rcvr andSend: selector 

		^ Measure size: rcvr in: self! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 01:01:23'!
base
	^ unitBase ! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 01:03:46'!
converter
	^blockConverter! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/3/2017 19:47:25'!
deconvert: aMeasure 
	^ blockDeconverter value: aMeasure ! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/7/2017 11:44:44'!
isSimpleUnit
 ^ true! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 19:28:07'!
withConvertion: aBlockClosure withDeconvertion: aBlockClosure2 withName: aString withBase: anUnitBase 
	blockConverter := aBlockClosure.
	blockDeconverter := aBlockClosure2.
	name := aString.
	unitBase := anUnitBase.
	type := anUnitBase type.! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'RB 6/7/2017 00:21:56'!
withConvertion: aBlockClosure withDeconvertion: aBlockClosure2 withName: aString withType: aType 
	blockConverter := aBlockClosure.
	blockDeconverter := aBlockClosure2.
	name := aString.
	type := aType.
	! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'kf 6/3/2017 17:46:18'!
withConvertion: aBlockClosure withName: aString withType: aType 
	blockConverter := aBlockClosure.
	name := aString.
	type := aType.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DerivedUnit class' category: #'Distance-Solution'!
DerivedUnit class
	instanceVariableNames: ''!

!DerivedUnit class methodsFor: 'instance creation' stamp: 'kf 6/3/2017 19:01:33'!
withConvertion: aBlockClosure withName: aString withType: aString3 
	^ self new withConvertion: aBlockClosure withName: aString withType: aString3 ! !


!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:50:10'!
celsius 
	^ BaseUnit celsius! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:43'!
centimeter 
	^ self withConvertion: [:aNumber| aNumber / 100]  withDeconvertion: [:aNumber| aNumber * 100] withName: 'centimeter' withBase: (BaseUnit meter)
! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:51'!
day
		^ self withConvertion: [:aNumber| aNumber * 60 * 24 ]  withDeconvertion: [:aNumber| aNumber / (60*24)] withName: 'day' withBase: (BaseUnit minute).! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:50:13'!
decameter
	^ self withConvertion: [:aNumber| aNumber * 10] withDeconvertion: [:aNumber| aNumber  / 10] withName: 'decameter' withBase: (BaseUnit meter)! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:48'!
decimeter
	^ self withConvertion: [:aNumber| aNumber / 10]  withDeconvertion: [:aNumber| aNumber  * 10] withName: 'decimeter' withBase: (BaseUnit meter)! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:30'!
fahrenheit 
		^ self withConvertion: [:aNumber| aNumber - 32]  withDeconvertion: [:aNumber| aNumber + 32] withName: 'fahrenheit' withBase: (BaseUnit celsius).! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:33'!
hectometer
		^ self withConvertion: [:aNumber| aNumber * 100]  withDeconvertion: [:aNumber| aNumber / 100] withName: 'hectometer' withBase: (BaseUnit meter)! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:22'!
hour
	^ self withConvertion: [:aNumber| aNumber * 60]  withDeconvertion: [:aNumber| aNumber / 60] withName: 'hour' withBase: (BaseUnit minute).! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:50:05'!
kelvin 	
		^ self withConvertion: [:aNumber| aNumber - 273]  withDeconvertion: [:aNumber| aNumber + 273] withName: 'kelvin' withBase: (BaseUnit celsius).! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:50:03'!
kilometer
		^ self withConvertion: [:aNumber| aNumber * 1000]  withDeconvertion: [:aNumber| aNumber / 1000] withName: 'kilometer' withBase: (BaseUnit meter)! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:39'!
meter 
	^ BaseUnit meter! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:25'!
milimeter
		^ self withConvertion: [:aNumber| aNumber / 1000]  withDeconvertion: [:aNumber| aNumber * 1000] withName: 'milimeter' withBase: (BaseUnit meter).! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:27'!
minute
		^ BaseUnit minute.! !

!DerivedUnit class methodsFor: 'shortcuts instance creation' stamp: 'kf 6/7/2017 12:49:57'!
second
	^ self withConvertion: [:aNumber| aNumber / 60] withDeconvertion: [:aNumber| aNumber * 60] withName: 'second' withBase: (BaseUnit minute).! !


!DerivedUnit class methodsFor: 'types' stamp: 'RB 6/2/2017 11:17:18'!
compound
	^ 'compound'! !

!DerivedUnit class methodsFor: 'types' stamp: 'kf 6/1/2017 20:44:00'!
distance
	^ 'distance'! !

!DerivedUnit class methodsFor: 'types' stamp: 'kf 6/1/2017 20:45:58'!
grade
	^ 'grade'! !

!DerivedUnit class methodsFor: 'types' stamp: 'RB 6/2/2017 11:17:08'!
time
	^ 'time'! !


!DerivedUnit class methodsFor: 'as yet unclassified' stamp: 'kf 6/6/2017 00:48:43'!
withConvertion: aBlockClosure withDeconvertion: aBlockClosure2 withName: aString withBase: anUnitBase 
	^self new withConvertion: aBlockClosure withDeconvertion: aBlockClosure2 withName: aString withBase: anUnitBase ! !

!DerivedUnit class methodsFor: 'as yet unclassified' stamp: 'kf 6/3/2017 19:46:13'!
withConvertion: aBlockClosure withDeconvertion: aBlockClosure2 withName: aString withType: aString4 
	^ self new withConvertion: aBlockClosure withDeconvertion: aBlockClosure2 withName: aString withType: aString4 ! !

!DerivedUnit class methodsFor: 'as yet unclassified' stamp: 'kf 6/5/2017 20:42:05'!
withName: aString withType: aString4 
	^ self new withConvertion: [:value | value] withDeconvertion: [:value | value] withName: aString withType: aString4 ! !
