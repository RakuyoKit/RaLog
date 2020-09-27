//
//  Log.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// A model for storing log data.
///
/// It can also be used to perform some log operations.
/// See `Printable`, `Storable` and `Filterable` to learn more.
open class Log: LogModelProtocol, Printable, Storable, Filterable {
    
    /// Log identifier.
    public typealias Flag = String
    
    public init(_ log: Any?, file: String, function: String, line: Int, flag: Flag, module: String? = nil) {
        
        self.log = log
        self.function = function
        self.line = line
        self.flag = flag
        
        self.safeLog = "\(log ?? "nil")"
        self.formatTime = Log.formatter.string(from: Date(timeIntervalSince1970: timestamp))
        
        if _fastPath(file.contains("/")) {
            
            let components = file.components(separatedBy: "/")
            
            self.file = components.last ?? "Failed to get file"
            
            if let module = module  {
                self.module = module
            }
            
            // Use the first-level subdirectory under the pods path as the module name
            else if let index = components.firstIndex(of: "Pods") {
                self.module = components[index + 1]
            }
            
            else {
                self.module = "RaLog"
            }
            
        } else {
            self.file = file
            self.module = module ?? "RaLog"
        }
    }
    
    /// The actual content to be printed.
    open var log: Any?
    
    /// Use the string "nil" to unpack the `log` attribute.
    public let safeLog: String
    
    /// The name of the file to print the log.
    open var file: String
    
    /// The name of the method to print the log.
    open var function: String
    
    /// The number of the lines to print the log.
    open var line: Int
    
    /// Flag of log.
    open var flag: Flag
    
    /// The module to which the log belongs.
    open var module: String
    
    /// Timestamp when the model was created.
    ///
    /// Can be understood as the time when the log is printed.
    open var timestamp: TimeInterval = Date().timeIntervalSince1970
    
    /// `timestamp` after formatting with `HH:mm:ss:SSS`.
    public let formatTime: String
    
    /// What actually printed.
    open var logedStr: String = ""
}

private extension Log {
    
    enum CodingKeys: String, CodingKey {
        
        case file
        case function
        case line
        case flag
        case module
        case safeLog
        case timestamp
        case formatTime
        case logedStr
    }
}

// MARK: - Hashable

extension Log: Hashable {
    
    open func hash(into hasher: inout Hasher) {
        hasher.combine(timestamp)
        hasher.combine(line)
        hasher.combine(file)
        hasher.combine(safeLog)
        hasher.combine(logedStr)
    }
}

// MARK: - Equatable

extension Log: Equatable {
    
    public static func == (lhs: Log, rhs: Log) -> Bool {
        
        // The `timestamp` & `line` is enough to filter out most cases, and finally judge the `logedStr`.
        return lhs.timestamp == rhs.timestamp
            && lhs.line      == rhs.line
            && lhs.file  == rhs.file
            && lhs.safeLog   == rhs.safeLog
            && lhs.logedStr  == rhs.logedStr
    }
}

// MARK: - Tools

private extension Log {
    
    /// Cache `DateFormatter` object.
    static let formatter = { () -> DateFormatter in
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        dateFormatter.dateFormat = "HH:mm:ss:SSS"
        
        return dateFormatter
    }()
    
    static func encode<T>(displayInfo info: T) -> String? where T : Encodable {
        
        guard let data = try? JSONEncoder().encode(info),
            let infoString = String(data: data, encoding: .utf8) else {
                return nil
        }
        
        return infoString
    }
}
