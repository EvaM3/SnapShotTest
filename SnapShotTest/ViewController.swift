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
    var imageArray: [UIImage]? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        
        if segue.identifier == "PlayfieldSegue" {
            
            if let dest = segue.destination as? PlayfieldViewController {
                if let imageArrayUnwrapped = self.imageArray {
                    dest.imageArray = imageArrayUnwrapped
                }
            }
        }
    }

  
    
    @IBAction func startButton(_ sender: Any) {
        
        let screenshot = self.view.takeScreenshot()
        let croppedImage =  screenshot.cropImage(toRect: cutOut.frame)
        self.imageArray = croppedImage?.splitImage(row: 4, column: 4)
        self.performSegue(withIdentifier: "PlayfieldSegue", sender: nil)
        
        let originalImage = croppedImage
        
    }
}
