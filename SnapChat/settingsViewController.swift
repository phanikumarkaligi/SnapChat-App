//
//  settingsViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 15/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse

class settingsViewController: UITableViewController{
    var inf: [(String,String)] = []
    var mid : [String] = []
    var hedingsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         inf = [("starred messages","About and Help"),("SnapChat Web","Tell a friend")]
         mid = ["Account","Chats","Notifications","Data Usage"]
         hedingsArray = ["users","General","Policy Conditions"]
 }

    @IBAction func logout(sender:UIBarButtonItem!) {
        print("logged out")
        navigationController?.popToRootViewControllerAnimated(true)
    
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
   

    
    
    
    
    
    
    
    
    
    
    
    
    
}
