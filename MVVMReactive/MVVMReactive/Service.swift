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

protocol Service {
    func fetchData() -> SignalProducer<Array<String>, CustomError>
}

enum CustomError : Error {
    case error(String)
}

class LocalService : Service {
    
    func fetchData() -> SignalProducer<Array<String>, CustomError> {
        return SignalProducer { (observer, lifetime) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                observer.send(value: ["1","2"])
                observer.sendCompleted()
            }
        }
    }
}

class RemoteService : Service {
    
    let apiKey = "5a4b1123a2544bd18ba6ea7f0612f0b1"
    
    func fetchData() -> SignalProducer<Array<String>, CustomError> {
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString)  else {
            return SignalProducer<Array<String>, CustomError> { (observer, lifetime) in
                observer.send(error: CustomError.error("Parsing Error"))
            }
        }
        
        return SignalProducer<Array<String>, CustomError> { (observer, lifetime) in
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    //Handle error
                    return
                }
            
                do {
                    let news = try JSONDecoder().decode(News.self, from: data)
                    observer.send(value: [news.articles![0].title!])
                    observer.sendCompleted()
                }
                catch {
                    print(error)
                }
            }.resume()
        }
    }
    
    
}

struct News : Decodable {
    var status: String?
    var totalResults: Int?
    var articles : [Article]?
}

struct Article : Decodable {
    var source : Source?
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
}

struct Source : Decodable {
    var id : String?
    var name : String?
}
