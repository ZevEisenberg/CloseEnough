import XCTest
import CloseEnough

#if canImport(SwiftUI)
import SwiftUI
final class CloseEnoughBothTests: XCTestCase {

    func testCloseEnough_angleAndDouble() {
        struct MyThing: Equatable {
            @CloseEnough var angle: Angle
            @CloseEnough var double: Double
        }

        let a = MyThing(angle: .radians(1), double: 1.0002)
        let b = MyThing(angle: .radians(1.0002), double: 1)

        withEnoughClosenesses([
            Angle.self: Angle.radians(0.001),
            Double.self: 0.001,
        ]) {
            XCTAssertEqual(a, b)
        }

        withEnoughClosenesses([
            Angle.self: Angle.radians(0.0001),
            Double.self: 0.0001
        ]) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }

}
#endif
