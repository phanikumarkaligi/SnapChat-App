//
//  friendsImagesCollectionViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 15/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse
var sstr : String?
private let reuseIdentifier = "cells"

class friendsImagesCollectionViewController: UICollectionViewController {
  
    var stringForRecevingUser : String!
    var pics = [UIImage]()
    var usersArray : [PFObject]? = []
    var imageFiles : [PFFile]? = []
    var str : String = ""
    var rowIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

  let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 4
    layout.minimumLineSpacing  =  4
    layout.itemSize = CGSizeMake(150, 150)
    layout.sectionInset = UIEdgeInsetsMake(20, 8, 8, 8)
    collectionView?.collectionViewLayout = layout
     print("\(sstr)")

    }

    override func viewDidAppear(animated: Bool) {
        fetchImages()
    }
    
    
    
    func fetchImages() {
        let query = PFQuery(className:sstr!)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        let img = cell.viewWithTag(10) as! UIImageView
         img.image = pics[indexPath.row]
    
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
        rowIndex = indexPath.row
        performSegueWithIdentifier("toImageDetailViewController", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "toImageDetailViewController" {
            let destVC : friendsImagesDetailViewController = segue.destinationViewController as! friendsImagesDetailViewController
            destVC.tempImage = pics[rowIndex]
            
        }
    }


}
