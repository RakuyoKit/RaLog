//
//  Wrapper.swift
//  RaLog
//
//  Created by Rakuyo on 2021/08/23.
//  Copyright © 2021 Rakuyo. All rights reserved.
//

import Foundation

/// A wrapper container to provide default global storage support for other types.
class Wrapper {
    /// Singleton object
    static let shared = Wrapper()
    
    @Atomic
    var logs: [LogModelProtocol] = []
    
    @Atomic
    var filteredFlags = Set<Log.Flag>()
    
    @Atomic
    var filteredFiles = Set<String>()
    
    let cacheDateFormatter = DateFormatter()
    
    init() {
        cacheDateFormatter.dateFormat = "yyyy_MM_dd"
    }
}

@propertyWrapper
struct Atomic<Value> {
    private var value: Value
    private let lock = NSLock()

    init(wrappedValue value: Value) {
        self.value = value
    }
    
    var wrappedValue: Value {
      get { return load() }
      set { store(newValue: newValue) }
    }
    
    func load() -> Value {
        lock.lock()
        defer { lock.unlock() }
        return value
    }
    
    mutating func store(newValue: Value) {
        lock.lock()
        defer { lock.unlock() }
        value = newValue
    }
}
