//
//  allUsersTableViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 09/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

class allUsersTableViewController: UITableViewController {
   var usersArray:[PFObject] = []
   var strArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let query = PFUser.query()
        
        query?.whereKey("name", notEqualTo: "")
        query?.findObjectsInBackgroundWithBlock({ (obj :[PFObject]?, err: NSError?) -> Void in
        
            if let objects = obj {
                self.usersArray = objects
                print("pfobject array contains \(self.usersArray)")
                self.tableView.reloadData()
            } else {
                print(err)
                print("pfobject array doesn not contains \(self.usersArray)")

            }
 })
        
   
    }
 
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cells", forIndexPath: indexPath)
        let temp = usersArray[indexPath.row]
        let name = temp["username"] as! String
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = usersArray[indexPath.row]["email"] as? String


        return cell
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let cell : UITableViewCell?  = tableView.cellForRowAtIndexPath(indexPath)
        
        if cell?.accessoryType == UITableViewCellAccessoryType.None {
            cell?.accessoryType = .Checkmark
        // parse freiends list code
        let friendsList = PFObject(className: "friends")
        friendsList["following"] = cell?.textLabel?.text!
        friendsList["email"] = cell?.detailTextLabel?.text!
        friendsList["follower"] = PFUser.currentUser()?.username!
        
        friendsList.saveInBackgroundWithBlock({ (success, err ) -> Void in
            if err == nil {
                print("saved")
            }
            else {
                print("error")
            }
        })
 }
        else {
             cell?.accessoryType = .None
            let a = cell?.textLabel?.text!
            let b = cell?.detailTextLabel?.text!
            
            let q = PFQuery(className: "friends")
    q.whereKey("follower", equalTo: "\(PFUser.currentUser()?.username!)")
            q.whereKey("following", equalTo:"\(a!)")
        q.findObjectsInBackgroundWithBlock({ (objects, err ) -> Void in
            for object : PFObject? in objects!  {
                if let obj = object {
                obj.deleteInBackground()
                                   }
            }
            
            
        })
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
