//
//  ViewController.swift
//  MVVM
//
//  Created by Thongpak on 7/25/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ViewModelDelegate {
    @IBOutlet weak var tableView: UITableView!
    var viewModel:ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = ViewModel(delegate: self)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.refreshData()
    }
    func onDataDidLoad() {
        self.tableView.reloadData()
    }
    func onDataDidLoadErrorWithMessage(errorMessage:String) {
        print(errorMessage)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel?.numberOfWords())!;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath)
        cell.textLabel?.text = self.viewModel?.wordForIndex(indexPath.row).title
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    
}