//
//  RaLogCompatible.swift
//  RaLog
//
//  Created by Rakuyo on 2024/1/23.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - RaLogWrapper

/// Wrapper for RaLog compatible types.
/// This type provides an extension point for connivence methods in RaLog.
public struct RaLogWrapper<Base> {
    public var base: Base
    public init(_ base: Base) { self.base = base }
}

// MARK: - RaLogCompatible

/// Represents an any type that is compatible with RaLog.
/// You can use `rl` property to get a value in the namespace of RaLog.
public protocol RaLogCompatible { }

extension RaLogCompatible {
    /// Gets a namespace holder for Kingfisher compatible types.
    public var rl: RaLogWrapper<Self> {
        get { RaLogWrapper(self) }
        // swiftlint:disable:next unused_setter_value
        set { /* this enables using `RaLogCompatible` to "mutate" base type */ }
    }
}
