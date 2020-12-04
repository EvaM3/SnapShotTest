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
    var shuffledArray : [UIImage] = []
    var gameArray : [UIImage] = []
    let itemsPerRow: CGFloat = 4
    let sectionInsets = UIEdgeInsets()
    let collectionViewIdentifier = "PlayfieldCell"
    let gameCollectionViewIdentifier = "GameCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    let shuffledArray = imageArray.shuffled()
        
        shuffledCollectionView.isUserInteractionEnabled = true
        shuffledCollectionView.dragInteractionEnabled = true
        gameCollectionView.dragInteractionEnabled = true
        shuffledCollectionView.dragDelegate = self
        gameCollectionView.dragDelegate = self
        shuffledCollectionView.dropDelegate = self
        gameCollectionView.dropDelegate = self
        
        self.shuffledCollectionView.delegate = self
        self.gameCollectionView.delegate = self
        
        self.shuffledCollectionView.dataSource = self
        self.gameCollectionView.dataSource = self
        
    
        
        shuffledCollectionView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_gesture:)))
        tapGesture.numberOfTapsRequired = 2
        shuffledCollectionView.addGestureRecognizer(tapGesture)
        


    }
    @objc private func didDoubleTap(_gesture: UITapGestureRecognizer) {
         let newShuffledArray = shuffledArray.shuffled()

                  }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == shuffledCollectionView {
            return shuffledArray.count
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
            imageView.image = shuffledArray[indexPath.row]
            
        }
        if collectionView == gameCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath)
            imageView.image = gameArray[indexPath.row]
        }
        imageView.frame = cell.contentView.frame
        cell.addSubview(imageView)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let provider = NSItemProvider(object: shuffledArray[indexPath.row])
        let dragItem = UIDragItem(itemProvider: provider)
        dragItem.localObject = indexPath
        return [dragItem]
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let itemCount = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(row: itemCount, section: 0)
            /* coordinator.destinationIndexPath provides the destination IndexPath where content is being dropped.
                                With default behavior.
                   */
        }
        coordinator.session.loadObjects(ofClass: UIImage.self) { (NSItemProviderReadingItems) in
            if let imagesDropped = NSItemProviderReadingItems as? [UIImage] {
                if imagesDropped.count > 0 {
                    let newImage = imagesDropped[0]
                    self.gameArray.insert(newImage, at: destinationIndexPath.row)
                    collectionView.insertItems(at: [destinationIndexPath])
            if let removeIndexPath = coordinator.items.first?.dragItem.localObject as? IndexPath  {
                self.shuffledArray.remove(at:removeIndexPath.row)
                self.shuffledCollectionView.reloadData()
                    }
    /* Loads the object of type UIImage from the NSItemProviderReadingItems.Read the first item, -this is the new image being dropped.Place to update datasource.Finally, collectionview inserts new item.*/
                    
        
                    

                }
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellSize = CGSize(width:80 , height:80)
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = cellSize
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
//        layout.minimumLineSpacing = 1.0
//        layout.minimumInteritemSpacing = 1.0
//
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//        return cellSize
//    }

    
    
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
