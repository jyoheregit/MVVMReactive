//
//  Coordinator.swift
//  MVVMReactive
//
//  Created by Joe on 20/01/19.
//  Copyright © 2019 Jyothish. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var window : UIWindow? { get set }
    func setupInitialViewController()
}

extension Coordinator {
    
    func setupInitialViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? ViewController else {
            fatalError("Initial VC not instantiated")
        }
        vc.viewModel = ViewModel(service: RemoteService())
        vc.loadingIndicator = LoadingIndicator(view: vc.view)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

class AppCoordinator : Coordinator {
    
    var window : UIWindow?
    
    init(window : UIWindow?) {
        self.window = window
    }
}
