//
//  Built-in.swift
//  RaLog
//
//  Created by Rakuyo on 2020/9/1.
//  Copyright © 2021 Rakuyo. All rights reserved.
//

import Foundation

/// Built-in log identifier.
public extension Log.Flag {
    static let debug: Log.Flag = "👾 Debug"
    static let warning: Log.Flag = "⚠️ Warning"
    static let success: Log.Flag = "✅ Success"
    static let error: Log.Flag = "❌ Error"
    static let `deinit`: Log.Flag = "⁉️ Deinit"
    static let jump: Log.Flag = "👋 Jump"
}

/// Built-in prefix log.
///
/// e.g. `Log.debug(self)`.
public extension Printable {
    @inline(__always) @discardableResult
    static func p(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line, identifier: String? = nil
    ) -> (Log.Flag) -> Log {
        return { print(Log(kLog, file: file, function: function, line: line, flag: $0, module: module, identifier: identifier)) }
    }
}

public extension Printable {
    @inline(__always) @discardableResult
    static func debug(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line, identifier: String? = nil
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line, identifier: identifier)(.debug)
    }
    
    @inline(__always) @discardableResult
    static func warning(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line, identifier: String? = nil
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line, identifier: identifier)(.warning)
    }
    
    @inline(__always) @discardableResult
    static func success(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line, identifier: String? = nil
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line, identifier: identifier)(.success)
    }
    
    @inline(__always) @discardableResult
    static func error(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line, identifier: String? = nil
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line, identifier: identifier)(.error)
    }
    
    @inline(__always) @discardableResult
    static func `deinit`(
        _ obj: AnyObject?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line, identifier: String? = nil
    ) -> Log {
        
        let loged: Any = obj == nil ? "nil" : obj!
        return p("\(loged) was deinit", module: module, file: file, function: function, line: line, identifier: identifier)(.deinit)
    }
}

#if !os(watchOS) && canImport(UIKit)
import UIKit

public extension Printable {
    @inline(__always) @discardableResult
    static func appear<V: UIViewController>(
        _ controller: V, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line, identifier: String? = nil
    ) -> Log {
        return p("- Appear - \(type(of: controller))", module: module, file: file, function: function, line: line, identifier: identifier)(.jump)
    }
    
    @inline(__always) @discardableResult
    static func disappear<V: UIViewController>(
        _ controller: V, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line, identifier: String? = nil
    ) -> Log {
        return p("- Disappear - \(type(of: controller))", module: module, file: file, function: function, line: line, identifier: identifier)(.jump)
    }
}
#endif
