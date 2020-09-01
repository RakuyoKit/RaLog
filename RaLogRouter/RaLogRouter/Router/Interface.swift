//
//  Interface.swift
//  MBCore
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 com.mbcore. All rights reserved.
//

import RaRouter

public enum RaLog: ModuleRouter {
    
    public typealias Table = RouterTable
    
    public enum RouterTable: String, RouterTableProtocol {
        
        public var url: String { rawValue }
        
        case <#routerURL#> = "mbc://<#RouterURL#>"
    }
}

public extension Router where Module == RaLog {
    
    static func <#name#>() -> DoResult {
        
        
    }
    
    static func <#name#>() -> GetResult<<#ValueType#>> {
        
        
    }
}
