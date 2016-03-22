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
//struct mystruct {
//    static var courseID = ""
//
//}
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
        self.tabBarItem.badgeValue = "5"
        data(Token().getToken())
        let width = (CGRectGetWidth((collectionView?.bounds)!) - LeftAndRightPadding) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightAdjustment)
        
//        // Set custom indicator
//        collectionView?.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRectMake(0, 0, 24, 24))
//        // Set 1custom indicator margin
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
       //         let json = JSON(response.result.value!)
             //   print(json["courseName"])
              //  let asd = Course(cid: 5,sid: 10)
//                for (key,subJson):(String, JSON) in json {
//                    print("\(key) --->>> \(subJson)")
//                }
           //         print(json["data",3,"courseenroll",0,"UserID"])
            //     print(response.result.value![self.JSONResultsKey])
                if let results = response.result.value![self.JSONResultsKey] as? [[String: AnyObject]] {
                    for i in results {
              //          print("\(model(i).courseID)")
                        self.data_model.append(model(i))
                         UIApplication.sharedApplication().stopNetworkActivity()
                    }
                    
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.collectionView?.reloadData()
                })
                
                
                
        }
    }
//        override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//            super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
//    
//            collectionViewLayout.invalidateLayout()
//        }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "PassCourse" {
//            if let indexPath = collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
//                let controller = segue.destinationViewController as! ShowCourseDetail
//                let data_cell = data_model[(indexPath.row)]
//                print(data_cell.title)
//                //  print(path?.row)
//                var x:Int = (indexPath.row)
//                x = x+1
//         //       let xNSNumber = x as NSNumber
//          //      let XString: String = xNSNumber.stringValue
//              //  controller.viaSegue = XString
//                controller.Name = data_cell.title!
//                controller.coveimg = "http://cadenza.in.th\(data_cell.courseCoverFull!)"
//                controller.teacher = "\(data_cell.author_fname!) \(data_cell.author_lname!)"
//                controller.des = data_cell.courseDes!
//                
//            }
//            
//        }
//    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let data_cell = data_model[indexPath.row]
        mystruct.courseID = data_cell.courseID
       // print(data_cell.courseID)
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
       // print(cell.authorLabel.text)
        Alamofire.request(.GET, "http://cadenza.in.th"+"\(data_cell.courseCoverFull!)")
            .responseImage { response in
                if let image = response.result.value {
                    cell.imagecell.image = image
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
