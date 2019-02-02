//
//  LoadingIndicator.swift
//  MVVMReactive
//
//  Created by Joe on 27/01/19.
//  Copyright © 2019 Jyothish. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

protocol ActivityIndicatorProtocol {
    func showActivityIndicator()
    func hideActivityIndicator()
}

class LoadingIndicator : ActivityIndicatorProtocol {
    func showActivityIndicator() { print("Show Activity Indicator")}
    func hideActivityIndicator() { print("Hide Activity Indicator")}
}

extension LoadingIndicator : ReactiveExtensionsProvider {} // Important

// This becomes target now. So, based on some value in the ViewModel
// The target gets called
// Bind like this below
// self.loadingIndicator.reactive.showLoader <~ viewModel.showLoader
// target <~ source

extension Reactive where Base : LoadingIndicator {
    
    var showLoader : BindingTarget<Bool> {
        
        return makeBindingTarget({ (loadingIndicator, loaderFlag) in
            if(loaderFlag){
                loadingIndicator.showActivityIndicator()
            }
            else {
                loadingIndicator.hideActivityIndicator()
            }
        })
    }
}

//For becoming source use as below
// Return a Signal

//extension Reactive where Base: LoadingIndicator {
//    
//    var sectionsSignal: Signal<[Section]> {
//        return Signal { observer, _ in
//            base.sections = { sections in
//                observer.send(value: sections)
//            }
//        }
//    }
//}
