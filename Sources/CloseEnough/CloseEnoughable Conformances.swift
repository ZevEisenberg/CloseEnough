extension Comparable where Self: CloseEnoughable & SignedNumeric {
    public func isApproximatelyEqual(to other: Self, tolerance: Self) -> Bool {
        abs(self - other) < tolerance
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
extension Float16: CloseEnoughable {}

extension Float: CloseEnoughable {}
extension Double: CloseEnoughable {}

#if canImport(SwiftUI)
import SwiftUI
extension Angle: CloseEnoughable {
    public func isApproximatelyEqual(to other: Angle, tolerance: Angle) -> Bool {
        abs(self.degrees - other.degrees) < tolerance.degrees
    }
}
#endif
