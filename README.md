# CloseEnough

Tag your floating-point or floating-point-ish values with `@CloseEnoguh`, and then compare them with a given precision when using `XCTAssertEqual` on their parent structs.

## Single-Type Comparisons

If you have structs with members of the same type (for example, `Double`), you can use `withPrecision` to compare them with a given precision:

### Declaration

```swift
struct Inner: Equatable {
    @CloseEnough
    var baz
}

struct Outer: Equatable {
  @CloseEnough
  var bar: Double

  @CloseEnough
  var baz: Double

  var inner: Inner // it works for nested structs too!
}
```

### Test Code

```swift
// Tests
withPrecision(0.0001) {
  XCTAssertEqual(someValue, Outer(foo: 1.5, bar: 0.2, inner: Inner(baz: 11))
}
```

## Multiple-Type Comparisons

If your structs have members of different types, you must provide a precision value for each type. Failure to do so will produce a test-time fatal error telling you which type(s) you forgot to express a precision for. If you want to compare exactly, supply a precision of 0 (or equivalent for your type).

### Declaration

```swift
struct MyStruct: Equatable {
  @CloseEnough
  var double: Double

  @CloseEnough
  var angle: Angle // SwiftUI's Angle type, for example
}
```

### Test Code

```swift
// Tests
withPrecisions([Angle.degrees(0.0001), 0.0001]) {
  XCTAssertEqual(someValue, MyStruct(double: 1.5, angle: .degrees(3)))
}
```

## Custom Types

If you have a type that would benefit from close-enough comparison, conform it to the `EquatableWithPrecision` protocol and implement the required method, `isApproximatelyEqual(to:precision:)`. Then, you can use the `@CloseEnough` property wrapper in your own code!
