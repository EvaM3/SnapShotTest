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
    var originalImage = UIImage()
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "PlayfieldSegue" {
            
            if let dest = segue.destination as? PlayfieldViewController {
                dest.originalImage = originalImage
            }
        }
    }
    
    
    
    @IBAction func startButton(_ sender: Any) {
        let screenshot = self.view.takeScreenshot()
        let croppedImage =  screenshot.cropImage(toRect: cutOut.frame)
        originalImage = croppedImage ?? UIImage()
        self.performSegue(withIdentifier: "PlayfieldSegue", sender: nil)
    }
}
