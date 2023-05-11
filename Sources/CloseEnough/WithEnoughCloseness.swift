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

public func withEnoughClosenesses(_ tolerances: [Any], work: () throws -> Void) rethrows {
    for tolerance in tolerances {
        globalStorage.register(value: tolerance, forKey: ObjectIdentifier(type(of: tolerance)))
    }
    defer {
        for tolerance in tolerances {
            globalStorage.unregister(ObjectIdentifier(type(of: tolerance)))
        }
    }
    try work()
}

public func withEnoughClosenesses(_ tolerances: [Any], work: () async throws -> Void) async rethrows {
    for tolerance in tolerances {
        globalStorage.register(value: tolerance, forKey: ObjectIdentifier(type(of: tolerance)))
    }
    defer {
        for tolerance in tolerances {
            globalStorage.unregister(ObjectIdentifier(type(of: tolerance)))
        }
    }
    try await work()
}
