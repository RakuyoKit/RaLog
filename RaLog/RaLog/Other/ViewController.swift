//
//  ViewController.swift
//  RaLog
//
//  Created by Rakuyo on 2020/09/01.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

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
        
        let needSuccess = true
        
        Log.warning("Please note that the request is about to start！😎")
        
        // Analog api request
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            if needSuccess {
                Log.success("request success 🥳, content: api request succeeded")
                
            } else {
                Log.error("request failure 😢, error: \("some error")")
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
}
