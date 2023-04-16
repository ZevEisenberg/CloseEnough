import Foundation

/// Change this if you want. Remember to put it back when you're done.
public var enoughCloseness = 0.01
public func resetDefaultEnoughCloseness() {
    enoughCloseness = 0.01
}

public func withEnoughCloseness(_ closeness: Double, work: () throws -> Void) rethrows {
    enoughCloseness = closeness
    defer { resetDefaultEnoughCloseness() }
    try work()
}

public func withEnoughCloseness(_ closeness: Double, work: () async throws -> Void) async rethrows {
    enoughCloseness = closeness
    defer { resetDefaultEnoughCloseness() }
    try await work()
}

@propertyWrapper
public struct CloseEnough: Equatable {
    public var wrappedValue: Double

    public init(wrappedValue: Double) {
        self.wrappedValue = wrappedValue
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        isTesting
            ? abs(lhs.wrappedValue - rhs.wrappedValue) < enoughCloseness
            : lhs.wrappedValue == rhs.wrappedValue
    }
}

private let isTesting = NSClassFromString("XCTestCase") != nil
