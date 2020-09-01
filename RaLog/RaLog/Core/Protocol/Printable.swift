//
//  Printable.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - Protocol

/// Provide the ability to format and print logs
public protocol Printable {
    
    /// Used to format the `log` parameter
    ///
    /// - Parameter log: The Log model contains all the information needed to print the Log. See `LogModel` for details
    /// - Returns: The formatted string can be printed directly
    @inline(__always)
    static func format(_ log: LogModel) -> String
    
    /// Print the `log` parameter
    ///
    /// The default implementation:
    ///
    /// 1. Call the `format(_:)` method to format the parameter `log` and assign it to `logedStr`
    /// 2. Determine whether the log needs to be filtered, and print the log when no filtering is required
    /// 3. Determine whether to store the log
    /// 4. Return the log model
    ///
    /// - Attention:
    ///     The first and second steps mentioned above are only effective in `DEBUG` mode. This means that the value of `logedStr` is meaningful only in `DEBUG` mode. You can change the implementation, for example, let it perform the same operation in `RELEASE` mode
    ///
    /// - Parameter log: The Log model contains all the information needed to print the Log. See `LogModel` for details
    /// - Returns: log model
    @inline(__always) @discardableResult
    static func print(_ log: LogModel) -> LogModel
}

// MARK: - Default

public extension Printable {
    
    @inline(__always)
    static func format(_ log: LogModel) -> String {
        
        return """
        
        [↓ In `\(log.methodName)` of \(log.fileName):\(log.line) ↓]
        [\(log.module)] \(log.formatTime) <\(log.flag.identifier)> : \(log.safeLog)
        
        """
    }
    
    @inline(__always) @discardableResult
    static func print(_ log: LogModel) -> LogModel {
        
        #if DEBUG
        
        // 1. store format log
        log.logedStr = self.format(log)
        
        // 2. filter
        if let filterable = self as? Filterable.Type, _slowPath(filterable.filter(log)) { /* do nothing */ } else {
            Swift.print(log.logedStr)
        }
        
        #endif
        
        // 3. store
        if let storable = self as? Storable.Type {
            storable.store(log)
        }
        
        // 4. return
        return log
    }
}
