import XCTest
import CloseEnough

final class WrongRegistrationTests: XCTestCase {

    struct MyThing: Equatable {
        @CloseEnough var foo: Double
    }

    let thing = MyThing(foo: 1)

    func testMissingRegistration() {
        XCTExpectFailure {
            withPrecisions([:]) {
                // compare to itself, so this would pass except that we forgot to register
                XCTAssertEqual(thing, thing)
            }
        }

        XCTExpectFailure {
            withPrecisions([
                Double.self: Date.distantPast, // intentionally wrong comparison type
            ]) {
                // compare to itself, so this would pass except that we forgot to register
                XCTAssertEqual(thing, thing)
            }
        }
    }

    func testWrongTypeRegistration() {
        XCTExpectFailure {
            withPrecisions([
                Double.self: Date.distantPast, // intentionally wrong comparison type
            ]) {
                // compare to itself, so this would pass except that we registered the wrong type
                XCTAssertEqual(thing, thing)
            }
        }
    }
}
