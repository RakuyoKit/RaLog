<p align="center">
<img src="https://raw.githubusercontent.com/RakuyoKit/RaLog/master/Images/logo.png" alt="RaLog" title="RaLog" width="1000"/>
</p>

<p align="center">
<a><img src="https://img.shields.io/badge/language-swift-ffac45.svg"></a>
<a href="https://cocoapods.org/pods/RaLog"><img src="https://img.shields.io/github/v/tag/RakuyoKit/RaLog.svg?include_prereleases=&sort=semver"></a>
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a>
<a href="https://raw.githubusercontent.com/RakuyoKit/RaLog/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-black"></a>
</p>

> [中文](https://github.com/RakuyoKit/RaLog/blob/master/README_CN.md)
 
`RaLog` is a lightweight, highly customizable, protocol-oriented logging framework.

By using the types provided by the framework, or custom management classes, you can quickly build your own logging component.

## Requirements

- iOS 10.0+ / macOS 10.14+ / tvOS 12.0+ / watchOS 5.0+
- Swift 5.0+

## Install

### CocoaPods

```ruby
pod 'RaLog'
```

### Swift Package Manager

```swift
.Package(url: "https://github.com/RakuyoKit/RaLog.git", ...)
```

## Features

- [x] Out of the box, easy to configure.
- [x] Prints objects or values like `print` or `NSLog`.
- [x] Provides two caching modes: **disk cache** and **memory cache**.
- [x] Supports **filtering** log by file or log category.
- [x] **Protocol oriented**, provides a very high degree of freedom to customize logging operations.
- [x] can be used with [ColaCup](https://github.com/RakuyoKit/ColaCup) to view log data visually.

## Usage

For related content, see wiki: [Quick Start](https://github.com/RakuyoKit/RaLog/wiki/Quick-start).

## Preview

The following code shows how to use `RaLog` for simple log printing. With this code, you will get a first look at `RaLog`.

> More functional demos, as well as complete sample code, can be found in the demo provided with the repository (in the `Examples` directory).

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

When the `ViewController` controller is about to be accessed, the console will output the following.

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

`RaLog` is available under the **MIT** license. For more information, see [LICENSE](https://github.com/RakuyoKit/RaLog/blob/master/LICENSE).
