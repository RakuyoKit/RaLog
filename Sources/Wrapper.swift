//
//  Wrapper.swift
//  RaLog
//
//  Created by Rakuyo on 2021/8/23.
//  Copyright © 2021 Rakuyo. All rights reserved.
//

import Foundation

/// A wrapper container to provide default global storage support for other types.
class Wrapper {
    /// Singleton object
    static let shared = Wrapper()
    
    var logs: [LogModelProtocol] = []
    
    var filteredFlags = Set<Log.Flag>()
    
    var filteredFiles = Set<String>()
    
    let cacheDateFormatter = DateFormatter()
    
    init() {
        cacheDateFormatter.dateFormat = "yyyy_MM_dd"
    }
}
