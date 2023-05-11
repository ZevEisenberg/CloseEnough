import XCTest
import CloseEnough

final class CloseEnoughDoubleTests: XCTestCase {

    func testCloseEnoughDouble() {
        struct MyThing: Equatable {
            @CloseEnough var foo: Double
        }

        let a = MyThing(foo: 1)
        let b = MyThing(foo: 1.0002)

        XCTAssertEqual(a, b) // use default closeness

        withEnoughCloseness(double: 0.001) {
            XCTAssertEqual(a, b)
        }

        withEnoughCloseness(double: 0.0001) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }
}
