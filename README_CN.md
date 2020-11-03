# RaLog

<p align="center">
<img src="https://raw.githubusercontent.com/rakuyoMo/RaLog/master/Images/logo.png" alt="RaLog" title="RaLog" width="1000"/>
</p>

<p align="center">
<a><img src="https://img.shields.io/badge/language-swift-ffac45.svg"></a>
<a href="https://github.com/rakuyoMo/RaLog/releases"><img src="https://img.shields.io/cocoapods/v/RaLog.svg"></a>
<a href="https://github.com/rakuyoMo/RaLog/blob/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/RaLog.svg?style=flat"></a>
</p>

`RaLog` 是一个面向协议的可高度定制的轻量级日志框架。

通过使用框架提供默认的类型，或者自定义管理类，您可以快速搭建自己的日志组件。

## 基本要求

- 运行 **iOS 10** 及以上版本的设备。
- 使用 **Xcode 10** 及以上版本编译。
- **Swift 5.0** 以及以上版本。

## 安装

### CocoaPods

```ruby
pod 'RaLog'
```

## 功能

- [x] 像 `print` 或 `NSLog` 一样打印对象或值。
- [x] 提供**磁盘缓存**与**内存缓存**两种缓存模式。
- [x] 支持按照文件或日志标识**过滤**日志打印。
- [x] **面向协议**，提供非常高的自由度，供您自定义日志操作。
- [x] 开箱即用，配置简单。

## 使用

相关内容请参考 wiki: [快速入门](https://github.com/rakuyoMo/RaLog/wiki/快速开始)。

## 预览

下面的代码展示了如何使用 `RaLog` 进行简单的日志打印。借助这段代码，您可以对 `RaLog` 有一个初步的印象：

> 更多功能，以及完整的示例代码可以参考随仓库配套提供的 demo（在 `Examples` 目录下）。

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

`RaLog` 在 **MIT** 许可下可用。 有关更多信息，请参见 [LICENSE](https://github.com/rakuyoMo/RaLog/blob/master/LICENSE) 文件。
