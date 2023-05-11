extension Float: CloseEnoughable {
    public func isApproximatelyEqual(to other: Float, tolerance: Float) -> Bool {
        abs(self - other) < tolerance
    }
}

extension Double: CloseEnoughable {
    public func isApproximatelyEqual(to other: Double, tolerance: Double) -> Bool {
        abs(self - other) < tolerance
    }
}

#if canImport(SwiftUI)
import SwiftUI
extension Angle: CloseEnoughable {
    public func isApproximatelyEqual(to other: Angle, tolerance: Angle) -> Bool {
        abs(self.degrees - other.degrees) < tolerance.degrees
    }
}
#endif
