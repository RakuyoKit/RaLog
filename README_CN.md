<p align="center">
<img src="https://raw.githubusercontent.com/RakuyoKit/RaLog/master/Images/logo.png" alt="RaLog" title="RaLog" width="1000"/>
</p>

<p align="center">
<a href="https://swiftpackageindex.com/RakuyoKit/RaLog"><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FRakuyoKit%2FRaLog%2Fbadge%3Ftype%3Dswift-versions"></a>
<a href="https://swiftpackageindex.com/RakuyoKit/RaLog"><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FRakuyoKit%2FRaLog%2Fbadge%3Ftype%3Dplatforms"></a>
</p>
<p align="center">
<a href="https://cocoapods.org/pods/RaLog"><img src="https://img.shields.io/github/v/tag/RakuyoKit/RaLog.svg?include_prereleases=&sort=semver"></a>
<a href="https://raw.githubusercontent.com/RakuyoKit/RaLog/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-black"></a>
</p>

`RaLog` 是一个轻量级的，高可定制度的，面向协议的日志框架。

通过使用框架提供的类型，或者自定义管理类，您可以快速搭建自己的日志组件。

## 基本要求

- iOS 12.0+ / macOS 10.13+ / tvOS 12.0+ / watchOS 5.0+ / visionOS 1.0+
- Xcode 13.4+
- Swift 5.6+

## 安装

### CocoaPods

```ruby
pod 'RaLog'
```

### Swift Package Manager

```swift
.Package(url: "https://github.com/RakuyoKit/RaLog.git", ...)
```

## 功能

- [x] 开箱即用，配置简单。
- [x] 像 `print` 或 `NSLog` 一样打印对象或值。
- [x] 提供**磁盘缓存**与**内存缓存**两种缓存模式。
- [x] 支持按照文件或日志分类**过滤**日志。
- [x] **面向协议**，提供非常高的自由度，供您自定义日志操作。
- [x] 配合 [ColaCup](https://github.com/RakuyoKit/ColaCup)，可视化的查看日志数据。

## 使用

相关内容请参考 wiki: [快速开始](https://github.com/RakuyoKit/RaLog/wiki/快速开始)。

## 预览

下面的代码展示了如何使用 `RaLog` 进行简单的日志打印。借助这段代码，您将对 `RaLog` 有一个初步的了解：

> 更多功能的演示，以及完整的示例代码可以参考随仓库配套提供的 demo（在 `Examples` 目录下）。

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

当即将进入 `ViewController` 控制器时，控制台将输出如下内容：

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

`RaLog` 在 **MIT** 许可下可用。 有关更多信息，请参见 [LICENSE](https://github.com/RakuyoKit/RaLog/blob/master/LICENSE) 文件。
