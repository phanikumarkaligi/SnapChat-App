//
//  friendsListTableViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 15/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse

class friendsListTableViewController: UITableViewController {
    var localStringForSelectedUser : String? = ""
    @IBOutlet weak var refresher : UIRefreshControl!
    var friendsArray = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(PFUser.currentUser()!.username!)")
}
    
    @IBAction func refreshData(sender:UIRefreshControl!) {
       fetch()
        print("working")
    }

    override func viewDidAppear(animated: Bool) {
       fetch()
 }

    func fetch() {
        let query = PFQuery(className:"friends")
        query.whereKey("follower", equalTo:"\(PFUser.currentUser()!.username!)")
        
        
        query.findObjectsInBackgroundWithBlock { (objects , err ) -> Void in
            if err == nil {
                print("no error")
                self.friendsArray = objects!
                self.tableView.reloadData()
                self.refresher.endRefreshing()
                print(objects!)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cells", forIndexPath: indexPath)
        let k = friendsArray[indexPath.row]
       cell.textLabel?.text = k.objectForKey("following") as? String
       cell.detailTextLabel?.text = (k["email"] as! String)

        return cell
    }
    
    // delegate methods
    
  override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      localStringForSelectedUser = cell?.textLabel?.text!
    let dstvc = friendsImagesCollectionViewController()
    dstvc.stringForRecevingUser = localStringForSelectedUser
    sstr = localStringForSelectedUser!
//    let destinationVc = chatViewController()
    print(localStringForSelectedUser!)

        performSegueWithIdentifier("toDetailViewController", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! friendsImagesCollectionViewController
        dest.stringForRecevingUser = localStringForSelectedUser!
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

   
    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier! == "toDetailViewController" {
//            
//        let dvc = segue.destinationViewController as! friendsImagesCollectionViewController
//         dvc.stringForRecevingUser = localStringForSelectedUser!
//            
//        }
//        
//      
//    }

    
  


}
