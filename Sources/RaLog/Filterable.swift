//
//  Filterable.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - Protocol

/// Provide a way to filter logs. 
public protocol Filterable {
    
    /// Actually responsible for filtering the log.
    ///
    /// The default implementation:
    ///
    /// ```swift
    /// return filteredFiles.contains(log.file) || filteredFlags.contains(log.flag)
    /// ```
    ///
    /// - Parameter log: Log that judged whether they need to be filtered.
    /// - Returns: Return `true` to prohibit printing.
    static func filter(_ log: LogModelProtocol) -> Bool
    
    // MARK: - Filter Flag
    
    /// Used to store the `Log.Flag` that needs to be filtered.
    ///
    /// You can refer to the following implementation:
    ///
    /// ```swift
    /// public var filteredFlags: Set<Log.Flag> = [] // Do not filter any type of logs by default
    /// public var filteredFlags: Set<Log.Flag> = [Log.Flag("A")] // Filter Log of A tag by default
    /// ```
    static var filteredFlags: Set<Log.Flag> { get set }
    
    /// Filter a `Log.Flag`.
    ///
    /// - Parameter flag: `Log.Flag` filtered.
    static func addFilter(flag: Log.Flag ...)
    
    /// Remove the filtering of a `Log.Flag`.
    ///
    /// - Parameter flag: `Log.Flag` whose filter is removed.
    static func removeFilter(flag: Log.Flag ...)
    
    // MARK: - Filter File
    
    /// Used to store the filtered file name.
    ///
    /// See the `fileterCurrentFileLogs()` method for details.
    static var filteredFiles: Set<String> { get set }
    
    /// Used to filter all logs of the current page.
    ///
    /// - Parameter file: file path. In the default implementation, a parameter tag of `file = #file` is added.
    static func fileterCurrentFileLogs(_ file: String)
}

// MARK: - Default

public extension Filterable {
    
    @inline(__always)
    static func filter(_ log: LogModelProtocol) -> Bool {
        return filteredFiles.contains(log.file) || filteredFlags.contains(log.flag)
    }
}

// MARK: Flag

public extension Filterable {
    
    static var filteredFlags: Set<Log.Flag> {
        get { Wrapper.shared.filteredFlags }
        set { Wrapper.shared.filteredFlags = newValue }
    }
    
    static func addFilter(flag: Log.Flag ...) {
        flag.forEach { filteredFlags.insert($0) }
    }
    
    static func removeFilter(flag: Log.Flag ...) {
        flag.forEach { filteredFlags.remove($0) }
    }
}

// MARK: File

public extension Filterable {
    
    static var filteredFiles: Set<String> {
        get { Wrapper.shared.filteredFiles }
        set { Wrapper.shared.filteredFiles = newValue }
    }
    
    static func fileterCurrentFileLogs(_ file: String = #file) {
        
        let fileName = Log("", file: file, function: "", line: 0, flag: Log.Flag(""), module: "").file
        filteredFiles.insert(fileName)
    }
}
