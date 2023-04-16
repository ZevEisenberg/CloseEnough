import Foundation

/// Annotated types are compared with a tolerance value when using `==` inside of XCTests. In non-test code, comparison is done using the wrapped type’s `Equatable` conformance.
@propertyWrapper
public struct CloseEnough<Wrapped: CloseEnoughable>: Equatable {
    public var wrappedValue: Wrapped

    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        if isTesting {
            let tolerance: Wrapped = globalStorage[Wrapped.self]
            return lhs.wrappedValue.isApproximatelyEqual(to: rhs.wrappedValue, tolerance: tolerance)
        } else {
            return lhs.wrappedValue == rhs.wrappedValue
        }
    }
}

private let isTesting = NSClassFromString("XCTestCase") != nil
