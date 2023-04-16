import Foundation

/// Conformers can answer the question, “are these two values equal within a given tolerance?”
public protocol CloseEnoughable: Equatable {
    /// Returns whether the receiver is equal to another value of the same type, within the given tolerance.
    /// - Parameters:
    ///   - other: another value of the same type for comparison.
    ///   - tolerance: the tolerance to use when comparing the two values. The mechanism of comparison is up to the conformer, but it is usually equivalent to `abs(self - other) < tolerance`.
    /// - Returns: whether the two values are close enough.
    func isApproximatelyEqual(to other: Self, tolerance: Self) -> Bool
}
