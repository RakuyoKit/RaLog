//
//  WebView+RaLog.swift
//  RaLog
//
//  Created by Rakuyo on 2020/11/23.
//  Copyright © 2021 Rakuyo. All rights reserved.
//

import WebKit

/// Wrapper for RaLog compatible types.
/// This type provides an extension point for connivence methods in RaLog.
public struct RaLogWrapper<Base> {
    public var base: Base
    public init(_ base: Base) { self.base = base }
}

/// Represents an any type that is compatible with RaLog.
/// You can use `rl` property to get a value in the namespace of RaLog.
public protocol RaLogCompatible { }

public extension RaLogCompatible {
    /// Gets a namespace holder for Kingfisher compatible types.
    var rl: RaLogWrapper<Self> {
        get { return RaLogWrapper(self) }
        set { }
    }
}

extension WKWebView: RaLogCompatible {}

public extension RaLogWrapper where Base: WKWebView {
    /// Add script to WKWebView for intercepting `console.log`.
    ///
    /// When the post closure is `nil` (default), the following method will be used to pass data to the native:
    ///
    /// ```swift
    /// window.webkit.messageHandlers.logHandler.postMessage(param);
    /// ```
    ///
    /// In this case, `message.name` is `logHandler`, `message.body` is `{ "content" : String, "stack" : String }`.
    ///
    /// When you choose to implement a post closure, the parameters of the closure are the `message.body` string dictionary mentioned above. You can choose to handle this parameter in any way you want and interact with the native in any way you want.
    ///
    /// - Parameters:
    ///   - post: Used to control how WebView passes logs to the native.
    ///   - injectionTime: When the script should be injected. Default is `.atDocumentEnd`
    ///   - isForMainFrameOnly: Whether the script should be injected into all frames or just the main frame. Default is `false`
    func addCaptureLogsScript(
        post: ((_ param: String) -> String)? = nil,
        injectionTime: WKUserScriptInjectionTime = .atDocumentEnd,
        isForMainFrameOnly: Bool = false
    ) {
        base.configuration.userContentController.addUserScript(WKUserScript(source: """
            console.log = (function(oriLogFunc){
            return function(str)
                {
                    var param = {'content':String(str), 'stack':String((new Error).stack)};
                    \(post?("param") ?? "window.webkit.messageHandlers.logHandler.postMessage(param);")
                    oriLogFunc.call(console,str);
                }
            })(console.log);
            """, injectionTime: injectionTime, forMainFrameOnly: isForMainFrameOnly))
    }
}

public extension Log.Flag {
    static let javascript : Log.Flag = "🔥 Javascript"
}

public extension Printable {
    @inline(__always) @discardableResult
    static func javascript(
        _ kLog: Any?, module: String? = nil, file: String = #file, function: String = #function, line: Int = #line
    ) -> Log {
        let _log = {
            return p($0, module: module, file: $1, function: function, line: $2)(.javascript)
        }
        
        guard let param = kLog as? [String : String], let content = param["content"] else {
            return _log(kLog, file, line)
        }
        
        guard let stack = param["stack"] else {
            return _log(content, file, line)
        }
        
        let _sepStack = stack.components(separatedBy: "\n")[1].components(separatedBy: ":")
        
        let _line = Int(_sepStack[2]) ?? line
        let _file = _sepStack[1].components(separatedBy: "/").last ?? file
        
        return _log(content, _file, _line)
    }
}
