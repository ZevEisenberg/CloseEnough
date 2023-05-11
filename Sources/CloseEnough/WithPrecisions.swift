public func withPrecisions(_ precisions: KeyValuePairs<Any.Type, Any>, tests: () throws -> Void) rethrows {
    for (type, precision) in precisions {
        globalPrecisionStore.register(value: precision, forKey: ObjectIdentifier(type))
    }
    defer {
        for precision in precisions {
            globalPrecisionStore.unregister(ObjectIdentifier(type(of: precision)))
        }
    }
    try tests()
}

public func withPrecisions(_ precisions: KeyValuePairs<Any.Type, Any>, tests: () async throws -> Void) async rethrows {
    for (type, precision) in precisions {
        globalPrecisionStore.register(value: precision, forKey: ObjectIdentifier(type))
    }
    defer {
        for precision in precisions {
            globalPrecisionStore.unregister(ObjectIdentifier(type(of: precision)))
        }
    }
    try await tests()
}
