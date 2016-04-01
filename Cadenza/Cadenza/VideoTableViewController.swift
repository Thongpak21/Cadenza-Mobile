//
//  LessonTableViewController.swift
//  Cadenza
//
//  Created by Thongpak on 3/28/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import AVKit
import AVFoundation

class VideoTableViewController: UITableViewController {
  //  @IBOutlet weak var web: UIWebView!
    
    var data_model = [model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print(mystruct.courseID)
        //        print(mystruct.secID)
        //        print(mystruct.lectureID)
        if mystruct.secID == nil {
            alamo_Video("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/videos?access_token=\(Token().getToken())")
            
        }else{
            alamo_Video("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/videos?access_token=\(Token().getToken())")
        }
        
    }
    func alamo_Video(url:String){
        Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
                if let results = response.result.value as? [[String: AnyObject]] {
                    for i in results {
                  //      print("\(model(i).videoType)   --->  \(model(i).videoTitle)")
                        self.data_model.append(model(i))
                    }
                    self.tableView.reloadData()
                }
                
                UIApplication.sharedApplication().stopNetworkActivity()
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data_model.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! VideoTableViewCell
        let data_cell = data_model[indexPath.row]
        cell.title.text = data_cell.videoTitle
     //   print(data_cell.videoType)
       // let link:String?
        if data_cell.videoType == 1 {
          //  link = "https://www.youtube.com/watch?v=\(data_cell.videoURL!)"
            mystruct.video.append("https://www.youtube.com/watch?v=\(data_cell.videoURL!)")
            Alamofire.request(.GET, "https://www.youtube.com/watch?v=\(data_cell.videoURL!)")
                .response { request, response, data, error in
                    cell.web.loadRequest(request!)
//                    dispatch_async(dispatch_get_main_queue(),{
//                        self.tableView.reloadData()
//                    })
            }

        } else {
      //      link = "https://vimeo.com/channels/staffpicks/\(data_cell.videoURL!)"
            mystruct.video.append("https://vimeo.com/channels/staffpicks/\(data_cell.videoURL!)")
            Alamofire.request(.GET, "https://vimeo.com/channels/staffpicks/\(data_cell.videoURL!)")
                .response { request, response, data, error in
                    cell.web.loadRequest(request!)
//                    dispatch_async(dispatch_get_main_queue(),{
//                        self.tableView.reloadData()
//                    })
            }
        

        }
        cell.web.scrollView.scrollEnabled = false
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        mystruct.indexpath_video = indexPath.row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
//        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Avplayer")
//        self.presentViewController(viewController, animated: true, completion: nil)
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let destination = segue.destinationViewController as! AVPlayerViewController
//        self.tabBarController!.tabBar.hidden = true
////        destination.
////        self.navigationController!.navigationBar.hidden = true
////        self.tabBarController?.tabBar.items
//        let url = NSURL(string:
//            "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")
//        destination.player = AVPlayer(URL: url!)
//    }
    
    
}
