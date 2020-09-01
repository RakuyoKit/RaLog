//
//  Flag.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// Built-in log identifier
public extension Log.Flag {
    
    static let debug      : Log.Flag = "👾 Debug"
    static let warning    : Log.Flag = "⚠️ Warning"
    static let success    : Log.Flag = "✅ Success"
    static let error      : Log.Flag = "❌ Error"
    static let `deinit`   : Log.Flag = "⁉️ Deinit"
    static let jump       : Log.Flag = "👋 Jump"
    static let javascript : Log.Flag = "🔥 Javascript"
}
