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

    private var currentPage = 0
    private var numPages = 0
    private var data_model = [model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if useAutosizingCells && tableView.respondsToSelector("layoutMargins") {
            tableView.estimatedRowHeight = 88
            tableView.rowHeight = UITableViewAutomaticDimension
        }
        tableView.infiniteScrollIndicatorStyle = .White
        tableView.addInfiniteScrollWithHandler { (scrollView) -> Void in
            let tableView = scrollView as! UITableView
            
            //
            // fetch your data here, can be async operation,
            // just make sure to call finishInfiniteScroll in the end
            //
            
            // make sure you reload tableView before calling -finishInfiniteScroll
            tableView.reloadData()
            // finish infinite scroll animation
            tableView.finishInfiniteScroll()
        }
        
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
        Alamofire.request(.GET, "http://cadenza.in.th/api/mobile/course" )
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
                        print(fname)
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
        return coursename.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! NewsTableViewCell

        cell.postTitleLabel.text = coursename[indexPath.row]
        cell.authorLabel.text = teacher[indexPath.row]
        Alamofire.request(.GET, coverimg[indexPath.row])
            .responseImage { response in
                if let image = response.result.value {
                    cell.postImageView.image = image
                }
        }
 //       cell.textLabel?.text = "hello from cell #\(indexPath.row)"
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
