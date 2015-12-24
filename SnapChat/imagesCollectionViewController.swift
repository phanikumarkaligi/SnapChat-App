//
//  imagesCollectionViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 12/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse


private let reuseIdentifier = "cells"

class imagesCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var pics = [UIImage]()
    var usersArray : [PFObject]? = []
    var imageFiles : [PFFile]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
      
     let layout = UICollectionViewFlowLayout()
     layout.minimumInteritemSpacing = 4
    layout.minimumLineSpacing = 4
    layout.itemSize = CGSizeMake(150, 150)
     layout.sectionInset = UIEdgeInsetsMake(20, 8, 8, 8)
    collectionView?.collectionViewLayout = layout
        
     fetch()
      // code for fetching data from PFUser
//    let query = PFUser.query()
//    query?.whereKey("username", equalTo: PFUser.currentUser()!)
//    
//        
//        query?.findObjectsInBackgroundWithBlock({ (objects:[PFObject]?, err : NSError?) -> Void in
//         if err  == nil
//         {
//            let user  = objects?.last! as? PFUser
//            self.imageFiles = user?.objectForKey("photos") as? [PFFile]
//          }
//         })
//        
//        for o in self.imageFiles! {
//            o.getDataInBackgroundWithBlock({ (data , err) -> Void in
//                self.pics.append(UIImage(data: data!)!)
//                print("successfully converted data to images")
//            })
//        }
        

        // code for pfobject data fetching
      
        
 // Register cell classes
//        self.collectionView!.registerClass(customCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        fetch()
    }
    
 
    func fetch() {
        
        let query = PFQuery(className: "\(PFUser.currentUser()!.username!)")
        //   query.selectKeys("photos")
        //  query.whereKeyExists("photos")
        
        query.findObjectsInBackgroundWithBlock({ (objectsArray, err) -> Void in
            
            self.usersArray = objectsArray!
            print(self.usersArray)
            self.methodForConvertingDataArrayToImageArray()
            
        })
    }
    
    func methodForConvertingDataArrayToImageArray() {
        for o in self.usersArray! {
          let k = o.objectForKey("images") as? PFFile
            self.pics.removeAll()
            k!.getDataInBackgroundWithBlock({ (data, err) -> Void in
                self.pics.append(UIImage(data: data!)!)
                print("successfully converted data to images")
            print(k)
                self.collectionView?.reloadData()

            })
        }
  }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pics.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    //  cell.backgroundColor = UIColor.grayColor()
        
      //  cell.backgroundView = pics[indexPath.row]
     //   let imgView = UIImageView(image: pics[indexPath.row])
        let imgvw = cell.viewWithTag(10) as? UIImageView
        imgvw?.image = pics[indexPath.row]
        
        cell.backgroundView = imgvw
        
        print("control in cell for row at ")

        return cell
    
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        index = indexPath.row
        performSegueWithIdentifier("toImageDetailViewController", sender: self)
        
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "toImageDetailViewController" {
            let destVC : imageDetailViewController = segue.destinationViewController as! imageDetailViewController
            destVC.imgArray = pics
            
        }
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//
//    }
//    
    

}
