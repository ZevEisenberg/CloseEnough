struct PrecisionStore {
    private var storage: [ObjectIdentifier: Any] = [:]

    subscript<T>(_ type: T.Type) -> T {
        get {
            guard let value = storage[ObjectIdentifier(type)] else {
                fatalError("Attempt to compare values of type \(T.self) without first registering precision for that type")
            }
            guard let typed = value as? T else {
                fatalError("Stored precision value \(value) was not of expected type \(T.self)")
            }
            return typed
        }
        set {
            storage[ObjectIdentifier(type)] = newValue
        }
    }

    mutating func unregister<T>(_ type: T.Type) {
        storage.removeValue(forKey: ObjectIdentifier(type))
    }

    @_disfavoredOverload
    mutating func unregister(_ type: ObjectIdentifier) {
        storage.removeValue(forKey: type)
    }

    mutating func register(value: Any, forKey key: ObjectIdentifier) {
        storage[key] = value
    }
}

var globalPrecisionStore = PrecisionStore()
