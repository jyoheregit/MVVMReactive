//
//  ViewController.swift
//  MVVMReactive
//
//  Created by Joe on 20/01/19.
//  Copyright © 2019 Jyothish. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class ViewController: UIViewController {

    var viewModel : ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        viewModel?.fetchData()
    }
    
    private func setupBinding() {
        viewModel?.values
                .signal
                .observeValues({ (values) in
                    print(values)
                })
    }
}

