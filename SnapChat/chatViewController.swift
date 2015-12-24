//
//  chatViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 17/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse

class chatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      let query = PFQuery(className: runningUser)
   query.findObjectsInBackgroundWithBlock { (objets, err ) -> Void in
    if err == nil {
        for o in objets! {
            self.messaages.append(o.objectForKey("messages") as! String)
 }
    }  else {
        print(err)
    }
    self.tableView.reloadData()
    
        }
        
        
        

    }
    @IBOutlet weak var tableView : UITableView!
    var runningUser = ""
    var messaages : [String] = []
    @IBOutlet weak var chatTextField : UITextField!
    @IBAction func send() {
        print(runningUser)
        
     let object = PFObject(className:runningUser)
       object["messages"] = chatTextField.text!
     object.saveInBackgroundWithBlock { (success, err ) -> Void in
        if err == nil {
            print("posted the msg")
        }
        else {
            print("error posting msg")
            print(err)
        }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messaages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cells", forIndexPath: indexPath)
        cell.textLabel?.text = messaages[indexPath.row]
        
     
        
        return cell
 
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     
        return 1
    }
     
    
    
    

}
