//
//  PlayfieldViewController.swift
//  SnapShotTest
//
//  Created by Eva Madarasz on 26.10.20.
//  Copyright © 2020 Eva Madarasz. All rights reserved.
//

import UIKit



class PlayfieldViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var shuffledCollectionView: UICollectionView!    
    @IBOutlet var gameCollectionView: UICollectionView!
    
    
    var imageArray : [UIImage] = []
    var gameArray : [UIImage] = []   // with repeating and count
    let itemsPerRow: CGFloat = 4
    let sectionInsets = UIEdgeInsets(top: 90, left: 5, bottom: 10, right: 5)
    let collectionViewIdentifier = "PlayfieldCell"
    let gameCollectionViewIdentifier = "GameCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shuffledCollectionView.delegate = self
        gameCollectionView.delegate = self                     // Initialize the collection views, set the desired frames
        
        shuffledCollectionView.dataSource = self
        gameCollectionView.dataSource = self
        
        self.view.addSubview(shuffledCollectionView)
        self.view.addSubview(gameCollectionView)
    }
    
    
    
    //        self.collectionView.dataSource = self
    //        self.collectionView.delegate = self
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        let imageView = UIImageView(frame: cell.contentView.frame)
        if collectionView == shuffledCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayfieldCell", for: indexPath)
            imageView.image = imageArray[indexPath.row]
        }
        if collectionView == gameCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath)
            imageView.image =  UIImage()//gameArray[indexPath.row]       // can use .isEmpty
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green:255.0/255.0, blue:CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
        }
        
        
        cell.addSubview(imageView)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

