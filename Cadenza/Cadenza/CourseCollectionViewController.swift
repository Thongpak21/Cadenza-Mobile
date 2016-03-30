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
import SwiftSpinner

class CourseCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
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
    //    tabBarItem.badgeValue = "2"
   //    tabBarController?.tabBar.items?[1].badgeValue = "1"
        let width = (CGRectGetWidth((collectionView?.bounds)!) - LeftAndRightPadding) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightAdjustment)
        
        // Set custom indicator
        collectionView?.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRectMake(0, 0, 24, 24))
        // Set custom indicator margin
        collectionView?.infiniteScrollIndicatorMargin = 40
        // Add infinite scroll handler
        collectionView?.addInfiniteScrollWithHandler { [weak self] (scrollView) -> Void in
            self?.fetchData() {
                self!.collectionView?.finishInfiniteScroll()

            }
        }
        fetchData(nil)
        
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionViewLayout.invalidateLayout()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PassCourse" {
            if let indexPath = collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
                let controller = segue.destinationViewController as! ShowCourseDetail
                let data_cell = data_model[(indexPath.row)]
                controller.Name = data_cell.title!
                controller.coveimg = "http://cadenza.in.th\(data_cell.courseCoverFull!)"
                controller.teacher = "\(data_cell.author_fname!) \(data_cell.author_lname!)"
                controller.des = data_cell.courseDes!
                controller.courseID = data_cell.courseID!
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
        let string = "http://cadenza.in.th"+"\(data_cell.courseCoverFull!)"
        let url = NSURL(string:string)
        Alamofire.request(.GET, url!)
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
    
    
    private func apiURL(page:Int) ->  NSURL{
        let string = "http://cadenza.in.th/api/mobile/course?page=\(page)"
        let url = NSURL(string:string)
        return url!
    }
    private func fetchData(handler:((Void) -> Void)?){
        print("page : \(currentPage)" )
        let requestURL = apiURL(currentPage)
        let indexPaths = [NSIndexPath]()
        //      let firstIndex = data_model.count
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
                    //    print(self.numPages)
                }
                //    print(response.result.value?[self.JSONResultsKey] as? [[String: AnyObject]])
                if let results = response.result.value?[self.JSONResultsKey] as? [[String: AnyObject]] {
                    self.currentPage += 1
                    for i in results {
                        //        print("\(model(i).title)   --->  \(model(i).courseID)")
                        self.data_model.append(model(i))
                    }
                    self.collectionView?.reloadData()
                    self.collectionView?.insertItemsAtIndexPaths(indexPaths)
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
//    override func viewDidAppear(animated: Bool) {
//        SwiftSpinner.hide()
//    }
//    override func viewWillAppear(animated: Bool) {
//        SwiftSpinner.show("Connecting...")
//    }
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
