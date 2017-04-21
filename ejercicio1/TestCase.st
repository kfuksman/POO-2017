'From Cuis 5.0 of 7 November 2016 [latest update: #3076] on 20 April 2017 at 9:40:11 pm'!
!classDefinition: #TestCase category: #'Tools-Testing'!
Object subclass: #TestCase
	instanceVariableNames: 'testSelector failureString raisedError'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tools-Testing'!
!TestCase commentStamp: '<historical>' prior: 0!
A TestCase is a Command representing the future running of a test case. Create one with the class method #selector: aSymbol, passing the name of the method to be run when the test case runs.

When you discover a new fixture, subclass TestCase, declare instance variables for the objects in the fixture, override #setUp to initialize the variables, and possibly override# tearDown to deallocate any external resources allocated in #setUp.

When you are writing a test case method, send #assert: aBoolean when you want to check for an expected value. For example, you might say "self assert: socket isOpen" to test whether or not a socket is open at a point in a test.!


!TestCase methodsFor: 'Dependencies'!
addDependentToHierachy: anObject 
	"an empty method. for Composite compability with TestSuite"


			! !

!TestCase methodsFor: 'Dependencies'!
removeDependentFromHierachy: anObject 
	"an empty method. for Composite compability with TestSuite"


			! !


!TestCase methodsFor: 'Accessing' stamp: 'md 8/2/2006 10:59'!
assert: aBooleanOrBlock

	aBooleanOrBlock value ifFalse: [self signalFailure: 'Assertion failed']
			! !

!TestCase methodsFor: 'Accessing' stamp: 'jmv 5/10/2015 15:29'!
assert: aBoolean description: aStringOrBlock
	aBoolean ifFalse: [
		failureString _ aStringOrBlock value.
		self logFailure: failureString.
		TestResult failure sunitSignalWith: failureString]
			! !

!TestCase methodsFor: 'Accessing' stamp: 'jmv 3/27/2015 10:41'!
assert: aBoolean description: aString resumable: resumableBoolean 
	| exception |
	aBoolean
		ifFalse: [		
			failureString _ aString.
			self logFailure: aString.
			exception := resumableBoolean
						ifTrue: [TestResult resumableFailure]
						ifFalse: [TestResult failure].
			exception sunitSignalWith: aString]
			! !

!TestCase methodsFor: 'Accessing' stamp: 'dc 4/2/2007 18:38'!
assert: expected equals: actual
	^ self
		assert: (expected = actual)
		description: (self comparingStringBetween: expected and: actual)
! !

!TestCase methodsFor: 'Accessing'!
deny: aBoolean

	self assert: aBoolean not
			! !

!TestCase methodsFor: 'Accessing'!
deny: aBoolean description: aString
	self assert: aBoolean not description: aString
			! !

!TestCase methodsFor: 'Accessing'!
deny: aBoolean description: aString resumable: resumableBoolean 
	self
		assert: aBoolean not
		description: aString
		resumable: resumableBoolean
			! !

!TestCase methodsFor: 'Accessing' stamp: 'jmv 3/27/2015 10:45'!
errored: anError
	raisedError _ anError! !

!TestCase methodsFor: 'Accessing' stamp: 'jmv 3/27/2015 10:48'!
failureString
	^failureString! !

!TestCase methodsFor: 'Accessing' stamp: 'jmv 3/27/2015 10:49'!
raisedError
	^raisedError! !

!TestCase methodsFor: 'Accessing'!
resources
	| allResources resourceQueue |
	allResources := Set new.
	resourceQueue := OrderedCollection new.
	resourceQueue addAll: self class resources.
	[resourceQueue isEmpty] whileFalse: [
		| next |
		next := resourceQueue removeFirst.
		allResources add: next.
		resourceQueue addAll: next resources].
	^allResources
			! !

!TestCase methodsFor: 'Accessing'!
selector
	^testSelector
			! !

!TestCase methodsFor: 'Accessing'!
should: aBlock
	self assert: aBlock value
			! !

!TestCase methodsFor: 'Accessing'!
should: aBlock description: aString
	self assert: aBlock value description: aString
			! !

!TestCase methodsFor: 'Accessing'!
should: aBlock raise: anExceptionalEvent 
	^self assert: (self executeShould: aBlock inScopeOf: anExceptionalEvent)
			! !

!TestCase methodsFor: 'Accessing'!
should: aBlock raise: anExceptionalEvent description: aString 
	^self assert: (self executeShould: aBlock inScopeOf: anExceptionalEvent)
		description: aString
			! !

