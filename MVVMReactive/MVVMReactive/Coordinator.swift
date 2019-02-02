//
//  Coordinator.swift
//  MVVMReactive
//
//  Created by Joe on 20/01/19.
//  Copyright © 2019 Jyothish. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    
    private var window : UIWindow?
    
    init(window : UIWindow?) {
        self.window = window
    }
    
    func setupInitialViewController() {
    
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as? ViewController
        vc?.viewModel = ViewModel()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
