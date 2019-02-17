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
    
    var service : Service
    var title = Property(value: "title")
    
    private var itemsProperty = MutableProperty<Array<String>>([])
    var items : Property<Array<String>>
    
    private var showLoaderProperty = MutableProperty<Bool>(false)
    var showLoader: Property<Bool>
    
    init(service: Service) {
        self.service = service
        showLoader = Property(showLoaderProperty)
        items = Property(itemsProperty)
    }
    
    func fetchData() {
        showLoaderProperty.value = true
        service.fetchData()
            .startWithResult { (result) in
                DispatchQueue.main.async {
                    self.itemsProperty.value = result.value ?? []
                    self.showLoaderProperty.value = false
                }
            }
    }
}
