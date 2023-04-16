public func withEnoughCloseness<T: CloseEnoughable>(_ tolerance: T, work: () throws -> Void) rethrows {
    globalStorage[T.self] = tolerance
    defer { globalStorage.unregister(T.self) }
    try work()
}

public func withEnoughCloseness<T: CloseEnoughable>(_ tolerance: T, work: () async throws -> Void) async rethrows {
    globalStorage[T.self] = tolerance
    defer { globalStorage.unregister(T.self) }
    try await work()
}

public func withEnoughClosenesses(_ tolerances: KeyValuePairs<Any.Type, Any>, work: () throws -> Void) rethrows {
    for (type, tolerance) in tolerances {
        globalStorage.register(value: tolerance, forKey: ObjectIdentifier(type))
    }
    defer {
        for (type, _) in tolerances {
            globalStorage.unregister(ObjectIdentifier(type))
        }
    }
    try work()
}

public func withEnoughClosenesses(_ tolerances: KeyValuePairs<Any.Type, Any>, work: () async throws -> Void) async rethrows {
    for (type, tolerance) in tolerances {
        globalStorage.register(value: tolerance, forKey: ObjectIdentifier(type))
    }
    defer {
        for (type, _) in tolerances {
            globalStorage.unregister(ObjectIdentifier(type))
        }
    }
    try await work()
}
