//
//  ViewController.swift
//  SnapShotTest
//
//  Created by Eva Madarasz on 12.09.20.
//  Copyright © 2020 Eva Madarasz. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var cutOut: UIView!
    @IBOutlet var canvasImage: UIImageView!
    @IBOutlet var startButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: Any) {
        
        let screenshot = self.view.takeScreenshot()
        let croppedImage =  screenshot.cropImage(toRect: cutOut.frame)
        let imageArray = croppedImage?.splitImage(row: 4, column: 4)
        
        canvasImage.image = croppedImage
        canvasImage.setNeedsDisplay()
        UIImageWriteToSavedPhotosAlbum(croppedImage!, nil, nil, nil)
        if let images = imageArray {
            for image in images  {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
}








