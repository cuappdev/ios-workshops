# 11/4/18 - Key-Value Observing in Swift

## What is Key-Value Observing (KVO)?
- KVO allows us to observe changes to an object and act on those changes when they happen
- Useful for communicating changes between models and views

→ fundamentals of Reactive Programming!

For example, assume we have a `Student` class as such:

    class Student: NSObject {
      var name: String = ""
      var gpa: Double = 0.0
    }

Let’s say we want to observe changes of properties such as the `Student`’s `gpa` and update a UI upon those changes.

In order to observe properties of a class it must inherit `NSObject`, and we must prefix instances of the class with `@objc`.

## Observable Properties

We now can set the `gpa` property to observable by declaring it as  `objc dynamic`, in order to work dynamically with Objective-C runtime. This ensures that it will send notifications when the property is changed:


    @objc dynamic var gpa = 0

Can also manually send notifications on setting of property:

    didChangeValue(for: KeyPath<_KeyValueCodingAndObserving, Value>)
    willChangeValue(for: KeyPath<_KeyValueCodingAndObserving, Value>)

**Key-Path Syntax:**


    let kp = \Student.gpa
    let kp2 = \.gpa


    var s = Student()
    s[keyPath: kp] = 4.0


    @objc var gpa = 0 {
      willSet { willChangeValue(for: \Student.gpa }
      didSet { didChangeValue(for: \.gpa) }
    }

Note: 

- **willSet** and **didSet** will never get called on setting the initial value of the property.


## Setting up Observers


    let observationToken = observe(KeyPath<_KeyValueCodingAndObserving, Value>, options: NSKeyValueObservingOptions) { (_KeyValueCodingAndObserving, NSKeyValueObservedChange<Value>) in
    
    }

**KeyPath:** the path of the property that you are observing
`options:` `**NSKeyValueObservingOptions**`**:** the values that will trigger the code block

  - `initial`: a notification should be sent to the observer immediately, before the observer registration method even returns
  - `old`: the previous attribute value
  - `new`: the new attribute value
  - `prior`: separate notifications should be sent to the observer before and after each change

_**NSKeyValueCodingAndObserving:** the observer itself
**NSKeyValueObservedChange<Value>:** represents the change in the value

  - optionals `oldValue` and `newValue`

