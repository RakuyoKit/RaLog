//
//  ViewModel.swift
//  RaLogDemo
//
//  Created by Rakuyo on 2020/09/02.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

import RaLog

// MARK: - ViewModel

class ViewModel {
    
    /// List data source
    lazy var dataSource: [SectionDataSource] = [
        SectionDataSource(title: "Basic", dataSource: [
            DataSource(title: "Request an api that will succeed") { _ in
                self.request(needSuccess: true, callback: { _ in })
                return (nil, false)
            },
            DataSource(title: "Request an api that will failure") { _ in
                self.request(needSuccess: false, callback: { _ in })
                return (nil, false)
            },
            DataSource(title: "Request an api with random results") {
                self.requestRandom(at: $0, callback: { _ in })
                return (nil, false)
            },
            DataSource(title: "Request multiple requests") { _ in
                self.requestMultipleRequests()
                return (nil, false)
            },
        ]),
        
        SectionDataSource(title: "Switch controller", dataSource: [
            DataSource(title: "Push another controller") { _ in
                
                (AnotherController(), true)
            },
            DataSource(title: "Present another controller") { _ in
                
                (UINavigationController(rootViewController: AnotherController()), false)
            },
        ]),
        
        SectionDataSource(title: "Custom Log", dataSource: [
            DataSource(title: "Curry") { _ in
                
                Logger.p("Use currying call form")(.curry)
                
                return (nil, false)
            },
            DataSource(title: "Custom Flag") { _ in
                
                Logger.note("This log is identified by '<\(Log.Flag.note)>'")
                
                return (nil, false)
            },
            DataSource(title: "Set Module separately for a log") { _ in
                
                Logger.note("Please note the changes in [Module]", module: "RaLog_Demo")
                
                return (nil, false)
            },
        ]),
        
        SectionDataSource(title: "Filter", dataSource: [
            DataSource(title: "Filter logs identified by debug") { _ in
                
                Log
                    .warning(
                        "The log with the debug flag will be filtered, and all future logs with the debug flag will not be printed on the console"
                    )
                Log.addFilter(flag: .debug)
                Log.debug("This log will not be printed on the console, so you will not see it")
                
                return (nil, false)
            },
            DataSource(title: "Cancel filter debug") { _ in
                
                Log.removeFilter(flag: .debug)
                Log.debug("You can see the log in the console!")
                
                return (nil, false)
            },
            DataSource(title: "Filter the logs of the current page") { _ in
                
                Log
                    .warning(
                        "About to filter the logs of the current page, all the logs of the current page will not be output in the console"
                    )
                
                Log.fileterCurrentFileLogs()
                
                Log.debug("This log will not be printed on the console, so you will not see it")
                Logger
                    .note(
                        "Unless another log manager is used to print logs (variables used to store filter conditions are not shared among each log manager)"
                    )
                
                return (nil, false)
            },
        ]),
        
        SectionDataSource(title: "Store", dataSource: [
            DataSource(title: "Read today's disk cache") { _ in
                
                (LogListViewController(logs: Log.readLogFromDisk()), true)
            },
            DataSource(title: "Clear today's disk cache") { _ in
                
                switch Log.removeLogFromDisk() {
                case .success:
                    Log.success("Clear the cache successfully")
                    
                case .failure(let error):
                    Log.error("Failed to clear cache: \(error)")
                }
                
                return (LogListViewController(logs: Log.readLogFromDisk()), true)
            },
            DataSource(title: "Read yesterday's disk cache") { _ in
                
                (LogListViewController(logs: Log.readLogFromDisk(days: 1)), true)
            },
        ]),
    ]
}

extension ViewModel {
    
    fileprivate enum RequestError: Error {
        case test
    }
    
    /// Request an api
    ///
    /// - Parameters:
    ///   - needSuccess: Whether the request should succeed
    ///   - callback: Callback request result
    private func request(needSuccess: Bool, callback: @escaping (Result<String, Error>) -> Void) {
        Log.warning("Please note that the api will be requested soon! 😎")
        
        // Analog api request
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            if needSuccess {
                let content = "api request succeeded"
                
                Log.success("request success 🥳, content: \(content)")
                
                callback(.success(content))
                
            } else {
                let error = RequestError.test
                
                Log.error("request failure 😢, error: \(error)")
                
                callback(.failure(error))
            }
        }
    }
    
    /// Request an api with random results
    ///
    /// - Parameters:
    ///   - index: Where the request was made
    ///   - callback: Callback request result
    private func requestRandom(at index: IndexPath, callback: @escaping (Result<String, Error>) -> Void) {
        Log.warning("Please note that an api with random results will be requested! 👻")
        
        // Analog api request
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let value = index.section + index.row
            
            let random = value + Int.random(in: 0 ... (100 - value))

            let result = random % value
            
            if result != 0 {
                let content = "\(random) % \(value) = \(result). And \(result) != 0, so api request succeeded"
                
                Log.success("request success 🥳, content: \(content)")
                
                callback(.success(content))
                
            } else {
                let error = RequestError.test
                
                Log.error("request failure 😢, \(random) % \(value) = \(result). And \(result) == 0, error: \(error)")
                
                callback(.failure(error))
            }
        }
    }
    
    private func requestMultipleRequests() {
        func _emulate(log content: String, after: Int) {
            DispatchQueue.global().async {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(after)) {
                    Log.debug(content)
                }
            }
        }
        
        _emulate(log: "First request", after: 1000)
        _emulate(log: "Second request", after: 1005)
        _emulate(log: "Third request", after: 1100)
        _emulate(log: "Fourth request", after: 1050)
    }
}
