//
//  Built-in.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

/// Built-in log identifier
public extension Log.Flag {
    
    static let debug      : Log.Flag = "👾 Debug"
    static let warning    : Log.Flag = "⚠️ Warning"
    static let success    : Log.Flag = "✅ Success"
    static let error      : Log.Flag = "❌ Error"
    static let `deinit`   : Log.Flag = "⁉️ Deinit"
    static let jump       : Log.Flag = "👋 Jump"
    static let javascript : Log.Flag = "🔥 Javascript"
}

/// Built-in prefix log
///
/// e.g. `Log.debug(self)`
public extension Printable {
    
    @inline(__always) @discardableResult
    static func p(
        _ kLog: Any?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> (Log.Flag) -> Log {
        
        return { print(Log(kLog, file: file, function: function, line: line, flag: $0, module: module)) }
    }
}

public extension Printable {
    
    @inline(__always) @discardableResult
    static func debug(
        _ kLog: Any?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line)(.debug)
    }
    
    @inline(__always) @discardableResult
    static func warning(
        _ kLog: Any?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line)(.warning)
    }
    
    @inline(__always) @discardableResult
    static func success(
        _ kLog: Any?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line)(.success)
    }
    
    @inline(__always) @discardableResult
    static func error(
        _ kLog: Any?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line)(.error)
    }
    
    @inline(__always) @discardableResult
    static func javascript(
        _ kLog: Any?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line)(.javascript)
    }
    
    @inline(__always) @discardableResult
    static func `deinit`(
        _ obj: AnyObject?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        
        let loged: Any = obj == nil ? "nil" : obj!
        return p("\(loged) was deinit", module: module, file: file, function: function, line: line)(.deinit)
    }
    
    @inline(__always) @discardableResult
    static func appear<V: UIViewController>(
        _ controller: V, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        return p("- Appear - \(type(of: controller))", module: module, file: file, function: function, line: line)(.jump)
    }
    
    @inline(__always) @discardableResult
    static func disappear<V: UIViewController>(
        _ controller: V, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        return p("- Disappear - \(type(of: controller))", module: module, file: file, function: function, line: line)(.jump)
    }
}
