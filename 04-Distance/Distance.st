!classDefinition: #DistanceTest category: #Distance!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro milQuinientosCentimetros quinientosCentimetros dosMetros otroMetro cienCentimetros cincoCentimetros tresMetros unKilometro dosKilometro tresKilometro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance'!

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:38:00'!
setUp
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

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:11:36'!
test14

	self assert: ( unMetro to: dosMetros by: cincoCentimetros) size = 21
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:33:09'!
test15

	|interval collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	interval :=  (unMetro to: dosMetros by: cincoCentimetros).
	interval do: [:aDistance |  collection add: aDistance + unMetro].
	(dosMetros to: tresMetros by: cincoCentimetros)  do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:38:47'!
test16

	|interval collection collection2 |
	collection := OrderedCollection new.
	collection2 := OrderedCollection new.
	interval :=  (unKilometro to: dosKilometro by: cincoCentimetros).
	interval do: [:aDistance |  collection add: aDistance + unKilometro].
	(dosKilometro to: tresKilometro by: cincoCentimetros)  do: [:aDistance | collection2 add: aDistance ].
	
	self assert: collection = collection2! !


!classDefinition: #Distance category: #Distance!
Object subclass: #Distance
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance'!

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:43:31'!
* anInteger 
	^ self class for: value * anInteger  in: (Unit meterScale: 1)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:18:27'!
+ aDistance 
	^ self class for: value + aDistance value in: (Unit meterScale: 1)! !

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

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:02:28'!
abs
	^ value abs! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:42:13'!
adaptToNumber: rcvr andSend: selector 

		^ self class new for: (rcvr  perform: selector with: value) in: (Unit meterScale: 1)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 20:25:28'!
for: anInteger in: anUnit 
	value := anInteger * anUnit scale! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:06:39'!
isZero
	^ value isZero! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:20:03'!
rounded
	^ value rounded! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:10:58'!
to: aDistance 
	^ Interval from: self to: aDistance! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:22:14'!
to: aDistance by: aDistance2 
	^ Interval from: self to: aDistance  by: aDistance2! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:20:17'!
truncated
	^ value truncated! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/23/2017 21:18:37'!
value
	^ value ! !


!Distance methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:21:23'!
valueMeter
	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #Distance!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:18:00'!
for: anInteger in: anUnit 
	^ self new for: anInteger in: anUnit! !


!classDefinition: #Unit category: #Distance!
Object subclass: #Unit
	instanceVariableNames: 'value scale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance'!

!Unit methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:26:49'!
scale
	^ scale! !

!Unit methodsFor: 'accessing' stamp: 'kf 5/23/2017 20:35:02'!
withScale: anInteger 
	scale := anInteger! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #Distance!
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