!TestCase methodsFor: 'Accessing' stamp: 'HAW 2/10/2017 17:37:41'!
should: aBlock raise: anExceptionalType withExceptionDo: assertionsBlock

	^self assert: (self executeShould: aBlock inScopeOf: anExceptionalType withExceptionDo: assertionsBlock)
			! !

!TestCase methodsFor: 'Accessing'!
shouldnt: aBlock
	self deny: aBlock value
			! !

!TestCase methodsFor: 'Accessing'!
shouldnt: aBlock description: aString
	self deny: aBlock value description: aString
			! !

!TestCase methodsFor: 'Accessing'!
shouldnt: aBlock raise: anExceptionalEvent 
	^self assert: (self executeShould: aBlock inScopeOf: anExceptionalEvent) not
			! !

!TestCase methodsFor: 'Accessing'!
shouldnt: aBlock raise: anExceptionalEvent description: aString 
	^self assert: (self executeShould: aBlock inScopeOf: anExceptionalEvent) not 		description: aString
			! !

!TestCase methodsFor: 'Accessing' stamp: 'jmv 3/27/2015 10:42'!
signalFailure: aString

	failureString _ aString.
	TestResult failure sunitSignalWith: aString! !


!TestCase methodsFor: 'Running' stamp: 'jmv 12/29/2009 10:42'!
debug
	self resources do: [:res | 
		res isAvailable ifFalse: [^res signalInitializationError]].
	[(self class selector: testSelector) runCase] 
		ensure: [self resources do: [:each | each reset]]
			! !

!TestCase methodsFor: 'Running' stamp: 'HAW 3/3/2017 18:49:24'!
debugAsFailure
	
	^self debugAsFailureIfCanNot: [ self signalCanNotDebugMethod ]! !

!TestCase methodsFor: 'Running' stamp: 'HAW 3/3/2017 19:13:13'!
debugAsFailureIfCanNot: handler
	
	| semaphore |
	
	self ifCanNotDebugDo: [ ^handler value].
	
	semaphore := Semaphore new.
	self resources do: [:res | 
		res isAvailable ifFalse: [^res signalInitializationError]].
	[semaphore wait. 
	self tearDown.
	self resources do: [:each | each reset]] fork.
	(self class selector: testSelector) runCaseAsFailure: semaphore.! !

!TestCase methodsFor: 'Running' stamp: 'jmv 3/27/2015 09:44'!
failureLog	
	^Transcript	! !

!TestCase methodsFor: 'Running' stamp: 'jmv 1/3/2013 16:28'!
isLogging
	"Log to Transcript"
	^true! !

!TestCase methodsFor: 'Running' stamp: 'jmv 1/3/2013 16:33'!
logFailure: aString
	| log |
	self isLogging ifTrue: [
		log _ self failureLog.
		log newLine.
		self printOn: log.
		log nextPutAll: ' -- '.
		log nextPutAll: aString ]! !

!TestCase methodsFor: 'Running'!
run
	| result |
	result := TestResult new.
	self run: result.
	^result
			! !

!TestCase methodsFor: 'Running' stamp: 'jmv 5/13/2012 23:05'!
run: aResult
	ChangeSet
		runningTest: self printString
		do: [ aResult runCase: self ]
			! !

!TestCase methodsFor: 'Running' stamp: 'jmv 12/29/2009 10:41'!
runCase

	[
		self setUp.
		self performTest] ensure: [self tearDown]
			! !

!TestCase methodsFor: 'Running'!
setUp
			! !

!TestCase methodsFor: 'Running'!
tearDown
			! !


!TestCase methodsFor: 'Private' stamp: 'HAW 3/3/2017 14:13:09'!
canNotDebugMethodErrorDescription

	^self class canNotDebugMethodErrorDescription! !

!TestCase methodsFor: 'Private' stamp: 'jmv 8/10/2010 07:33'!
comparingStringBetween: expected and: actual
	^ String streamContents: [:stream |
		stream
			nextPutAll: 'Expected ';
			nextPutAll: (expected printStringLimitedTo: 50);
			nextPutAll: ' but was ';
			nextPutAll: (actual printStringLimitedTo: 50);
			nextPutAll: '.'
		]! !

!TestCase methodsFor: 'Private' stamp: 'jmv 12/29/2009 10:41'!
executeShould: aBlock inScopeOf: anExceptionalEvent 
	^[
		aBlock value.
 		false]
			on: anExceptionalEvent
			do: [:ex | ex sunitExitWith: true]
			! !

!TestCase methodsFor: 'Private' stamp: 'HAW 2/10/2017 17:38:10'!
executeShould: aBlock inScopeOf: anExceptionType withExceptionDo: assertionsBlock

	^[aBlock value.
 	false] 
		on: anExceptionType
		do: [:exception | 
			assertionsBlock value: exception.
			exception sunitExitWith: true]! !

