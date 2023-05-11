import Foundation

/// Annotated types are compared with a precision value when using `==` inside of XCTests. In non-test code, comparison is done using the wrapped type’s `Equatable` conformance.
@propertyWrapper
public struct CloseEnough<Wrapped: EquatableWithPrecision>: Equatable {
    public var wrappedValue: Wrapped

    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        if isTesting,
           let precision: Wrapped.Precision = globalPrecisionStore[Wrapped.self] {
            return lhs.wrappedValue.isApproximatelyEqual(to: rhs.wrappedValue, precision: precision)
        } else {
            return lhs.wrappedValue == rhs.wrappedValue
        }
    }
}

private let isTesting = NSClassFromString("XCTestCase") != nil
