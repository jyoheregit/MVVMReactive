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
    
    var serviceProtocol : ServiceProtocol?
    var data = MutableProperty<Array<String>>([])
    
    func fetchData() {
        serviceProtocol?
            .fetchData()
            .startWithValues { (data) in
                self.data.value = data
            }
    }
}
