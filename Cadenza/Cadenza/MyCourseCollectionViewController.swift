//
//  CourseCollectionViewController.swift
//  Cadenza
//
//  Created by Thongpak on 2/5/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import CoreData
//private let reuseIdentifier = "Cell"

class MyCourseCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var gettoken:AnyObject?
    var token:String?
    private var data_model = [model]()
    private struct Storyboard {
        static let CellIdentifier = "CollectionViewCell"
    }
    private let LeftAndRightPadding: CGFloat = 24.0
    private let numberOfItemsPerRow: CGFloat = 2.0
    private let heightAdjustment:CGFloat = 30.0
    
    private let JSONResultsKey = "data"
    private let JSONNumPagesKey = "per_page"
    
    private var currentPage = 1
    private var numPages = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let token_coredata = checktoken()
        self.gettoken = checktoken()
        self.gettoken = token_coredata.valueForKey("token")
        //  print(gettoken![0])
        token = gettoken![0] as? String
    //    print(token!)
        data(token!)
        let width = (CGRectGetWidth((collectionView?.bounds)!) - LeftAndRightPadding) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightAdjustment)
        
//        // Set custom indicator
//        collectionView?.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRectMake(0, 0, 24, 24))
//        // Set custom indicator margin
//        collectionView?.infiniteScrollIndicatorMargin = 40
//        // Add infinite scroll handler
//        collectionView?.addInfiniteScrollWithHandler { [weak self] (scrollView) -> Void in
//            self?.fetchData() {
//                scrollView.finishInfiniteScroll()
//            }
//        }
//        
//        fetchData(nil)
        
    }
    func data(token:String) {
        Alamofire.request(.GET,"http://www.cadenza.in.th/v2/api/mobile/mycourses?access_token=\(token)")
            .responseJSON{ response in
                 UIApplication.sharedApplication().startNetworkActivity()
                if let results = response.result.value?[self.JSONResultsKey] as? [[String: AnyObject]] {
                    for i in results {
                        print("\(model(i).title)")
                        self.data_model.append(model(i))
                         UIApplication.sharedApplication().stopNetworkActivity()
                    }
                    
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.collectionView?.reloadData()
                })
                
                
                
        }
    }
    func checktoken() -> AnyObject {
        let appdel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appdel.managedObjectContext
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false;
        do {
            let result = try context.executeFetchRequest(request)
            
            // print(result)
            return result
        } catch {
            print(error)
        }
        return "no"
        
    }
    
//        override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//            super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
//    
//            collectionViewLayout.invalidateLayout()
//        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PassCourse" {
            if let indexPath = collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
                let controller = segue.destinationViewController as! ShowCourseDetail
                let data_cell = data_model[(indexPath.row)]
                //  print(path?.row)
                var x:Int = (indexPath.row)
                x = x+1
                let xNSNumber = x as NSNumber
                let XString: String = xNSNumber.stringValue
                controller.viaSegue = XString
                controller.Name = data_cell.title!
                controller.coveimg = "http://cadenza.in.th\(data_cell.courseCoverFull!)"
                controller.teacher = "\(data_cell.author_fname!) \(data_cell.author_lname!)"
                controller.des = data_cell.courseDes!
                
            }
            
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_model.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CourseCell
        let data_cell = data_model[indexPath.row]
        cell.titleLabel.text = data_cell.title
        cell.authorLabel.text = "\(data_cell.author_fname!) \(data_cell.author_lname!)"
        print(cell.authorLabel.text)
        Alamofire.request(.GET, "http://cadenza.in.th"+"\(data_cell.courseCoverFull!)")
            .responseImage { response in
                if let image = response.result.value {
                    cell.imagecell.image = image
                    //                    cell.imagecell.layer.borderWidth = 1
                    //                    cell.imagecell.layer.borderColor = UIColor(red:012/255.0, green:012/255.0, blue:012/255.0, alpha: 1.0).CGColor
                }
        }
        cell.contentView.layer.cornerRadius = 1.0
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.clearColor().CGColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 1)
        cell.layer.shadowRadius = 1.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        return cell
        
    }
    
    
//    private func apiURL(page:Int) ->  NSURL{
//        let string = "http://www.cadenza.in.th/v2/api/mobile/mycourses?access_token=\(page)"
//        let url = NSURL(string:string)
//        return url!
//    }
//    private func fetchData(handler:((Void) -> Void)?){
//        print("page : \(currentPage)" )
//        let requestURL = apiURL(currentPage)
//        var indexPaths = [NSIndexPath]()
//        let firstIndex = data_model.count
//        let task = Alamofire.request(.GET, requestURL)
//            .responseJSON{ response in
//                //    print(response.result.value)
//                if let _ = response.result.error {
//                    self.showAlertWithError(response.result.error!)
//                    return;
//                }
//                //     print(response.result.value?["per_page"])
//                if let pages = response.result.value?[self.JSONNumPagesKey] as? NSNumber {
//                    self.numPages = pages as Int
//                    //    print(self.numPages)
//                }
//                //  print(response.result.value?[self.JSONResultsKey] as? [[String: AnyObject]])
//                if let results = response.result.value?[self.JSONResultsKey] as? [[String: AnyObject]] {
//                    self.currentPage++
//                    //      print(results.enumerate())
//                    //                    for (i,a) in results.enumerate() {
//                    //                      //  print(i)
//                    //                        let indexPath = NSIndexPath(forItem: firstIndex + i, inSection: 0)
//                    //                        print(model(a).title)
//                    //                        self.data_model.append(model(a))
//                    //                        indexPaths.append(indexPath)
//                    //                    }
//                    for i in results {
//                   //     print("\(model(i).title)   --->  \(model(i).courseID)")
//                        self.data_model.append(model(i))
//                    }
//                    //       self.scrollView.reloadData()
//                    self.collectionView?.reloadData()
//                    self.collectionView?.insertItemsAtIndexPaths(indexPaths)
//                }
//                UIApplication.sharedApplication().stopNetworkActivity()
//                handler?()
//                
//        }
//        UIApplication.sharedApplication().startNetworkActivity()
//        
//        let delay = (data_model.count == 0 ? 0 : 5) * Double(NSEC_PER_SEC)
//        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//        dispatch_after(time, dispatch_get_main_queue(), {
//            task.resume()
//        })
//        
//    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
//    private func showAlertWithError(error: NSError) {
//        let alert = UIAlertController(title: NSLocalizedString("Error fetching data", comment: ""), message: error.localizedDescription, preferredStyle: .Alert)
//        
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .Cancel, handler: { (action) -> Void in
//        }))
//        
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .Default, handler: { (action) -> Void in
//            self.fetchData(nil)
//        }))
//        
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
}
