//
//  Extendable.swift
//  RaLog
//
//  Created by Rakuyo on 2020/11/23.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

public struct Extendable<Base> {
    
    /// Base object to extend.
    public var base: Base
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) { self.base = base }
}

/// A type that has extendable extensions.
public protocol ExtendableCompatible {
    
    /// Extended type
    associatedtype CompatibleType
    
    /// Extendable extensions.
    static var rl: Extendable<CompatibleType>.Type { get set }
    
    /// Extendable extensions.
    var rl: Extendable<CompatibleType> { get set }
}

extension ExtendableCompatible {
    
    /// Extendable extensions.
    public static var rl: Extendable<Self>.Type {
        get { return Extendable<Self>.self }
        set { /* this enables using Extendable to "mutate" base type */ }
    }
    
    /// Extendable extensions.
    public var rl: Extendable<Self> {
        get { return Extendable(self) }
        set { /* this enables using Extendable to "mutate" base object */ }
    }
}
