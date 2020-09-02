//
//  ViewModel.swift
//  RaLogExamples
//
//  Created by Rakuyo on 2020/09/02.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

import RaLog

class ViewModel {
    
    /// List data source
    lazy var dataSource: [SectionDataSource] = [
        
        SectionDataSource(title: "Request api", dataSource: [
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
            }
        ]),
        
        SectionDataSource(title: "Switch controller", dataSource: [
            DataSource(title: "Push another controller") { _ in
                
                return (AnotherController(), true)
            },
            DataSource(title: "Present another controller") { _ in
                
                return (UINavigationController(rootViewController: AnotherController()), false)
            }
        ])
    ]
}

private extension ViewModel {
    
    enum RequestError: Error {
        case test
    }
    
    /// Request an api
    ///
    /// - Parameters:
    ///   - needSuccess: Whether the request should succeed
    ///   - callback: Callback request result
    func request(needSuccess: Bool, callback: @escaping (Result<String, Error>) -> Void) {
        
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
    func requestRandom(at index: IndexPath, callback: @escaping (Result<String, Error>) -> Void) {
        
        Log.warning("Please note that an api with random results will be requested! 👻")
        
        // Analog api request
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            let value = index.section + index.row
            
            let random = value + Int(arc4random_uniform(UInt32(100 + 1 - value)))
            
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
}
