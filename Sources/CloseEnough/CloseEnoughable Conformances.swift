extension Comparable where Self: CloseEnoughable & SignedNumeric {
    public func isApproximatelyEqual(to other: Self, tolerance: Self) -> Bool {
        abs(self - other) < tolerance
    }
}

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
