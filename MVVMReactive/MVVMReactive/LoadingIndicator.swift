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
import UIKit

protocol ActivityIndicatorProtocol {
    var mainView : UIView { get set }
    var activityIndicatorView : UIActivityIndicatorView { get }

    func showActivityIndicator()
    func hideActivityIndicator()
}

extension ActivityIndicatorProtocol {
    
    func showActivityIndicator() {
        print("Show Activity Indicator")
        mainView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        print("Hide Activity Indicator")
        activityIndicatorView.stopAnimating()
    }
}

class LoadingIndicator : ActivityIndicatorProtocol {
    var mainView: UIView
    
    lazy var activityIndicatorView : UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    init(view : UIView) {
        self.mainView = view
    }
}

extension LoadingIndicator : ReactiveExtensionsProvider {} // Important

// This becomes target now. So, based on some value in the ViewModel
// The target gets called
// Bind like this below
// self.loadingIndicator.reactive.showLoader <~ viewModel.showLoader
// target <~ source

extension Reactive where Base : LoadingIndicator {
    
    var showLoader : BindingTarget<Bool> {
        
        return makeBindingTarget { (loadingIndicator, loaderFlag) in
            if loaderFlag {
                loadingIndicator.showActivityIndicator()
            }
            else {
                loadingIndicator.hideActivityIndicator()
            }
        }
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