!TestCase methodsFor: 'Private' stamp: 'HAW 3/6/2017 14:55:38'!
ifCanNotDebugDo: handler

	^self methodForTest isQuick ifTrue: handler! !

!TestCase methodsFor: 'Private' stamp: 'HAW 3/6/2017 14:55:23'!
methodForTest

	"Can not call it testMethod because it will be detected as test - Hernan" 

	^self class lookupSelector: self selector! !

!TestCase methodsFor: 'Private' stamp: 'HAW 3/6/2017 14:55:45'!
openDebuggerOnFailingTestMethod

	| guineaPig context compiledMethod debugger |

	compiledMethod _ self methodForTest.
	guineaPig _ [ self performTest ] newProcess.
	context _ guineaPig suspendedContext.
	debugger _ Debugger new
		process: guineaPig
		context: context.
	debugger openFullNoSuspendLabel: 'Debug failed test ', self printString.

	[debugger interruptedContext method == compiledMethod]
		whileFalse: [debugger send].
! !

!TestCase methodsFor: 'Private' stamp: 'HAW 3/6/2017 14:55:50'!
openDebuggerOnFailingTestMethod: semaphore

	| guineaPig context compiledMethod debugger |

	compiledMethod _ self methodForTest.
	guineaPig _ [ self performTest ] newProcess.
	context _ guineaPig suspendedContext.
	debugger _ TestCaseDebugger new
		process: guineaPig
		context: context.
	debugger doneSemaphore: semaphore.
	debugger openFullNoSuspendLabel: 'Debug failed test ', self printString.

	[debugger interruptedContext method == compiledMethod]
		whileFalse: [debugger send].
! !

!TestCase methodsFor: 'Private' stamp: 'jmv 2/2/2010 09:23'!
performTest

	self perform: testSelector asSymbol
			! !

!TestCase methodsFor: 'Private' stamp: 'nk 1/22/2004 22:50'!
runCaseAsFailure: aSemaphore
	self setUp.
	self openDebuggerOnFailingTestMethod: aSemaphore.! !

!TestCase methodsFor: 'Private'!
setTestSelector: aSymbol
	testSelector := aSymbol
			! !

!TestCase methodsFor: 'Private' stamp: 'HAW 3/3/2017 14:13:37'!
signalCanNotDebugMethod 

	self error: self canNotDebugMethodErrorDescription! !


!TestCase methodsFor: 'Printing' stamp: 'jmv 9/22/2009 09:00'!
printOn: aStream

	aStream
		nextPutAll: self class printString;
		nextPutAll: '>>#';
		nextPutAll: (testSelector ifNil: [ 'unknown' ])
			! !


!TestCase methodsFor: 'Testing' stamp: 'jmv 7/4/2016 22:41'!
is: aSymbol
	^aSymbol == #TestCase or: [ super is: aSymbol ]! !


!TestCase methodsFor: 'as yet unclassified' stamp: 'kf 4/20/2017 21:23:30'!
assertEntity: aBlockClosure on: error assertError: errorToAssert assertEntity: anAssertEntityBlockClosure
	
	
	[ aBlockClosure value.
	self fail ]
		on: error
		do: [ :anError | 
			self assert: anError messageText = errorToAssert.
			self assert: [anAssertEntityBlockClosure] value.]
! !

!TestCase methodsFor: 'as yet unclassified' stamp: 'kf 4/20/2017 21:34:49'!
assertEntity: aBlockClosure on: error do: anAssertEntityBlockClosure
	
	
	[ aBlockClosure value.
	self fail ]
		on: error
		do: [ :anError | anAssertEntityBlockClosure value: anError]
! !

!TestCase methodsFor: 'as yet unclassified' stamp: 'kf 4/20/2017 21:00:20'!
assertTestTime: aClosure time: aTime

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue.
	
	aClosure value.
	
	millisecondsAfterRunning := Time millisecondClockValue.
	
	 self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aTime 
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestCase class' category: #'Tools-Testing'!
TestCase class
	instanceVariableNames: ''!

!TestCase class methodsFor: 'Accessing' stamp: 'ul 12/4/2009 03:44'!
allTestSelectors

	^(self allSelectors asArray select: [ :each | 
		(each beginsWith: 'test') and: [ each numArgs isZero ] ]) sort
			! !

!TestCase class methodsFor: 'Accessing'!
resources

	^#()
			! !

!TestCase class methodsFor: 'Accessing'!
sunitVersion
	^'3.1'
			! !

