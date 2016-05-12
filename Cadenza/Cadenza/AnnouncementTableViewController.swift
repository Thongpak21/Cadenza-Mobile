//
//  AnnouncementTableViewController.swift
//  Cadenza
//
//  Created by Thongpak on 3/24/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
class AnnouncementTableViewController: UITableViewController,UIWebViewDelegate {

    private let cellIdentifier = "Cell"
    private let showBrowserSegueIdentifier = "ShowBrowser"
    private let JSONResultsKey = "data"
    private let JSONNumPagesKey = "per_page"

    private var currentPage = 1
    private var numPages = 0
    private var data_model = [model]()
    
    var selectedIndexPath:NSIndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
        tableView.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRectMake(0, 0, 24, 24))
        
        tableView.infiniteScrollIndicatorMargin = 40
        
        tableView.addInfiniteScrollWithHandler { [weak self] (scrollView) -> Void in
            self?.fetchData() {
                let tableView = scrollView as! UITableView
                tableView.finishInfiniteScroll()
            }
        }
        
        self.fetchData(nil)
        
    }

    private func apiURL(page:Int) ->  NSURL{
        var string = ""
        if mystruct.secID == nil {
            string = "http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/announcement?access_token=\(Token().getToken())&page=\(page)"
            
        }else{
            string = "http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/announcement?access_token=\(Token().getToken())&page=\(page)"
        }
        let url = NSURL(string:string)
        return url!
    }
    private func fetchData(handler:((Void) -> Void)?){
      //  print("page : \(currentPage)" )
        let requestURL = apiURL(currentPage)
        let task = Alamofire.request(.GET, requestURL)
            .responseJSON{ response in
                //    print(response.result.value)
                if let _ = response.result.error {
                    self.showAlertWithError(response.result.error!)
                    return;
                }
                //     print(response.result.value?["per_page"])
                if let pages = response.result.value?[self.JSONNumPagesKey] as? NSNumber {
                    self.numPages = pages as Int
             //       print(self.numPages)
                }
                //  print(response.result.value?[self.JSONResultsKey] as? [[String: AnyObject]])
                if let results = response.result.value?[self.JSONResultsKey] as? [[String: AnyObject]] {
                    self.currentPage += 1
                    for i in results {
                  //      print("\(model(i).annoID)   --->  \(model(i).annoTitle)")
                        self.data_model.append(model(i))
                    }
                    self.tableView.reloadData()
                }
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                UIApplication.sharedApplication().stopNetworkActivity()
                handler?()
                
        }
        UIApplication.sharedApplication().startNetworkActivity()
        
        let delay = (data_model.count == 0 ? 0 : 5) * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            task.resume()
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if data_model.count == 0 {
            return 1
        }else{
            return data_model.count
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellAnno", forIndexPath: indexPath) as! AnnoTableViewCell
        if data_model.count == 0 {
            cell.textLabel?.text = "No Announcement!!!"
            cell.detailTextLabel?.text = ""
            return cell
        }else {
            let data_cell = data_model[indexPath.row]

            cell.textLabel?.text = data_cell.annoTitle
            return cell
        }
      //  cell.web.scrollView.scrollEnabled = false
    //    cell.loadwebview(data_cell.annoDes!)
       // cell.height_web.constant = 500
     //   print(tableView.rowHeight)
//        print(cell.web.scrollView.contentSize.height)
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if data_model.count == 0 {
            
        }else{
            mystruct.Annodes = data_model[indexPath.row].annoDes
            
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("AnnoDes") as! AnnoDesViewController
            
            self.navigationController!.pushViewController(secondViewController, animated: true)
        }
        
//        let pre = selectedIndexPath
//        if indexPath == selectedIndexPath {
//            selectedIndexPath = nil
//        } else {
//            selectedIndexPath = indexPath
//        }
//        var indexPaths: Array<NSIndexPath> = []
//        if let prev = pre {
//            indexPaths += [prev]
//        }
//        if let current = selectedIndexPath {
//            indexPaths += [current]
//        }
//        if indexPaths.count > 0 {
//            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
//        }
    }

    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath == selectedIndexPath {
//            return AnnoTableViewCell.expandedHeight
//        } else {
//            return AnnoTableViewCell.defaultHeight
//        }
//    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
     //   (cell as! AnnoTableViewCell).
    }
    private func showAlertWithError(error: NSError) {
        let alert = UIAlertController(title: NSLocalizedString("Error fetching data", comment: ""), message: error.localizedDescription, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .Cancel, handler: { (action) -> Void in
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .Default, handler: { (action) -> Void in
            self.fetchData(nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

}
