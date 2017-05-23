!classDefinition: #DistanceTest category: #Distance!
TestCase subclass: #DistanceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance'!

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 20:50:02'!
test01

	| distance |
	
	distance := Meter new for: 1.
	
	self assert: distance meters = 1.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 17:33:48'!
test02

	| distance |
	
	distance := Meter new for: 2.
	
	self assert: distance meters = 2.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 17:33:26'!
test03

	| distance1 distance2 |
	
	distance1 := Meter new for: 2.
	distance2 := Meter new for: 2.
	
	self assert: distance1 = distance2.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 17:34:17'!
test04

	| distance1 distance2 |
	
	distance1 := Meter new for: 2.
	distance2 := Meter new for: 1.
	
	self deny: distance1 = distance2.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 17:42:49'!
test05

	| distance1 distance2 distance3 |
	
	distance1 := Meter new for: 2.
	distance2 := Meter new for: 1.
	distance3 := Meter new for: 3.	
	
	self assert: (distance1 + distance2) = distance3
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'RB 5/23/2017 14:38:45'!
test06

	| distance1 |
	
	distance1 := Centimeter new for: 10.
	
	self assert: distance1 centimeters = 10.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 19:42:51'!
test07

	| distance1 distance2 |
	
	distance1 := Centimeter new for: 2.
	distance2 := Centimeter new for: 2.
	
	self assert: distance1 = distance2.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 19:47:47'!
test08

	| distance1 distance2 |
	
	distance1 := Meter new for: 1.
	distance2 := Centimeter new for: 1000.

	self assert: distance1 = distance2
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 20:07:19'!
test09

	| distance1 distance2 distance3 |
	
	distance1 := Meter new for: 1.
	distance2 := Centimeter new for: 1500.
	distance3 := Centimeter new for: 500.

	self assert:  (distance2 - distance1) = distance3
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 20:02:21'!
test10

	| distance1 distance2 distance3 |
	
	distance1 := Meter new for: 1.
	distance2 := Centimeter new for: 1600.
	distance3 := Centimeter new for: 600.

	self assert:  (distance2 - distance1) = distance3
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 20:09:51'!
test11

	| distance1 distance2 distance3 |
	
	distance1 := Meter new for: 2.
	distance2 := Centimeter new for: 1000.
	distance3 := Meter new for: 1.

	self assert:  (distance1 - distance2) = distance3
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:33:06'!
test12

	| distance1 distance2 |
	
	distance1 := Centimeter new for: 2.
	distance2 := Centimeter new for: 4.

	self assert:  (distance1 * 2) = distance2.	
	self assert:  (2 * distance1) = distance2	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 20:40:30'!
test13

	| distance1 distance2 distance3 |
	
	distance1 := Centimeter new for: 2.
	distance2 := Centimeter new for: 2.
	distance3 := Centimeter new for: 4.

	self assert:  (distance1 + distance2) = distance3
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:25:35'!
test14

	| distance1 distance2 |
	
	distance1 := Centimeter new for: 4.
	distance2 := Centimeter new for: 2.

	self assert:  (distance1 / 2) = distance2
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:36:11'!
test15

	| distance1 distance2 |
	
	distance1 := Kilometer new for: 4.
	distance2 := Kilometer new for: 4.

	self assert:  distance1 = distance2
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:40:03'!
test16

	| distance1 distance2 distance3 |
	
	distance1 := Kilometer new for: 4.
	distance2 := Meter new for: 4000.
	distance3 := Centimeter new for: 4000000.

	self assert:  distance1 = distance2.
	self assert:  distance1 = distance3
		! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:47:34'!
test17

	| distance1 distance2 distance3 |
	
	distance1 := Kilometer new for: 6.
	distance2 := Meter new for: 5000.
	distance3 := Centimeter new for: 4000000.

	self assert:  distance1 > distance2.
	self assert:  distance1 > distance3.
	self assert:  distance2 > distance3.
	self deny: distance3 > distance2.		! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:55:44'!
