import XCTest
import CloseEnough

#if canImport(SwiftUI)
import SwiftUI
final class AngleTests: XCTestCase {

    func testAngleDegrees() {
        struct MyThing: Equatable {
            @CloseEnough var foo: Angle
        }

        let a = MyThing(foo: .degrees(1))
        let b = MyThing(foo: .degrees(1.0002))

        withPrecision(Angle.degrees(0.001)) {
            XCTAssertEqual(a, b)
        }

        withPrecision(Angle.degrees(0.0001)) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }

    func testAngleRadians() {
        struct MyThing: Equatable {
            @CloseEnough var foo: Angle
        }

        let a = MyThing(foo: .radians(1))
        let b = MyThing(foo: .radians(1.0002))

        withPrecision(Angle.radians(0.001)) {
            XCTAssertEqual(a, b)
        }

        withPrecision(Angle.radians(0.0001)) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }
}
#endif
