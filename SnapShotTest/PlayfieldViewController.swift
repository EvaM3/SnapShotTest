//
//  PlayfieldViewController.swift
//  SnapShotTest
//
//  Created by Eva Madarasz on 26.10.20.
//  Copyright © 2020 Eva Madarasz. All rights reserved.
//

import UIKit



class PlayfieldViewController: UIViewController, UICollectionViewDataSource {
   var imageArray : [UIImage] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count    }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayfieldCell", for: indexPath)
          //cell.self.addSubview(imageArray)      - need to convert
         // cell.backgroundView = imageArray
           return cell
       }
    // Create your own cell.Copy the code from the colorcell. Alternatives: Instead colorcell, actual image on imagearray.show an image
                                                                     
}
class PlayfieldCustomCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PlayfieldCustomCell {
    fileprivate func setup() {
        self.addSubview(imageView)
        imageView.topAnchor.self
        imageView.leftAnchor.self
        imageView.bottomAnchor.self
        imageView.rightAnchor.self
        // padding, width and height still missing.
    }
    
  
}

