# RaLog

<p align="center">
<img src="https://raw.githubusercontent.com/rakuyoMo/RaLog/master/Images/logo.png" alt="RaLog" title="RaLog" width="1000"/>
</p>

<p align="center">
<a><img src="https://img.shields.io/badge/language-swift-ffac45.svg"></a>
<a href="https://github.com/rakuyoMo/RaLog/releases"><img src="https://img.shields.io/cocoapods/v/RaLog.svg"></a>
<a href="https://github.com/rakuyoMo/RaLog/blob/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/RaLog.svg?style=flat"></a>
</p>

> [中文](https://github.com/rakuyoMo/RaLog/blob/master/README_CN.md)
 
 `RaLog` is a protocol-oriented and highly customizable lightweight logging framework.

 By using the framework to provide default types or custom management classes, you can quickly build your own log component.

## Prerequisites

- **iOS 10 or later**.
- **Xcode 10.0 or later** required.
- **Swift 5.0 or later** required.

## Install

### CocoaPods

```ruby
pod 'RaLog'
```

## Features

- [x] Print objects or values like `print` or `NSLog`.
- [x] Provide **disk cache** and **memory cache** two cache modes.
- [x] Support **filter** log printing according to file or log identifier.
- [x] **Protocol-oriented**, provides a very high degree of freedom for you to customize log operations.
- [x] Out of the box, easy to configure.

## Usage

For related content, please refer to wiki: [Quick Start](https://github.com/rakuyoMo/RaLog/wiki/Quick-start).

## Preview

The following code shows how to use `RaLog` for simple log printing.

With this code, you can have a preliminary impression of `RaLog`:

> For more functions and complete sample code, please refer to the demo provided with the warehouse (under the `Examples` directory).

```swift
import UIKit
import RaLog

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Log.appear(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        Log.disappear(self)
    }
    
    deinit {
        Log.deinit(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Log.debug("Note the output of the console")
        
        Log.warning("Please note that the request is about to start！😎")
        
        // Analog api request
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            if success {
                Log.success("request success 🥳, content: api request succeeded")
                
            } else {
                Log.error("request failure 😢, error: \("some error")")
            }
        }
    }
}
```

When entering the `ViewController`, the console will output the following:

```

[↓ In `viewDidLoad()` of ViewController.swift:32 ↓]
[RaLog] 11:17:01:353 <👾 Debug> : Note the output of the console


[↓ In `viewDidLoad()` of ViewController.swift:36 ↓]
[RaLog] 11:17:01:356 <⚠️ Warning> : Please note that the request is about to start！😎


[↓ In `viewDidAppear(_:)` of ViewController.swift:16 ↓]
[RaLog] 11:17:01:370 <👋 Jump> : - Appear - ViewController


[↓ In `viewDidLoad()` of ViewController.swift:42 ↓]
[RaLog] 11:17:02:453 <✅ Success> : request success 🥳, content: api request succeeded

```

## License

`RaLog` is available under the **MIT** license. See the [LICENSE](https://github.com/rakuyoMo/RaLog/blob/master/LICENSE) file for more info.
