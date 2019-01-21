//
//  Service.swift
//  MVVMReactive
//
//  Created by Joe on 21/01/19.
//  Copyright © 2019 Jyothish. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

protocol ServiceProtocol {
    func fetchData() -> SignalProducer<Array<String>, NoError>
}

enum CustomError : Error {
    
}

class LocalService : ServiceProtocol{
    
    func fetchData() -> SignalProducer<Array<String>, NoError> {
        return SignalProducer { (observer, lifetime) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                observer.send(value: ["1","2"])
                observer.sendCompleted()
            }
        }
    }
}
