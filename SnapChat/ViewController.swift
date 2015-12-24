//
//  ViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 09/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    var accessToken = FBSDKAccessToken.currentAccessToken()

@IBAction func loginMethod() {
        
PFUser.logInWithUsernameInBackground(usernameTextField.text! , password:passwordTextField.text!) {
    (user: PFUser?, error: NSError?) -> Void in
    if user != nil {
     self.performSegueWithIdentifier("toTabBarController", sender:self)
    } else {
        if let error = error {
            let errorString = error.userInfo["error"] as? String
            self.showErrorMessage(errorString!)
        }
    
        }
    }
  
    }

    func showErrorMessage(errorString: String)-> () {
        let alert = UIAlertController(title: "Message", message:errorString, preferredStyle: UIAlertControllerStyle.Alert )
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action :UIAlertAction) -> Void in
            
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
   
 
@IBAction func fblogin() {
    
     let permissions = ["public_profile"]
    
    PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
    (user: PFUser?, error: NSError?) -> Void in
    if let user = user {
    if user.isNew {
        self.accessToken = FBSDKAccessToken.currentAccessToken()
        print("User signed up and logged in through Facebook!")
        self.performSegueWithIdentifier("toTabBarController", sender:self)

    } else {
        self.accessToken = FBSDKAccessToken.currentAccessToken()
    print("User logged in through Facebook!")
        self.performSegueWithIdentifier("toTabBarController", sender:self)

    }
    } else {
    print("Uh oh. The user cancelled the Facebook login.")
    }
        }
    
    
    
    }
    
    override func viewDidLoad() {
        
        if accessToken != nil {
        PFFacebookUtils.logInInBackgroundWithAccessToken(accessToken, block: {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("User logged in through Facebook via accesstoken!")
          self.performSegueWithIdentifier("toTabBarController", sender:self)
            } else {
                print("Uh oh. There was an error logging in.")
            }
        })

        }
     
 }
    override func viewDidAppear(animated: Bool) {
        // check user for logged in before or not
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("toTabBarController", sender:self)
      }
    }
    
  
}

