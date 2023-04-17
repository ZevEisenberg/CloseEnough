import XCTest
import CloseEnough

final class DateTests: XCTestCase {

    func testDate() {
        struct MyThing: Equatable {
            @CloseEnough var foo: Date
        }

        let a = MyThing(foo: Date(timeIntervalSince1970: 1234))
        let b = MyThing(foo: Date(timeIntervalSince1970: 1234.0002))

        withPrecisions([
            Date.self: 0.001,
        ]) {
            XCTAssertEqual(a, b)
        }

        withPrecisions([
            Date.self: 0.0001,
        ]) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }
}
