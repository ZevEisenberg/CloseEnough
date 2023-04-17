import XCTest
import CloseEnough

final class ForgotToRegisterTests: XCTestCase {
    
    func testDouble() {
        struct MyThing: Equatable {
            @CloseEnough var foo: Double
        }
        
        let thing = MyThing(foo: 1)
        
        XCTExpectFailure {
            withPrecisions([:]) {
                // compare to itself, so this would pass except that we forgot to register
                XCTAssertEqual(thing, thing)
            }
        }
    }
}
