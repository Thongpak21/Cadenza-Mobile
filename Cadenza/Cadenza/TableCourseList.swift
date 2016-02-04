//
//  NewsTableViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import CoreData
private let useAutosizingCells = true
class TableCourseList: UITableViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!
    var coursename = [String]()
    var teacher = [String]()
    var coverimg = [String]()
    

    private let cellIdentifier = "Cell"
    private let showBrowserSegueIdentifier = "ShowBrowser"
    private let JSONResultsKey = "data"
    private let JSONNumPagesKey = "per_page"

    private var currentPage = 1
    private var numPages = 0
    private var data_model = [model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRectMake(0, 0, 24, 24))
        
        tableView.infiniteScrollIndicatorMargin = 40

        tableView.addInfiniteScrollWithHandler { [weak self] (scrollView) -> Void in
            self?.fetchData() {
                // scrollView.finishInfiniteScroll()
                let tableView = scrollView as! UITableView
                tableView.finishInfiniteScroll()
            }
        }
        
        self.fetchData(nil)
        
//        if revealViewController() != nil {
//          //  revealViewController().rearViewRevealWidth = 300
//            menuButton.target = revealViewController()
//            menuButton.action = "revealToggle:"
//            revealViewController().rightViewRevealWidth = 150
////            extraButton.target = revealViewController()   right side bar
////            extraButton.action = "rightRevealToggle:"
//            revealViewController().tapGestureRecognizer()
//            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            
//        }

        //checktoken()
        Alamofire.request(.GET, "http://cadenza.in.th/api/mobile/course?page=1" )
            .responseJSON { response in
                let json = JSON(response.result.value!)
                
                //   print("JSON: \(json)")
                //   print(json["data",0,"CourseName"])
                let num = (json["data"].array?.count)!
                if let ct:Int = num {
                    for index in 0...ct-1 {
                        if let name = json["data",index,"CourseName"].string {
                            let test:String = name
                       //     self.data_model.title.append(test)
                            self.coursename.append(test)
                        }
                        let fname = json["data",index,"firstname"].string
                        let lname = json["data",index,"lastname"].string
                        let flname = fname! + " " + lname!
                        self.teacher.append(flname)
                        
                    }
                    
                    for index in 0...ct-1 {
                        if let img = json["data",index,"CourseCoverFull"].string {
                            self.coverimg.append("http://cadenza.in.th"+"\(img)")
                          //  print(self.coverimg[index])
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableView.reloadData()
                    })
                }
                //                for (key,json):(String, JSON) in json {
                //                    print("\(key) -> \(json)")
                //                    if key == "data" {
                //                        print("\(key) -> \(json)")
                //                    }
                //                }
        }
    }
    func checktoken() {
        let appdel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appdel.managedObjectContext
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false;
        do {
            let result = try context.executeFetchRequest(request)
            // for res in result {
            //     print(res)
            //   }
            //   print(result)
            if result.count == 0 {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                    self.presentViewController(viewController, animated: true, completion: nil)
                })
            }
        } catch {
               print(error)
        }
        
    }
    private func apiURL(page:Int) ->  NSURL{
        let string = "http://cadenza.in.th/api/mobile/course?page=\(page)"
        let url = NSURL(string:string)
        return url!
    }
    private func fetchData(handler:((Void) -> Void)?){
        print("page : \(currentPage)" )
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
                    print(self.numPages)
                }
              //  print(response.result.value?[self.JSONResultsKey] as? [[String: AnyObject]])
                if let results = response.result.value?[self.JSONResultsKey] as? [[String: AnyObject]] {
                    self.currentPage++
                    for i in results {
                        print("\(model(i).title)   --->  \(model(i).courseID)")
                        self.data_model.append(model(i))
                    }
                    self.tableView.reloadData()
                }
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
        return data_model.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! NewsTableViewCell
        let data_cell = data_model[indexPath.row]
        cell.postTitleLabel.text = data_cell.title
        cell.authorLabel.text = "\(data_cell.author_fname!) \(data_cell.author_lname!)"
     //   print("http://cadenza.in.th"+"\(data_cell.courseCoverFull!)")
        Alamofire.request(.GET, "http://cadenza.in.th"+"\(data_cell.courseCoverFull!)")
            .responseImage { response in
                if let image = response.result.value {
                    cell.postImageView.image = image
                }
        }
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let target = segue.destinationViewController
        if segue.identifier == "SendDataSegue" {
            if let destination = segue.destinationViewController as? ShowCourseDetail {
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRowAtIndexPath(path!) as! NewsTableViewCell
              //  print(path?.row)
                var x:Int = (path?.row)!
                x = x+1
                let xNSNumber = x as NSNumber
                let XString: String = xNSNumber.stringValue
                destination.viaSegue = XString
                destination.Name = coursename[(path?.row)!]
                destination.coveimg = coverimg[(path?.row)!]
                destination.teacher = teacher[(path?.row)!]
                
            }
        }
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        _ = tableView.indexPathForSelectedRow!
        if let _ = tableView.cellForRowAtIndexPath(indexPath) {
         //   self.performSegueWithIdentifier("SendDataSegue", sender: self)
        }
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
