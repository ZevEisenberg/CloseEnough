import XCTest
import CloseEnough

#if canImport(SwiftUI)
import SwiftUI
final class CloseEnoughAngleTests: XCTestCase {

    func testCloseEnoughAngle_Degrees() {
        struct MyThing: Equatable {
            @CloseEnough var foo: Angle
        }

        let a = MyThing(foo: .degrees(1))
        let b = MyThing(foo: .degrees(1.0002))

        XCTAssertEqual(a, b) // use default closeness

        withEnoughCloseness(angle: .degrees(0.001)) {
            XCTAssertEqual(a, b)
        }

        withEnoughCloseness(angle: .degrees(0.0001)) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }

    func testCloseEnoughAngle_Radians() {
        struct MyThing: Equatable {
            @CloseEnough var foo: Angle
        }

        let a = MyThing(foo: .radians(1))
        let b = MyThing(foo: .radians(1.0002))

        XCTExpectFailure {
            XCTAssertEqual(a, b) // use default closeness
        }

        withEnoughCloseness(angle: .radians(0.001)) {
            XCTAssertEqual(a, b)
        }

        withEnoughCloseness(angle: .radians(0.0001)) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }
}
#endif