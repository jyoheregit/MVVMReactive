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
    
    lazy var loadingIndicator : LoadingIndicator = {
        let loadingIndicator = LoadingIndicator()
        return loadingIndicator
    }()
    
    var items : Array<String>?{
        didSet{
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.reactive.title <~ viewModel?.title
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setupBinding()
        
        viewModel?.serviceProtocol = LocalService()
        viewModel?.fetchData()
    }
    
    private func setupBinding() {
        
        // Data binding for tableview
        viewModel?.items
                .signal
                .observeValues({ [weak self] (items) in
                    self?.items = items
                    print(items)
                })
        
        //LoadingIndicatorBinding
        if let viewModel = viewModel {
            self.loadingIndicator.reactive.showLoader <~ viewModel.showLoader
        }
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = items else {return 0}
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items?[indexPath.row]
        return cell
    }
}

