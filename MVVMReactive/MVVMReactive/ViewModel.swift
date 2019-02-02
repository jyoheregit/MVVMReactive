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
    var title = Property(value: "title")

    private var itemsProperty = MutableProperty<Array<String>>([])
    var items : Property<Array<String>>
    
    private var showLoaderProperty = MutableProperty<Bool>(false)
    var showLoader: Property<Bool>
    
    init(){
        showLoader = Property(showLoaderProperty)
        items = Property(itemsProperty)
    }
    
    func fetchData() {
        showLoaderProperty.value = true
        serviceProtocol?
            .fetchData()
            .startWithValues { [weak self] (items) in
                self?.itemsProperty.value = items
                self?.showLoaderProperty.value = false
            }
    }
}
