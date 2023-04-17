import XCTestDynamicOverlay

struct PrecisionStore {
    private var storage: [ObjectIdentifier: Any] = [:]

    subscript<T: EquatableWithPrecision>(_ type: T.Type) -> T.Precision? {
        get {
            guard let anyPrecision = storage[ObjectIdentifier(type)] else {
                XCTFail("Attempt to compare values of type \(T.self) without first registering precision for that type")
                return nil
            }
            guard let precision = anyPrecision as? T.Precision else {
                XCTFail("Stored precision value \(anyPrecision) was not of expected type \(T.Precision.self)")
                return nil
            }
            return precision
        }
        set {
            storage[ObjectIdentifier(type)] = newValue
        }
    }

    mutating func unregister<T: EquatableWithPrecision>(_ type: T.Type) {
        storage.removeValue(forKey: ObjectIdentifier(type))
    }

    @_disfavoredOverload
    mutating func unregister(_ type: ObjectIdentifier) {
        storage.removeValue(forKey: type)
    }

    mutating func register(value: Any, forKey key: ObjectIdentifier) {
        storage[key] = value
    }

    @TaskLocal static var taskLocal = PrecisionStore()
}
