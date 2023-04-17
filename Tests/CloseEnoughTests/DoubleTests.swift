import XCTest
import CloseEnough

final class DoubleTests: XCTestCase {

    func testDouble() {
        struct MyThing: Equatable {
            @CloseEnough var foo: Double
        }

        let a = MyThing(foo: 1)
        let b = MyThing(foo: 1.0002)

        withPrecisions([
            Double.self: 0.001,
        ]) {
            XCTAssertEqual(a, b)
        }

        withPrecisions([
            Double.self: 0.0001,
        ]) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }
}
