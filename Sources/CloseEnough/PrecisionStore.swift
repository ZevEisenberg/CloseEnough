import XCTestDynamicOverlay

struct PrecisionStore {
    private var storage: [ObjectIdentifier: Any] = [:]

    subscript<T: EquatableWithPrecision>(_ type: T.Type) -> T.Precision? {
        guard let anyPrecision = storage[ObjectIdentifier(type)] else {
            XCTFail("Attempt to compare values of type \(T.self) without first registering precision for that type. Use 'withPrecisions(_:tests:)' and pass a type/precision pair for each type.")
            return nil
        }
        guard let precision = anyPrecision as? T.Precision else {
            XCTFail("Stored precision value \(anyPrecision) of type \(Swift.type(of: anyPrecision)) was not of expected type \(T.Precision.self), as specified by its \((any EquatableWithPrecision).self) conformance.")
            return nil
        }
        return precision
    }

    mutating func register(value: Any, forKey key: ObjectIdentifier) {
        storage[key] = value
    }

    @TaskLocal static var taskLocal = PrecisionStore()
}
