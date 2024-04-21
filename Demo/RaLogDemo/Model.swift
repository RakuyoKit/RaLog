//
//  Model.swift
//  RaLogDemo
//
//  Created by Rakuyo on 2020/09/02.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

// MARK: - SectionDataSource

public struct SectionDataSource {
    public let title: String
    
    public let dataSource: [DataSource]
    
    public init(title: String, dataSource: [DataSource]) {
        self.title = title
        self.dataSource = dataSource
    }
}

// MARK: - DataSource

public struct DataSource {
    public let title: String
    
    /// Execute on click
    ///
    /// Returns the controller to be displayed and whether it is displayed in `push` mode
    public let action: (IndexPath) -> (UIViewController?, Bool)
    
    public init(title: String, action: @escaping (IndexPath) -> (UIViewController?, Bool)) {
        self.title = title
        self.action = action
    }
}