!TestCase class methodsFor: 'Accessing' stamp: 'jmv 2/2/2010 09:23'!
testSelectors

	^(self selectors asArray select: [ :each | 
		(each beginsWith: 'test') and: [ each numArgs isZero ] ]) sort! !


!TestCase class methodsFor: 'Building Suites' stamp: 'nk 4/21/2002 10:59'!
addTestsFor: classNameString toSuite: suite

	| cls  |
	cls _ Smalltalk at: classNameString ifAbsent: [ ^suite ].
	^cls isAbstract 
		ifTrue:  [
			cls allSubclasses do: [ :each |
				each isAbstract ifFalse: [
					each addToSuiteFromSelectors: suite ] ].
			suite]
		ifFalse: [ cls addToSuiteFromSelectors: suite ]
! !

!TestCase class methodsFor: 'Building Suites' stamp: 'nk 4/21/2002 10:51'!
addToSuite: suite fromMethods: testMethods 
	testMethods do:  [ :selector | 
			suite addTest: (self selector: selector) ].
	^suite! !

!TestCase class methodsFor: 'Building Suites' stamp: 'nk 4/21/2002 16:37'!
addToSuiteFromSelectors: suite
	^self addToSuite: suite fromMethods: (self shouldInheritSelectors
		ifTrue: [ self allTestSelectors ]
		ifFalse: [self testSelectors ])! !

!TestCase class methodsFor: 'Building Suites' stamp: 'nk 12/23/2002 07:40'!
buildSuite
	| suite |
	suite _ TestSuite new.
	^ self isAbstract
		ifTrue: [
			suite name: self name asString.
			self allSubclasses
				do: [:each | each isAbstract
						ifFalse: [each addToSuiteFromSelectors: suite]].
			suite]
		ifFalse: [self addToSuiteFromSelectors: suite]! !

!TestCase class methodsFor: 'Building Suites'!
buildSuiteFromAllSelectors

	^self buildSuiteFromMethods: self allTestSelectors
			! !

!TestCase class methodsFor: 'Building Suites'!
buildSuiteFromLocalSelectors

	^self buildSuiteFromMethods: self testSelectors
			! !

!TestCase class methodsFor: 'Building Suites' stamp: 'nk 4/21/2002 10:52'!
buildSuiteFromMethods: testMethods 
	| suite |
	suite _ (TestSuite new)
				name: self name asString;
				yourself.
	^self addToSuite: suite fromMethods: testMethods! !

!TestCase class methodsFor: 'Building Suites'!
buildSuiteFromSelectors

	^self shouldInheritSelectors
		ifTrue: [self buildSuiteFromAllSelectors]
		ifFalse: [self buildSuiteFromLocalSelectors]
			! !

!TestCase class methodsFor: 'Building Suites'!
suiteClass
	^TestSuite
			! !


!TestCase class methodsFor: 'Instance Creation'!
debug: aSymbol

	^(self selector: aSymbol) debug
			! !

!TestCase class methodsFor: 'Instance Creation' stamp: 'HAW 3/3/2017 18:51:38'!
debugAsFailure: aSymbol ifCanNot: handler

	^(self selector: aSymbol) debugAsFailureIfCanNot: handler
	! !

!TestCase class methodsFor: 'Instance Creation'!
run: aSymbol

	^(self selector: aSymbol) run
			! !

!TestCase class methodsFor: 'Instance Creation'!
selector: aSymbol

	^self new setTestSelector: aSymbol
			! !


!TestCase class methodsFor: 'Testing' stamp: 'HAW 2/10/2017 16:32:10'!
is: aSymbol

	^self ~= TestCase 
		and: [ aSymbol == #TestCaseClass or: [ super is: aSymbol ]]! !

!TestCase class methodsFor: 'Testing' stamp: 'jmv 2/2/2010 09:27'!
isAbstract
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^self name = #TestCase
			! !

!TestCase class methodsFor: 'Testing' stamp: 'HAW 2/1/2017 19:35:57'!
shouldInheritSelectors
	"I should inherit from an Abstract superclass but not from a concrete one by default, unless I have no testSelectors in which case I must be expecting to inherit them from my superclass.  If a test case with selectors wants to inherit selectors from a concrete superclass, override this to true in that subclass."

	^self ~= TestCase 
		and: [ self superclass isAbstract or: [self testSelectors isEmpty]]

"$QA Ignore:Sends system method(superclass)$"
			! !


!TestCase class methodsFor: 'Error Descriptions' stamp: 'HAW 3/3/2017 16:33:00'!
canNotDebugMethodErrorDescription

	^'Quick methods can not be debugged'! !
