public func withPrecisions(_ precisions: KeyValuePairs<Any.Type, Any>, tests: () throws -> Void) rethrows {
    var store = PrecisionStore()

    for (type, precision) in precisions {
        store.register(value: precision, forKey: ObjectIdentifier(type))
    }

    try! PrecisionStore.$taskLocal.withValue(store) {
        try tests()
    }
}

public func withPrecisions(_ precisions: KeyValuePairs<Any.Type, Any>, tests: () async throws -> Void) async rethrows {
    var store = PrecisionStore()

    for (type, precision) in precisions {
        store.register(value: precision, forKey: ObjectIdentifier(type))
    }

    try! await PrecisionStore.$taskLocal.withValue(store) {
        try await tests()
    }
}
