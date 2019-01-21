//
//  ViewModel.swift
//  MVVMReactive
//
//  Created by Joe on 20/01/19.
//  Copyright © 2019 Jyothish. All rights reserved.
//

import Foundation
import ReactiveSwift

class ViewModel {
    
    var values = MutableProperty<Array<String>>([])
    
    func fetchData() {
        values.value = ["One", "Two", "Three"]
    }
}
