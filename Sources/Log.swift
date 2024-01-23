//
//  Log.swift
//  RaLog
//
//  Created by Rakuyo on 2020/9/1.
//  Copyright © 2021 Rakuyo. All rights reserved.
//

import Foundation

/// Log data model. You can also perform log operations with this type.
///
/// See `Printable`, `Storable` and `Filterable` to learn more.
open class Log: LogModelProtocol, Printable, Storable, Filterable {
    /// Log identifier. RaLog uses this type to distinguish logs for different purposes.
    public typealias Flag = String
    public typealias Module = String
    
    public init(_ log: Any?, file: String, function: String, line: Int, flag: Flag, module: Module? = nil, identifier: String? = nil) {
        self.log = log
        self.function = function
        self.line = line
        self.flag = flag
        self.identifier = identifier
        
        self.safeLog = "\(log ?? "nil")"
        self.formatTime = Log.formatter.string(from: Date(timeIntervalSince1970: timestamp))
        
        if _fastPath(file.contains("/")) {
            let components = file.components(separatedBy: "/")
            self.file = components.last ?? "Failed to get file"
            
            if let module = module  {
                self.module = module
            }
            
            // Use the first-level subdirectory of the pods path as the module name.
            else if let index = components.firstIndex(of: "Pods") {
                self.module = components[index + 1]
            }
            else {
                self.module = Self.appName ?? "RaLog"
            }
            
        } else {
            self.file = file
            self.module = module ?? Self.appName ?? "RaLog"
        }
    }
    
    /// The raw data object to be printed by the user.
    open var log: Any?
    
    /// Use `"nil"` to unpack the `log` attribute.
    public let safeLog: String
    
    /// The name of the module to which the log belongs.
    open var module: Module
    
    /// The name of the file to which the log belongs.
    open var file: String
    
    /// The name of the function in which the log is located.
    open var function: String
    
    /// The line number where the log is located.
    open var line: Int
    
    /// Flag of log.
    open var flag: Flag
    
    /// The time stamp when the model was created.
    ///
    /// It can also be understood as the time to print this log.
    open var timestamp: TimeInterval = Date().timeIntervalSince1970
    
    /// Content after `timestamp` formatted using `HH:mm:ss:SSS`.
    public let formatTime: String
    
    /// The output in the console.
    open var logedStr: String = ""
    
    /// A unique identifier for the log.
    /// You are free to use this value to add certain tags to the log.
    public var identifier: String?
    
    /// Cache the name of the currently running app.
    private static let appName: String? = {
        let _infoDic: [String : Any]? = {
            if let infoDict = Bundle.main.localizedInfoDictionary {
                return infoDict
            }
            
            if let infoDict = Bundle.main.infoDictionary {
                return infoDict
            }
            
            if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
                let infoDict = NSDictionary(contentsOfFile: path) as? [String : Any] {
                return infoDict
            }
            
            return nil
        }()
        
        guard let infoDic = _infoDic else { return nil }
        
        let displayName = infoDic["CFBundleDisplayName"] as? String
        let bundleName = infoDic["CFBundleName"] as? String
        
        return displayName ?? bundleName
    }()
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
        case identifier
    }
}

// MARK: - Hashable

extension Log: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(timestamp)
        hasher.combine(line)
        hasher.combine(file)
        hasher.combine(safeLog)
        hasher.combine(logedStr)
        hasher.combine(identifier)
    }
}

// MARK: - Equatable

extension Log: Equatable {
    public static func == (lhs: Log, rhs: Log) -> Bool {
        // The `timestamp` & `line` is enough to filter out most cases, and finally judge the `logedStr`.
        return lhs.timestamp == rhs.timestamp
            && lhs.line == rhs.line
            && lhs.file == rhs.file
            && lhs.safeLog == rhs.safeLog
            && lhs.logedStr == rhs.logedStr
            && lhs.identifier == rhs.identifier
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
