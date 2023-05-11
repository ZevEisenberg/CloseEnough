import Foundation

/// Conformers can answer the question, “are these two values equal within a given precision?”
public protocol EquatableWithPrecision: Equatable {
    /// Returns whether the receiver is equal to another value of the same type, within the given precision.
    /// - Parameters:
    ///   - other: another value of the same type for comparison.
    ///   - precision: the precision to use when comparing the two values. The mechanism of comparison is up to the conformer, but it is usually equivalent to `abs(self - other) < precision`.
    /// - Returns: whether the two values are close enough.
    func isApproximatelyEqual(to other: Self, precision: Self) -> Bool
}
