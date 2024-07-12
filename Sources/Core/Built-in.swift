//
//  Built-in.swift
//  RaLog
//
//  Created by Rakuyo on 2020/9/1.
//  Copyright © 2021 Rakuyo. All rights reserved.
//

import Foundation

/// Built-in log identifier.
extension Log.Flag {
    public static let debug: Log.Flag = "👾 Debug"
    public static let warning: Log.Flag = "⚠️ Warning"
    public static let success: Log.Flag = "✅ Success"
    public static let error: Log.Flag = "❌ Error"
    public static let `deinit`: Log.Flag = "⁉️ Deinit"
    public static let jump: Log.Flag = "👋 Jump"
}

/// Built-in prefix log.
///
/// e.g. `Log.debug(self)`.
extension Printable {
    @inline(__always) @discardableResult
    public static func p(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line,
        identifier: String? = nil
    ) -> (Log.Flag) -> Log {
        {
            // swiftlint:disable:next no_direct_standard_out_logs
            print(Log(kLog, file: file, function: function, line: line, flag: $0, module: module, identifier: identifier))
        }
    }
}

extension Printable {
    @inline(__always) @discardableResult
    public static func debug(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line,
        identifier: String? = nil
    ) -> Log {
        p(kLog, module: module, file: file, function: function, line: line, identifier: identifier)(.debug)
    }

    @inline(__always) @discardableResult
    public static func warning(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line,
        identifier: String? = nil
    ) -> Log {
        p(kLog, module: module, file: file, function: function, line: line, identifier: identifier)(.warning)
    }

    @inline(__always) @discardableResult
    public static func success(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line,
        identifier: String? = nil
    ) -> Log {
        p(kLog, module: module, file: file, function: function, line: line, identifier: identifier)(.success)
    }

    @inline(__always) @discardableResult
    public static func error(
        _ kLog: Any?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line,
        identifier: String? = nil
    ) -> Log {
        p(kLog, module: module, file: file, function: function, line: line, identifier: identifier)(.error)
    }

    @inline(__always) @discardableResult
    public static func `deinit`(
        _ obj: AnyObject?, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line,
        identifier: String? = nil
    ) -> Log {
        let loged: Any = obj.flatMap { $0 } ?? "nil"
        return p(
            "\(loged) was deinit",
            module: module,
            file: file,
            function: function,
            line: line,
            identifier: identifier
        )(.deinit)
    }
}

#if !os(watchOS) && canImport(UIKit)
import UIKit

extension Printable {
    @inline(__always) @discardableResult
    public static func appear<V: UIViewController>(
        _ controller: V, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line,
        identifier: String? = nil
    ) -> Log {
        p(
            "- Appear - \(type(of: controller))",
            module: module,
            file: file,
            function: function,
            line: line,
            identifier: identifier
        )(.jump)
    }

    @inline(__always) @discardableResult
    public static func disappear<V: UIViewController>(
        _ controller: V, module: Log.Module? = nil, file: String = #file, function: String = #function, line: Int = #line,
        identifier: String? = nil
    ) -> Log {
        p(
            "- Disappear - \(type(of: controller))",
            module: module,
            file: file,
            function: function,
            line: line,
            identifier: identifier
        )(.jump)
    }
}
#endif
