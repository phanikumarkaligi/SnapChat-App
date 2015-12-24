//
//  SettingsPageTableViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 16/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse

class SettingsPageTableViewController: UITableViewController {
    var inf: [(String,String)] = []
    var mid : [String] = []
    var hedingsArray = [String]()
    
    @IBAction func logout() {
        PFUser.logOutInBackground()
        performSegueWithIdentifier("toSignUpPage", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inf = [("starred messages","About and Help"),("SnapChat Web","Tell a friend")]
        mid = ["Account","Chats","Notifications","Data Usage"]
        hedingsArray = ["users","General","Policy Conditions"]
    }

   
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
       return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2 {
            return inf.count
        } else if section == 1 {
            return mid.count
        }
        else {
            return 0
        }

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cells", forIndexPath: indexPath)
        if indexPath.section == 0 {
            
            cell.textLabel?.text = inf[indexPath.row].0
        } else if indexPath.section == 1 {
            cell.textLabel?.text = mid[indexPath.row]
        }  else if indexPath.section == 2 {
            cell.textLabel?.text = inf[indexPath.row].1
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return hedingsArray[section]
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
