//
//  imageDetailViewController.swift
//  SnapChat
//
//  Created by Deepthi Kaligi on 14/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//

import UIKit
var index : Int?
class imageDetailViewController: UIViewController {
    @IBOutlet weak var imageView :  UIImageView!
    var indexForImage = 0
    var imgArray : [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
     imageView.image = imgArray[index!]
}
    




}
