//
//  Storable.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - Enum

/// Used to specify the location of cache storage
public struct StorageMode: OptionSet {
    
    public let rawValue: Int
    
    public init(rawValue: Self.RawValue) {
        self.rawValue = rawValue
    }
    
    /// Storage on disk
    public static let disk = StorageMode(rawValue: 1 << 0)
    
    /// Cached on memory
    public static let memory = StorageMode(rawValue: 1 << 1)
    
    /// `.disk` & `.memory`
    public static let all: StorageMode = [ .disk, .memory ]
}

// MARK: - Protocol

/// Used to store logs
public protocol Storable {
    
    /// Storage mode, the default is `.all`. Namely disk cache and memory cache
    static var storageMode: StorageMode { get }
    
    /// An array to store all logs. See the `store(_:)` method for details
    static var logs: [LogModel] { get set }
    
    /// The full path of the log storage file on the disk.
    ///
    /// The default storage path of RaLog is as follows (log is stored in days),
    /// and you can customize the storage path through this attribute.
    ///
    /// ```swift
    /// let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/"
    /// let fileFullPath = dirPath + "log/\(date).log"
    /// ```
    static var filePath: String { get }
    
    /// Store log
    ///
    /// The default implementation will do the following:
    ///
    /// * When `storageMode` contains `.memory`, Append `log` to `logs`.
    /// * When `storageMode` contains `.disk`, Serialize `log` to JSON and appended to the end of the `filePath`.
    ///
    /// - Note:
    ///     On the whole, the logs are stored in the `.log` file in the form of a JSON array.
    ///
    /// - Attention:
    ///     The above operations are effective in both `DEBUG` and `RELEASE` modes. You can implement this method yourself to change this logic.
    ///
    /// - Parameter log: The `LogModel` to be stored
    static func store(_ log: LogModel)
    
    /// Read the log data of the date corresponding to `logDate` cached in the disk
    ///
    /// The default implementation realizes the function of reading the log data of the day by default by adding the default parameter of `logDate = Date()`
    ///
    /// - Note:
    ///     The default implementation does not determine the `storageMode` attribute. That is, when `storageMode` does not contain `.disk`, it will still try to read log data from the disk
    ///
    /// - Parameter logDate: Date of the log to be read. When an error occurs, it will return `nil`
    static func readLogFromDisk(logDate: Date) -> [LogModel]?
    
    /// Delete the log data of the date corresponding to `logDate` cached in the disk
    ///
    /// The default implementation realizes the function of deleting the log data of the day by default by adding the default parameter of `logDate = Date()`
    ///
    /// - Note:
    ///     The default implementation does not determine the `storageMode` attribute. That is, when `storageMode` does not contain `.disk`, it will still try to delete log data from the disk
    ///
    /// - Parameter logDate: Date of the log to be read. When an error occurs, it will return `nil`
    /// - Return: When the deletion is successful, it will return `.success(())`, otherwise it will return an error message.
    static func removeLogFromDisk(logDate: Date) -> Result<Void, Error>
}

// MARK: - Extension

/// Strategy of break method execution
public enum BreakStrategy {
    
    /// Will not interrupt the method early
    case never
    
    /// Method execution will be interrupted after `count` errors
    case continuous(count: Int)
    
    /// Method execution will be interrupted after accumulating `count` errors
    case grandTotal(count: Int)
}

public extension Storable {
    
    /// Read the log of the previous `days`
    ///
    /// When `days` is 1, it means to read the log of the previous day, that is, the log of **yesterday**.
    /// When `days` is 2, it means to read the log of the previous 2 days, that is, the log of **days before yesterday**.
    /// And so on
    ///
    /// - Parameter days: Heaven number
    /// - Returns: Log data of the day
    static func readLogFromDisk(days: Int) -> [LogModel]? {
        
        let aTimeInterval = Date().timeIntervalSinceReferenceDate + Double(-days * 86400)
        return readLogFromDisk(logDate: Date(timeIntervalSinceReferenceDate: aTimeInterval))
    }
    
    /// Read logs at certain time points or time intervals.
    ///
    /// `days` can be a certain time interval (`ClosedRange<Int>`)
    /// For example, when `0 ... 7` is passed in, it means to get the log data of the previous 7 days (including the current day, ie 8 pieces of data).
    ///
    /// `days` can be certain time points (`[Int]`)
    /// For example, when `[1, 3, 5]` is passed in, it means to get the log data of 1 day ago, 3 days ago, and 5 days ago.
    ///
    /// - Note:
    ///     A positive number represents the time before the current date.
    ///
    /// - Attention:
    ///     The method will perform a `reversed()` operation on `days`.
    ///     Note the order of the elements in the collection of the parameter.
    ///
    /// - Parameters:
    ///   - days: Time point or time interval.
    ///   - strategy: Strategy of break method execution，See `BreakStrategy` for details. The default is `.never`.
    /// - Returns: The obtained log. When the whole is `nil`, it means that no log is obtained, and when the inner array is `nil`, it means that there is no log on that day.
    static func readLogFromDisk<T: Collection>(days: T, strategy: BreakStrategy = .never) -> [[LogModel]?]? where T.Element == Int {
        
        var logs: [[LogModel]?] = []
        var failureCount = 0
        
        for time in days.reversed() {
            
            let tmp = readLogFromDisk(days: time)
            
            switch strategy {
            case .never:
                logs.append(tmp)
                
            case .continuous(let count):
                if let log = tmp {
                    logs.append(log)
                    failureCount = 0
                    
                } else {
                    failureCount += 1
                    if failureCount >= count { break }
                }
                
            case .grandTotal(let count):
                if let log = tmp {
                    logs.append(log)
                    
                } else {
                    failureCount += 1
                    if failureCount >= count { break }
                }
            }
        }
        
        return logs.isEmpty ? nil : logs
    }
    
