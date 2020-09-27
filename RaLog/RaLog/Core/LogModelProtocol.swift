//
//  LogModelProtocol.swift
//  RaLog
//
//  Created by Rakuyo on 2020/9/27.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

public protocol LogModelProtocol: Codable {
    
    /// The actual content to be printed.
    var log: Any? { get set }
    
    /// Use the string "nil" to unpack the `log` attribute.
    var safeLog: String { get }
    
    /// The name of the file to print the log.
    var file: String { get set }
    
    /// The name of the method to print the log.
    var function: String { get set }
    
    /// The number of the lines to print the log.
    var line: Int { get set }
    
    /// Flag of log.
    var flag: Log.Flag { get set }
    
    /// The module to which the log belongs.
    var module: String { get set }
    
    /// Time to print.
    var formatTime: String { get }
}
