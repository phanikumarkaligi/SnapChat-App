//
//  userPageViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 11/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse

class userPageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var imgview : UIImageView!
    @IBOutlet weak var uploadStatusView : UIView!
    var activityIndicator :UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PFUser.currentUser()!)
    }

    @IBAction func uploadPicture() {
        
      let imagepickerController = UIImagePickerController()
      imagepickerController.sourceType = .PhotoLibrary
      imagepickerController.delegate = self
      presentViewController(imagepickerController, animated: true, completion: nil)
     
        
    }
 
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imgview.image = image
     //   upload(image)
        uploadToclassObject(image)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
    
    func upload(image : UIImage) {
        
     //   let image = UIImage(named:"field.jpg")
        let imgdata = UIImageJPEGRepresentation(image
            , 0.5)
        let imgFile = PFFile(data: imgdata!)
       
      imgFile?.saveInBackgroundWithBlock({ (success, error ) -> Void in
        if error == nil {
            print("image saved")
           self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.removeFromSuperview()
           self.view.sendSubviewToBack(self.uploadStatusView)
            
        }
      
        },progressBlock:{( prog)-> () in
            self.view.bringSubviewToFront(self.uploadStatusView)
             self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
            self.activityIndicator.center = self.view.center
            self.activityIndicator.startAnimating()
            self.view.addSubview(self.activityIndicator)
            print(prog) })
    
    
 let user = PFUser.currentUser()
        user?.addUniqueObject(imgFile!, forKey: "photos")
    //    user?.setObject(imgFile!, forKey: "photo")
        user?.saveInBackgroundWithBlock({ (success, error ) -> Void in
            if  success {
                print ("successfully uploaded")
            }
            else {
                print("not uploaded")
            }
        })
        
}
    
    func uploadToclassObject(image : UIImage) {
        let data = UIImageJPEGRepresentation(image, 0.5)
        let file = PFFile(data: data!)
        file?.saveInBackgroundWithBlock({ (success, err) -> Void in
            if success {
                print ("suceess")
            }
        })
       let obj = PFObject(className: "\(PFUser.currentUser()!.username!)")
        print(obj)
    obj["images"] = file!
      //  obj.addObject(file!, forKey:"photos")
        obj.saveInBackgroundWithBlock { (success, err) -> Void in
            if success {
                print("successfully saved to object")
            }
        }
        
    }
    
    
}