    /// Delete logs at certain time points or time intervals.
    ///
    /// `days` can be a certain time interval (`ClosedRange<Int>`)
    /// For example, when `0 ... 7` is passed in, it means to delete the log data of the previous 7 days (including the current day, that is, 8 data).
    ///
    /// `days` can be certain time points (`[Int]`)
    /// For example, when `[1, 3, 5]` is passed in, it means to delete the log data of 1 day ago, 3 days ago, and 5 days ago.
    ///
    /// - Note:
    ///     A positive number represents the time before the current date.
    ///
    /// - Parameters:
    ///   - days: Time point or time interval.
    ///   - strategy: Strategy of break method execution，See `BreakStrategy` for details. The default is `.never`.
    ///   - completeBlock: The callback will be called multiple times. Regardless of the value of "strategy", an additional callback will be made at the end `(true, nil)`.
    static func removeLogFromDisk<T: Collection>(
        days: T,
        strategy: BreakStrategy = .never,
        complete completeBlock: ((_ isComplete: Bool, Error?) -> Void)? = nil
    ) where T.Element == Int {
        
        defer { completeBlock?(true, nil) }
        
        var failureCount = 0
        
        for time in days {
            
            let aTimeInterval = Date().timeIntervalSinceReferenceDate + Double(-time * 86400)
            
            let result = removeLogFromDisk(logDate: Date(timeIntervalSinceReferenceDate: aTimeInterval))
            
            switch strategy {
            case .never:
                switch result {
                case .success(_): break
                case .failure(let error): completeBlock?(false, error)
                }
                
            case .continuous(let count):
                
                switch result {
                case .success(_):
                    
                    // reset to 0
                    failureCount = 0
                    
                case .failure(let error):
                    failureCount += 1
                    completeBlock?(false, error)
                    
                    if failureCount >= count { break }
                }
                
            case .grandTotal(let count):
                
                switch result {
                case .success(_): break
                case .failure(let error):
                    failureCount += 1
                    completeBlock?(false, error)
                    
                    if failureCount >= count { break }
                }
            }
        }
    }
}

// MARK: - Default

private var _logsKey = "_raLog_logsKey"

public extension Storable {
    
     static var logs: [LogModel] {
        get {
            guard let kLogs = objc_getAssociatedObject(self, &_logsKey) as? [LogModel] else {
                objc_setAssociatedObject(self, &_logsKey, [], .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return []
            }
            
            return kLogs
        }
        set {
            objc_setAssociatedObject(self, &_logsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    static var storageMode: StorageMode { .all }
    
    private static var dirPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/log"
    }
    
    private static var fileName: String {
        return "\(cacheDateFormatter.string(from: Date())).log"
    }
    
    static var filePath: String { dirPath + "/" + fileName }
    
    static func store(_ log: LogModel) {
        
        if storageMode.contains(.memory) {
            logs += [log]
        }
        
        guard storageMode.contains(.disk) else { return }
        
        guard let data = try? JSONEncoder().encode(log),
            var content = String(data: data, encoding: .utf8) else {
                
                // If the encoding fails, it will not be written to the file.
                return
        }
        
        content += ","
        
        var isDirectory: ObjCBool = true
        
        // Directory Exists
        if !FileManager.default.fileExists(atPath: dirPath, isDirectory: &isDirectory) {
            try? FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true)
        }
        
        isDirectory = false
        
        // File Exists
        if !FileManager.default.fileExists(atPath: filePath, isDirectory: &isDirectory) {
            FileManager.default.createFile(atPath: filePath, contents: nil)
            
            // Store as an array
            content = "[" + content
        }
        
        guard let resultData = (content + "]").data(using: .utf8),
            let fileHandle = FileHandle(forWritingAtPath: filePath) else { return }
        
        fileHandle.seekToEndOfFile()
        
        let offsetInFile = fileHandle.offsetInFile
        
        // Cover the last one "]"
        if _fastPath(offsetInFile > 1) {
            fileHandle.seek(toFileOffset: offsetInFile - 1)
        }
        
        // Write file in append form
        fileHandle.write(resultData)
        
        fileHandle.closeFile()
    }
    
    static func readLogFromDisk(logDate: Date = Date()) -> [LogModel]? {
        
        let filePath = dirPath + "/" + "\(cacheDateFormatter.string(from: logDate)).log"
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return nil }
        return try? JSONDecoder().decode([LogModel].self, from: data)
    }
    
    static func removeLogFromDisk(logDate: Date = Date()) -> Result<Void, Error> {
        
        do {
            
            let filePath = dirPath + "/" + "\(cacheDateFormatter.string(from: logDate)).log"
            
            try FileManager.default.removeItem(atPath: filePath)
            return .success(())
            
        } catch {
            return .failure(error)
        }
    }
}

// MARK: - Tools

private var _cacheDateFormatterKey = "_raLog_cacheDateFormatterKey"

fileprivate extension Storable {
    
    /// Cache `DateFormatter` object
    static var cacheDateFormatter: DateFormatter {
        get {
            guard let kCacheDateFormatter = objc_getAssociatedObject(self, &_cacheDateFormatterKey) as? DateFormatter else {
                
                let kCacheDateFormatter = DateFormatter()
                kCacheDateFormatter.dateFormat = "yyyy_MM_dd"
                
                objc_setAssociatedObject(self, &_cacheDateFormatterKey, kCacheDateFormatter, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return kCacheDateFormatter
            }
            
            return kCacheDateFormatter
        }
        set {
            objc_setAssociatedObject(self, &_cacheDateFormatterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
