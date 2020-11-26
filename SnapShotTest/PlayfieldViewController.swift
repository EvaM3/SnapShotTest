//
//  PlayfieldViewController.swift
//  SnapShotTest
//
//  Created by Eva Madarasz on 26.10.20.
//  Copyright © 2020 Eva Madarasz. All rights reserved.
//

import UIKit



class PlayfieldViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate,UICollectionViewDropDelegate {
    
    
    
    
    
    
    @IBOutlet var shuffledCollectionView: UICollectionView!    
    @IBOutlet var gameCollectionView: UICollectionView!
    
    
    var imageArray : [UIImage] = []
    var gameArray : [UIImage] = []
    let itemsPerRow: CGFloat = 4
    let sectionInsets = UIEdgeInsets()
    let collectionViewIdentifier = "PlayfieldCell"
    let gameCollectionViewIdentifier = "GameCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffledCollectionView.dragInteractionEnabled = true
        gameCollectionView.dragInteractionEnabled = true
        shuffledCollectionView.dragDelegate = self
        gameCollectionView.dragDelegate = self
        
        self.shuffledCollectionView.delegate = self
        self.gameCollectionView.delegate = self
        
        self.shuffledCollectionView.dataSource = self
        self.gameCollectionView.dataSource = self
        
        self.view.addSubview(shuffledCollectionView)
        self.view.addSubview(gameCollectionView)
    }
    
  //  change imageArray to shuffled array
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == shuffledCollectionView {
            return imageArray.count
        }
        if collectionView == gameCollectionView {
            return gameArray.count
        }
    return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        let imageView = UIImageView()
        if collectionView == shuffledCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayfieldCell", for: indexPath)
            imageView.image = imageArray[indexPath.row]
            
        }
        if collectionView == gameCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath)
            imageView.image = UIImage()  //gameArray[indexPath.row]
            cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green:255.0/255.0, blue:CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
        }
        imageView.frame = cell.contentView.frame
        cell.addSubview(imageView)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        print("")
    }     // good for dropping
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let provider = NSItemProvider(object: imageArray[indexPath.row])
        let dragItem = UIDragItem(itemProvider: provider)    // good for dragging
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width:80 , height:80)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return cellSize
    }
    
    
    
}






//func collectionView(_ collectionView: UICollectionView,
//                    layout collectionViewLayout: UICollectionViewLayout,
//sizeForItemAt indexPath: IndexPath) -> CGSize {
//
// let itemsPerRow: CGFloat = 4
//let collectionViewWidth: CGFloat = collectionview.frame.width
//let widthPerItem: CGFloat = collectionViewWidth / itemsPerRow
//
//return CGSize(width: widthPerItem, height: widthPerItem)
//
//}
//






















//
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
