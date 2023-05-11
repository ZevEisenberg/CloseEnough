# CloseEnough

Tag your floating-point or floating-point-ish values with `@CloseEnoguh`, and then compare them with a given precision when using `XCTAssertEqual` on their parent structs. This is useful because, while `XCTAssertEqual` provides [a variant](https://developer.apple.com/documentation/xctest/2919914-xctassertequal) that takes a floating-point precision parameter, it doesn’t work with values inside structs, and it doesn’t work with your custom types. **CloseEnough** addresses both of these issues.

## Usage

To enable fuzzy comparison of your properties in tests, annotate them with the `@CloseEnough` property wrapper:

### Declaration

```swift
struct Outer: Equatable {
  @CloseEnough
  var foo: Double

  @CloseEnough
  var bar: Angle // SwiftUI's Angle type, for example

  var inner: Inner // it works for nested structs too!
}

struct Inner: Equatable {
    @CloseEnough
    var baz
}
```

### Test Code

You must provide a precision value for each type that is present in the structs (including nested structs) that you are comparing. Failure to do so will produce a test-time fatal error telling you which type(s) you forgot to express a precision for. If you want to compare with no fuzziness, supply a precision of 0 (or the [additive identity](https://en.wikipedia.org/wiki/Additive_identity) for your type).

```swift
// Tests
withPrecisions([
  Double.self: 0.0001,
  Angle.self: Angle.degrees(0.0001),
]) {
  XCTAssertEqual(
    someValue,
    Outer(
      foo: 1.5,
      bar: 0.2,
      inner: Inner(
        baz: 11
      )
    )
  )
}
```

## Custom Types

If you have a type that would benefit from close-enough comparison, conform it to the `EquatableWithPrecision` protocol and implement the required method, `isApproximatelyEqual(to:precision:)`. Then, you can use the `@CloseEnough` property wrapper in your own code!
