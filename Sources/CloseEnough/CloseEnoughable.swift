import Foundation

public protocol CloseEnoughable: Equatable {
    func isApproximatelyEqual(to other: Self, tolerance: Self) -> Bool
}
