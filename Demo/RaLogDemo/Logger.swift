//
//  Logger.swift
//  RaLogDemo
//
//  Created by Rakuyo on 2020/9/2.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import RaLog

extension Log.Flag {
    static let curry: Log.Flag = "⭐️ Curry"
    static let note: Log.Flag = "💥 Note"
}

extension Printable {
    @inline(__always) @discardableResult
    public static func note(
        _ kLog: Any?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        p(kLog, module: module, file: file, function: function, line: line)(.note)
    }
}

// MARK: - Logger

enum DemoLogger: Printable, Storable, Filterable {
    static func format(_ log: LogModelProtocol) -> String {
        // Custom print style
        """
        
        [\(log.module)][\(log.file)_\(log.function):\(log.line)] \(log.formatTime) <\(log.flag)>: \(log.safeLog)
        """
    }
}
