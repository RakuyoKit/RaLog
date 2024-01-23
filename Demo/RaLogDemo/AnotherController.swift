//
//  AnotherController.swift
//  RaLogDemo
//
//  Created by Rakuyo on 2020/9/2.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit
import RaLog

class AnotherController: UIViewController {
    
    deinit {
        Log.deinit(self)
    }
}

// MARK: - The life cycle

extension AnotherController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Another"
        view.backgroundColor = .orange
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Log.appear(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        Log.disappear(self)
    }
}