test18

	| distance1 distance2 distance3 distance4 |
	
	distance1 := Kilometer new for: 6.
	distance2 := Meter new for: 5000.
	distance3 := Centimeter new for: 4000000.
	distance4 := Meter new for: 6000.
	
	self deny:  distance1 <= distance2.
	self deny:  distance1 <= distance3.
	self deny:  distance2 <= distance3.
	self assert: distance3 <= distance2.		
	self assert: distance1 <= distance4.
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:15:08'!
test19

	| distance1 distance2 distance3 distance4 |
	
	distance1 := Kilometer new for: 6.
	distance2 := Meter new for: 5000.
	distance3 := Centimeter new for: 4000000.
	distance4 := Meter new for: 6000.
	
	self assert:  distance1 >= distance2.
	self assert:  distance1 >= distance3.
	self assert:  distance2 >= distance3.
	self deny: distance3 >= distance2.		
	self assert: distance1 >= distance4.
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:17:22'!
test20

	| distance1 distance2 distance3 |
	
	distance1 := Kilometer new for: 6.
	distance2 := Meter new for: 6000.
	distance3 := Centimeter new for: 6000000.
	
	self assert:  distance2 = distance1.
	self assert:  distance3 = distance1.
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:53:20'!
test21

	| distance1 distance2 |
	
	distance1 := Kilometer new for: 6.
	distance2 := Kilometer new for: 6.
	distance1 *2.	
	self assert:  distance2 = distance1.
! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 21:42:10'!
test22

	| distance1 distance2 distance3 |
	
	distance1 := Kilometer new for: 2.
	distance2 := Kilometer new for: 1.
	distance3 := Kilometer new for: 3.	
	
	self assert: (distance1 + distance2) = distance3
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 21:42:52'!
test23

	| distance1 distance2 distance3 |
	
	distance1 := Kilometer new for: 2.
	distance2 := Kilometer new for: 1.
	distance3 := Kilometer new for: 1.	
	
	self assert: (distance1 - distance2) = distance3
	! !


!classDefinition: #Distance category: #Distance!
Object subclass: #Distance
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance'!

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:54:54'!
* anInteger 

	^ self class new for: value * anInteger.
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 23:09:29'!
+ aDistance

	^ self class new for: value + (aDistance perform: self convertermethod)
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 23:10:26'!
- aDistance

	^ self class new for: value - (aDistance perform: self convertermethod)
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:58:17'!
/ anInteger 

	^ self class new for: value / anInteger.
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:57:44'!
< aDistance 
	^ (self > aDistance) not! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:57:05'!
<= aDistance 

	^ (self < aDistance) or: [self = aDistance].! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 23:11:14'!
= aDistance

	^  value = (aDistance perform: self convertermethod)
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 23:11:47'!
> aDistance

	^  value > (aDistance perform: self convertermethod)
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:15:24'!
>= aDistance 

	^ (self > aDistance) or: [self = aDistance].! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:54:14'!
adaptToNumber: rcvr andSend: selector 

		^ self class new for: (rcvr  perform: selector with: value).! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 20:31:22'!
centimeters

	self subclassResponsibility
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:36:47'!
for: anInteger 
	value :=  anInteger.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'RB 5/23/2017 14:37:47'!
kilometers

	self subclassResponsibility
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 20:31:16'!
meters

	self subclassResponsibility
	! !


!classDefinition: #Centimeter category: #Distance!
Distance subclass: #Centimeter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance'!

!Centimeter methodsFor: 'as yet unclassified' stamp: 'RB 5/23/2017 14:38:07'!
centimeters
	^ value.! !

!Centimeter methodsFor: 'as yet unclassified' stamp: 'RB 5/23/2017 14:39:19'!
convertermethod
	^ #centimeters! !

!Centimeter methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:43:58'!
kilometers
	^ self meters / 1000! !

!Centimeter methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 19:48:25'!
meters
	^ value / 1000! !


!classDefinition: #Kilometer category: #Distance!
Distance subclass: #Kilometer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance'!

!Kilometer methodsFor: 'as yet unclassified' stamp: 'RB 5/23/2017 14:38:17'!
centimeters
	^ self meters * 1000! !

!Kilometer methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 23:10:08'!
convertermethod
	^ #kilometers! !

!Kilometer methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:38:36'!
kilometers
	^ value.! !

!Kilometer methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 20:18:09'!
meters
	^ value * 1000! !


!classDefinition: #Meter category: #Distance!
Distance subclass: #Meter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance'!

!Meter methodsFor: 'as yet unclassified' stamp: 'RB 5/23/2017 14:38:24'!
centimeters
	^ value * 1000! !

!Meter methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 23:09:21'!
convertermethod 
	^ #meters.! !

!Meter methodsFor: 'as yet unclassified' stamp: 'kf 5/22/2017 10:43:47'!
kilometers
	^ value / 1000.! !

!Meter methodsFor: 'as yet unclassified' stamp: 'kf 5/21/2017 17:31:19'!
meters

	^ value! !
