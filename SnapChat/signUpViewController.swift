//
//  signUpViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 09/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse

class signUpViewController: UIViewController {
// properties 
    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    var userRegistrationSuccessful = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 @IBAction   func signUpMethod() {
        let user = PFUser()
    if usernameTextField.text != nil && passwordTextField.text != nil && emailTextField.text != nil {
        
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        // other fields can be set just like with PFObject
       // user["phone"] = "415-392-0202"
    
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? String
                self.showErrorMessage(errorString!)
            } else {
                self.showErrorMessage("SignUp Successful!")
               // self.cancelMethod()
                self.userRegistrationSuccessful = true
            }
            
        }
    }
     else {
          self.showErrorMessage("please fill in all fields")
    }
    }
 
    @IBAction func cancelMethod() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resetFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        emailTextField.text = ""
 }
  
    func showErrorMessage(errorString: String)-> () {
        let alert = UIAlertController(title: "Message", message:errorString, preferredStyle: UIAlertControllerStyle.ActionSheet )
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action :UIAlertAction) -> Void in
            self.resetFields()
            if self.userRegistrationSuccessful {
                self.cancelMethod()
            }
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
   

}
