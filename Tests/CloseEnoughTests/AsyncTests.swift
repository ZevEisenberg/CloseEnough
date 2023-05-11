import XCTest
import CloseEnough

@MainActor
final class AsyncTests: XCTestCase {

    func testDoubleAsync() async {
        struct MyThing: Equatable {
            @CloseEnough var foo: Double
        }

        func produceA() async -> MyThing {
            MyThing(foo: 1)
        }

        func produceB() async -> MyThing {
            MyThing(foo: 1.0002)
        }

        await withPrecisions([
            Double.self: 0.001,
        ]) {
            let a = await produceA()
            let b = await produceB()
            XCTAssertEqual(a, b)
        }

        await withPrecisions([
            Double.self: 0.0001,
        ]) {
            XCTExpectFailure()
            let a = await produceA()
            let b = await produceB()
            XCTAssertEqual(a, b)
        }
    }
}
