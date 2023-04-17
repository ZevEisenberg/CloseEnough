import XCTest
import CloseEnough

#if canImport(SwiftUI)
import SwiftUI
final class MultipleTypesTests: XCTestCase {

    func testAngleAndDouble() {
        struct Inner: Equatable {
            @CloseEnough var double: Double
        }

        struct Outer: Equatable {
            @CloseEnough var angle: Angle
            @CloseEnough var double: Double
            var inner: Inner
        }

        let a = Outer(angle: .radians(1), double: 1.0002, inner: Inner(double: 123))
        let b = Outer(angle: .radians(1.0002), double: 1, inner: Inner(double: 123.0002))

        withPrecisions([
            Angle.self: Angle.radians(0.001),
            Double.self: 0.001,
        ]) {
            XCTAssertEqual(a, b)
        }

        withPrecisions([
            Angle.self: Angle.radians(0.0001),
            Double.self: 0.0001,
        ]) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }

}
#endif
