import XCTest
import CloseEnough

// A vector is a good example of a type where the distance between values is a different type than the value itself
private struct Vector3: Equatable {
    var x, y, z: Double

    func distance(to other: Self) -> Double {
        sqrt(
            pow(other.x - x, 2)
            + pow(other.y - y, 2)
            + pow(other.z - z, 2)
        )
    }
}

extension Vector3: EquatableWithPrecision {
    func isApproximatelyEqual(to other: Vector3, precision: Double) -> Bool {
        abs(distance(to: other)) < precision
    }
}

final class CustomTypeTests: XCTestCase {

    func testDate() {
        struct MyThing: Equatable {
            @CloseEnough var vector: Vector3
        }

        let a = MyThing(vector: Vector3(x: 1, y: 2, z: 3))
        let b = MyThing(vector: Vector3(x: 1.0002, y: 2.0002, z: 3.0002))

        withPrecisions([
            Vector3.self: 0.001,
        ]) {
            XCTAssertEqual(a, b)
        }

        withPrecisions([
            Vector3.self: 0.0001,
        ]) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }
}
