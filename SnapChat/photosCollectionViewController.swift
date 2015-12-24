//
//  photosCollectionViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 12/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class photosCollectionViewController: PFQueryCollectionViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.sectionInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
            
            layout.minimumInteritemSpacing = 5.0
            
        }
        
    }
    
    
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            let bounds = UIEdgeInsetsInsetRect(view.bounds, layout.sectionInset)
            
            let sideLength = min(CGRectGetWidth(bounds), CGRectGetHeight(bounds)) / 2.0 - layout.minimumInteritemSpacing
            
            layout.itemSize = CGSizeMake(sideLength, sideLength)
            
        }
        
    }
    
    
    
    // MARK: Data
    
    
    
    override func queryForCollection() -> PFQuery {
        
        var query = PFUser.query()
        query?.whereKey("username", equalTo: PFUser.currentUser()!)
       // query?.whereKeyExists("photos")
        
        query!.cachePolicy = PFCachePolicy.NetworkOnly
       return query!
        
    }
    
    
    
    // MARK: CollectionView
    
    
    
    override func collectionView(collectionView: UICollectionView,
        
        cellForItemAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFCollectionViewCell? {
            
            let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath,
                
                object: object)
            
  if let imageFiles = object?["photos"] as? [PFFile] {
                
                if let imageFile = imageFiles[indexPath.row] as? PFFile {
                    
                    imageFile.getDataInBackgroundWithBlock({ (imageData, error ) -> Void in
                        if error == nil {
                            print("error occured while retreving pffile")
                        }
                        else {
                            cell?.imageView.image = UIImage(data: imageData!)
                        }
                    })
                }
            }
    cell?.contentView.layer.borderWidth = 1.0
    cell?.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
    return cell

}
}

