//
//  Flag.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// Built-in log identifier
public extension LogModel.Flag {
    
    static let debug      : LogModel.Flag = "👾 Debug"
    static let warning    : LogModel.Flag = "⚠️ Warning"
    static let success    : LogModel.Flag = "✅ Success"
    static let error      : LogModel.Flag = "❌ Error"
    static let `deinit`   : LogModel.Flag = "⁉️ Deinit"
    static let jump       : LogModel.Flag = "👋 Jump"
    static let javascript : LogModel.Flag = "🔥 Javascript"
}
