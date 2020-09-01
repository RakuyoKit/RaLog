//
//  LogModel.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// Model for storing log
open class LogModel: Codable {
    
    public init(_ log: Any?, fileName: String, funcName: String, line: Int, flag: LogFlag, module: String) {
        
        self.log = log
        self.funcName = funcName
        self.line = line
        self.flag = flag
        self.module = module
        
        self.formatTime = LogModel.formatter.string(from: Date(timeIntervalSince1970: timestamp))
        
        if fileName.contains("/") {
            self.fileName = fileName.components(separatedBy: "/").last ?? "Failed to get file"
        } else {
            self.fileName = fileName
        }
        
        self.safeLog = "\(log ?? "nil")"
    }
    
    /// The actual content to be printed
    open var log: Any?
    
    /// Use the string "nil" to unpack the `log` attribute
    public let safeLog: String
    
    /// The name of the file to print the log
    open var fileName: String
    
    /// The name of the function to print the log
    open var funcName: String
    
    /// The number of the lines to print the log
    open var line: Int
    
    /// Flag of log
    open var flag: LogFlag
    
    /// The module to which the log belongs
    open var module: String
    
    /// Timestamp when the model was created
    ///
    /// Can be understood as the time when the log is printed
    open var timestamp: TimeInterval = Date().timeIntervalSince1970
    
    /// `timestamp` after formatting with `HH:mm:ss:SSS`
    public let formatTime: String
    
    /// What actually printed
    open var logedStr: String!
}

private extension LogModel {

    enum CodingKeys: String, CodingKey {
        
        case fileName
        case funcName
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

extension LogModel: Hashable {

    open func hash(into hasher: inout Hasher) {
        hasher.combine(timestamp)
        hasher.combine(line)
        hasher.combine(safeLog)
        hasher.combine(fileName)
        hasher.combine(formatTime)
        hasher.combine(module)
        hasher.combine(logedStr)
    }
}

// MARK: - Equatable

extension LogModel: Equatable {
    
    public static func == (lhs: LogModel, rhs: LogModel) -> Bool {
        
        // The `timestamp` & `line` is enough to filter out most cases, and finally judge the `logedStr`
        return lhs.timestamp  == rhs.timestamp
            && lhs.line       == rhs.line
            && lhs.safeLog    == rhs.safeLog
            && lhs.fileName   == rhs.fileName
            && lhs.formatTime == rhs.formatTime
            && lhs.module     == rhs.module
            && lhs.logedStr   == rhs.logedStr
    }
}

// MARK: - Tools

private extension LogModel {
    
    /// Cache `DateFormatter` object
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
