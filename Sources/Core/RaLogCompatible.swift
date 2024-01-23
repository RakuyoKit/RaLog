//
//  RaLogCompatible.swift
//  RaLog
//
//  Created by Rakuyo on 2024/1/23.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import Foundation

/// Wrapper for RaLog compatible types.
/// This type provides an extension point for connivence methods in RaLog.
public struct RaLogWrapper<Base> {
    public var base: Base
    public init(_ base: Base) { self.base = base }
}

/// Represents an any type that is compatible with RaLog.
/// You can use `rl` property to get a value in the namespace of RaLog.
public protocol RaLogCompatible { }

public extension RaLogCompatible {
    /// Gets a namespace holder for Kingfisher compatible types.
    var rl: RaLogWrapper<Self> {
        get { return RaLogWrapper(self) }
        set { }
    }
}
