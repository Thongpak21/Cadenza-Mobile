//
//  ChatTableViewController.swift
//  Chat
//
//  Created by Thongpak on 6/24/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class ChatTableViewController: UITableViewController {
    var count = 0
    let M1 = ["Hello sir,welcome to the French Garden Restaurant. How many?","Right this way. Please have a seat. Your waitress will be with you in a moment.","Yes please.","What do you have?","I'll have a bottle of water please.","I'll have a tuna fish sandwich and a bowl of vegetable soup."]
    let M2 = ["One.","Hello sir, would you like to order now?","What would you like to drink?","We have bottled water, juice, and Coke.","What would you kike to eat?","Ok."]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return M1.count + M2.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.row % 2 == 0{
            let cell1 = tableView.dequeueReusableCellWithIdentifier("Message1", forIndexPath: indexPath) as! Message1TableViewCell
            
            cell1.M1Label.text = M1[count/2]
            count = count + 1;
            return cell1
            
        }else{
            let cell2 = tableView.dequeueReusableCellWithIdentifier("Message2", forIndexPath: indexPath) as! Message2TableViewCell
            cell2.M2Label.text = M2[count/2]
            count = count + 1;
            return cell2
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
