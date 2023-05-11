public func withPrecision<T: EquatableWithPrecision>(_ precision: T, tests: () throws -> Void) rethrows {
    globalPrecisionStore[T.self] = precision
    defer { globalPrecisionStore.unregister(T.self) }
    try tests()
}

public func withPrecision<T: EquatableWithPrecision>(_ precision: T, tests: () async throws -> Void) async rethrows {
    globalPrecisionStore[T.self] = precision
    defer { globalPrecisionStore.unregister(T.self) }
    try await tests()
}

public func withPrecisions(_ precisions: [Any], tests: () throws -> Void) rethrows {
    for precision in precisions {
        globalPrecisionStore.register(value: precision, forKey: ObjectIdentifier(type(of: precision)))
    }
    defer {
        for precision in precisions {
            globalPrecisionStore.unregister(ObjectIdentifier(type(of: precision)))
        }
    }
    try tests()
}

public func withPrecisions(_ precisions: [Any], tests: () async throws -> Void) async rethrows {
    for precision in precisions {
        globalPrecisionStore.register(value: precision, forKey: ObjectIdentifier(type(of: precision)))
    }
    defer {
        for precision in precisions {
            globalPrecisionStore.unregister(ObjectIdentifier(type(of: precision)))
        }
    }
    try await tests()
}
