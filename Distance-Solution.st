!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro milQuinientosCentimetros quinientosCentimetros dosMetros otroMetro cienCentimetros cincoCentimetros tresMetros unKilometro dosKilometro tresKilometro minusMeter ceroMetros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:07:57'!
setUp
		minusMeter  :=  Distance for: -1 in: Unit meter.
		ceroMetros  :=  Distance for: 0 in: Unit meter.
		unMetro :=  Distance for: 1 in: Unit meter.
		otroMetro :=  Distance for: 1 in:  Unit meter.
		dosMetros :=  Distance for: 2 in: Unit meter.
		tresMetros :=  Distance for: 3 in: Unit meter.
		cienCentimetros := Distance for: 100 in: Unit centimeter.
		cincoCentimetros := Distance for: 5 in: Unit centimeter.
		unKilometro := Distance for: 1 in: Unit kilometer.
		dosKilometro := Distance for: 2 in: Unit kilometer.
		tresKilometro := Distance for: 3 in: Unit kilometer.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:22:19'!
test01
	self assert: unMetro = unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:22:24'!
test02
	self assert: unMetro = otroMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:22:30'!
test03

	self deny: unMetro = dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:36:33'!
test04

	self assert: unMetro + unMetro = dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:01:25'!
test04Resta

	self assert: dosMetros - unMetro = unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:08:23'!
test04RestaConNegativo

	self assert: unMetro + minusMeter = ceroMetros 
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:44:08'!
test05

	self assert: unMetro * 2 = dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:44:24'!
test06

	self assert:  2 * unMetro = dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:44:12'!
test07

	self assert:  dosMetros / 2 = unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:52:41'!
test08

	self assert: dosMetros > unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:53:25'!
test09

	self deny: unMetro > dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:54:20'!
test10

	self assert: unMetro >= unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:55:19'!
test11

	self assert:  unMetro < dosMetros
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:55:45'!
test12

	self assert:  unMetro <= unMetro
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:10:22'!
test13

	self assert: (unMetro to: tresMetros) size = 3
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 18:18:58'!
test14

	self assert: ( unMetro to: dosMetros by: cincoCentimetros) size = 21
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 18:22:18'!
test15

	|interval collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	interval :=  (unMetro to: dosMetros by: cincoCentimetros).
	interval do: [:aDistance |  collection add: aDistance + unMetro].
	(dosMetros to: tresMetros by: cincoCentimetros)  do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:13:52'!
test16

	| collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	unMetro to: dosMetros  by: cincoCentimetros do: [:aDistance |  collection add: (aDistance + unMetro)].
	dosMetros to: tresMetros   by: cincoCentimetros do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:20:33'!
test17

	| collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	unMetro to: dosMetros.
	unMetro to: dosMetros do: [:aDistance |  Transcript  print: aDistance valueMeter].
	dosMetros to: tresMetros do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:43:31'!
* anInteger 
	^ self class for: value * anInteger  in: (Unit meterScale: 1)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 18:11:29'!
+ aDistance 
	^ self class for: value + aDistance valueMeter in: (Unit meterScale: 1)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:01:52'!
- aDistance 
	^ self class for: value - aDistance valueMeter in: (Unit meterScale: 1)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:43:41'!
/ anInteger 
	^ self class for: value / anInteger  in: (Unit meterScale: 1)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:55:36'!
< aDistance 
	^ value < aDistance valueMeter! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:56:12'!
<= aDistance 
	^ self < aDistance or: [self = aDistance]! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:21:01'!
= aDistance

	^ value = aDistance valueMeter! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:54:02'!
> aDistance 
	^ value > aDistance valueMeter! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:54:54'!
>= aDistance 
	^ self > aDistance or: [self = aDistance]! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:42:13'!
adaptToNumber: rcvr andSend: selector 

		^ self class new for: (rcvr  perform: selector with: value) in: (Unit meterScale: 1)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:25:28'!
for: anInteger in: anUnit 
	value := anInteger * anUnit scale! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 18:12:04'!
to: aDistance 
	^ DistanceInterval from: self to: aDistance! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 18:19:33'!
to: aDistance by: aDistance2 
	^ DistanceInterval from: self to: aDistance  by: aDistance2! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:15:27'!
to: aDistance by: aDistance2 do: aBlockClosure 
	(DistanceInterval from: 	self to: aDistance by: aDistance2) do: aBlockClosure ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:18:16'!
to: aDistance  do: aBlockClosure 

	|interval|
	
	interval := (DistanceInterval from: self to: aDistance ).
	interval  do: aBlockClosure .! !


!Distance methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:21:23'!
valueMeter
	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:18:00'!
for: anInteger in: anUnit 
	^ self new for: anInteger in: anUnit! !


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
Object subclass: #DistanceInterval
	instanceVariableNames: 'interval'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:04:56'!
at: position
	^ Distance for: (interval at: position) in: (Unit meter)! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 18:23:19'!
do: aBlock

	1 to: interval size do: [ :i |
		aBlock value: (self at: i) ]		! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:07:18'!
from: startDistance to: finishDistance
	interval := Interval from: startDistance valueMeter to: finishDistance valueMeter.! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:07:08'!
from: startDistance to: finishDistance by: intervalDistance
	interval := Interval from: startDistance valueMeter to: finishDistance valueMeter by: intervalDistance valueMeter ! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 18:17:16'!
size
	^ interval size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'initialization' stamp: 'kf 5/25/2017 20:06:26'!
from: startDistance to: finishDistance
	^ self new from: startDistance to: finishDistance! !


!DistanceInterval class methodsFor: 'as yet unclassified' stamp: 'kf 5/25/2017 20:06:53'!
from: startDistance to: finishDistance by: intervalDistance 
	^ self new from: startDistance to: finishDistance by: intervalDistance! !


!classDefinition: #Unit category: #'Distance-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'value scale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Unit methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:26:49'!
scale
	^ scale! !

!Unit methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:35:02'!
withScale: anInteger 
	scale := anInteger! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Distance-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'ic' stamp: 'kf 5/23/2017 20:50:24'!
centimeter 
	^ self new withScale: 1/100! !

!Unit class methodsFor: 'ic' stamp: 'kf 5/23/2017 20:50:35'!
kilometer
	^ self new withScale: 1000! !

!Unit class methodsFor: 'ic' stamp: 'kf 5/23/2017 20:50:17'!
meter 
	^ self new withScale: 1! !

!Unit class methodsFor: 'ic' stamp: 'kf 5/23/2017 20:34:55'!
meterScale: anInteger 
	^ self new withScale: anInteger! !

!Unit class methodsFor: 'ic' stamp: 'kf 5/23/2017 20:50:49'!
milimeter
	^ self new withScale: 1/1000! !
