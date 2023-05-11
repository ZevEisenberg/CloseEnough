import XCTest
import CloseEnough

extension Date: EquatableWithPrecision {
    public func isApproximatelyEqual(to other: Date, precision: TimeInterval) -> Bool {
        abs(other.timeIntervalSince(self)) < precision
    }
}

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
