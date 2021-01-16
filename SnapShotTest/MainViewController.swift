//
//  ViewController.swift
//  SnapShotTest
//
//  Created by Eva Madarasz on 12.09.20.
//  Copyright © 2020 Eva Madarasz. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    @IBOutlet var cutOut: UIView!
    @IBOutlet var canvasImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    var imageArray: [UIImage]? = nil
  //  let vc = MainViewController()
    var originalImage = [UIImage]()
    var croppedImage = UIImage.cropImage
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        
        if segue.identifier == "PlayfieldSegue" {
            
            if let dest = segue.destination as? PlayfieldViewController {
                if let imageArrayUnwrapped = self.imageArray {
                    dest.imageArray = imageArrayUnwrapped
                }
                
                if segue.identifier == "PlayfieldSegue" {
                    let destinationVC = segue.destination as! PlayfieldViewController
                    destinationVC.imageArray = originalImage
                  //  vc.croppedImage = croppedImage
                    
                }
//                if let dest = segue.destination as? PlayfieldViewController {
//                    if let originalImagePrepared  = self.originalImage {
//                        vc.originalImage = originalImagePrepared
//                    }
//                  //  self.performSegue(withIdentifier: "PlayfieldSegue", sender: nil)
//                }
            }
        }
    }

  
    
    @IBAction func startButton(_ sender: Any) {
        
        let screenshot = self.view.takeScreenshot()
        let croppedImage =  screenshot.cropImage(toRect: cutOut.frame)
        self.imageArray = croppedImage?.splitImage(row: 4, column: 4)
        self.performSegue(withIdentifier: "PlayfieldSegue", sender: nil)
        
       
        
    }
}
