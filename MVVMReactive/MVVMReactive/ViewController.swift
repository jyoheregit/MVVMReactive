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

    @IBOutlet weak var tableView: UITableView!

    var viewModel : ViewModel?
    var loadingIndicator : LoadingIndicator? {

        //LoadingIndicatorBinding
        didSet {
            if let viewModel = viewModel {
                self.loadingIndicator?.reactive.showLoader <~ viewModel.showLoader
            }
        }
    }
    
    var items : Array<String>? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setupBinding()
        viewModel?.fetchData()
    }
    
    // Data binding for tableview
    private func setupBinding() {
        viewModel?.items
                .signal
                .observeValues { [weak self] (items) in
                    self?.items = items
                    print(items)
                }
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = items else { return 0 }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items?[indexPath.row]
        return cell
    }
}

