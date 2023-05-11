import Foundation

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
