//
//  MyProfileViewController.swift
//  MVVM
//
//  Created by Thongpak on 7/26/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController,ViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel:MyProfileViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel = MyProfileViewModel(delegate: self)
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



extension MyProfileViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.numberOfArray())!;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath)
//        cell.textLabel?.text = self.viewModel?.wordForIndex(indexPath.row).authorized![indexPath.row].key1
         cell.textLabel?.text = "hello"
        return cell
    }
}
extension MyProfileViewController: UITableViewDelegate {
    
}