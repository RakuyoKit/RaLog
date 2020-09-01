//
//  LogFlag.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation
import struct CoreGraphics.CGFloat
import class UIKit.UIColor

public struct LogFlag: Hashable, Codable {
    
    public init(
        _ identifier: String,
        color: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? = nil
    ) {
        
        self.identifier = identifier
        
        if let color = color {
            self.color = Color(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)
        } else {
            self.color = nil
        }
    }
    
    public let identifier: String
    
    public let color: Color?
}

public extension LogFlag {
    
    struct Color: Hashable, Codable {
        public let red:   CGFloat
        public let green: CGFloat
        public let blue:  CGFloat
        public let alpha: CGFloat
        
        public var uiColor: UIColor { UIColor(red: red, green: green, blue: blue, alpha: alpha) }
    }
}
