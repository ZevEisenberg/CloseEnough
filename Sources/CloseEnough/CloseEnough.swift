import Foundation

/// Change this if you want. Remember to put it back when you're done.
public var enoughClosenessDouble = 0.01
public func resetDefaultEnoughClosenessDouble() {
    enoughClosenessDouble = 0.01
}

#if canImport(SwiftUI)
import SwiftUI
@available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
public var enoughClosenessAngle = Angle.degrees(0.01)
public func resetDefaultEnoughClosenessAngle() {
    enoughClosenessAngle = .degrees(0.01)
}

#endif

public func withEnoughCloseness(double: Double, work: () throws -> Void) rethrows {
    enoughClosenessDouble = double
    defer { resetDefaultEnoughClosenessDouble() }
    try work()
}

public func withEnoughCloseness(double: Double, work: () async throws -> Void) async rethrows {
    enoughClosenessDouble = double
    defer { resetDefaultEnoughClosenessDouble() }
    try await work()
}

@propertyWrapper
public struct CloseEnough<Wrapped: Equatable>: Equatable {
    public var wrappedValue: Wrapped

    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool where Wrapped == Double {
        isTesting
            ? abs(lhs.wrappedValue - rhs.wrappedValue) < enoughClosenessDouble
            : lhs.wrappedValue == rhs.wrappedValue
    }
}

#if canImport(SwiftUI)
import SwiftUI
@available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
extension CloseEnough where Wrapped == Angle {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        isTesting
        ? abs(lhs.wrappedValue.degrees - rhs.wrappedValue.degrees) < enoughClosenessAngle.degrees
        : lhs.wrappedValue == rhs.wrappedValue
    }
}

// Angle

@available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
public func withEnoughCloseness(angle: Angle, work: () throws -> Void) rethrows {
    enoughClosenessAngle = angle
    defer { resetDefaultEnoughClosenessDouble() }
    try work()
}

@available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
public func withEnoughCloseness(angle: Angle, work: () async throws -> Void) async rethrows {
    enoughClosenessAngle = angle
    defer { resetDefaultEnoughClosenessDouble() }
    try await work()
}

// Angle and Double

@available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
public func withEnoughCloseness(angle: Angle, double: Double, work: () throws -> Void) rethrows {
    enoughClosenessAngle = angle
    enoughClosenessDouble = double
    defer {
        resetDefaultEnoughClosenessAngle()
        resetDefaultEnoughClosenessDouble()
    }
    try work()
}

@available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
public func withEnoughCloseness(angle: Angle, double: Double, work: () async throws -> Void) async rethrows {
    enoughClosenessAngle = angle
    enoughClosenessDouble = double
    defer {
        resetDefaultEnoughClosenessAngle()
        resetDefaultEnoughClosenessDouble()
    }
    try await work()
}
#endif

private let isTesting = NSClassFromString("XCTestCase") != nil
