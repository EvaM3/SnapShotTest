//
//  UIImage+takeScreenShot.swift
//  SnapShotTest
//
//  Created by Eva Madarasz on 08.10.20.
//  Copyright © 2020 Eva Madarasz. All rights reserved.
//

import UIKit

extension UIView {
    
    func takeScreenshot() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = image {
            return image
        } else {
            return UIImage()
        }
        
    }
    
    
    
}
