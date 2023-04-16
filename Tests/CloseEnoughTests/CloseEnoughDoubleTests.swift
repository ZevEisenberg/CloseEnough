import XCTest
import CloseEnough

final class CloseEnoughDoubleTests: XCTestCase {

    func testCloseEnoughDouble() {
        struct MyThing: Equatable {
            @CloseEnough var foo: Double
        }

        let a = MyThing(foo: 1)
        let b = MyThing(foo: 1.0002)

        withEnoughCloseness(0.001) {
            XCTAssertEqual(a, b)
        }

        withEnoughCloseness(0.0001) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }
}
