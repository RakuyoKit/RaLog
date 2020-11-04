//
//  Logger.swift
//  Examples
//
//  Created by MBCore on 2020/9/2.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaLog

extension Log.Flag {
    
    static let curry: Log.Flag = "⭐️ Curry"
    static let note : Log.Flag = "💥 Note"
}

public extension Printable {

    @inline(__always) @discardableResult
    static func note(
        _ kLog: Any?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        return p(kLog, module: module, file: file, function: function, line: line)(.note)
    }
}

enum Logger: Printable, Storable, Filterable {
    
    static func format(_ log: LogModelProtocol) -> String {
        
        // Custom print style
        return """
        
        [\(log.module)][\(log.file)_\(log.function):\(log.line)] \(log.formatTime) <\(log.flag)>: \(log.safeLog)
        """
    }
}
