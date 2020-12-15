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
    let defaultImage : UIImage = UIImage(named: "placeHolder")!
    var shuffledArray : [UIImage] = []
    var gameArray : [UIImage] = []
    let itemsPerRow: CGFloat = 4
    let collectionViewIdentifier = "PlayfieldCell"
    let gameCollectionViewIdentifier = "GameCell"
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameArray = Array(repeating: defaultImage, count: 16)
        shuffledArray = imageArray.shuffled()
        
        
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
        
        
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_gesture:)))
        tapGesture.numberOfTapsRequired = 2
        shuffledCollectionView.addGestureRecognizer(tapGesture)
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        shuffledCollectionView.reloadData()
    }
    
    
    
    @objc private func didDoubleTap(_gesture: UITapGestureRecognizer) {
        gameArray = []
        shuffledArray = imageArray.shuffled()
        self.shuffledCollectionView.reloadData()
        self.gameCollectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth : CGFloat = collectionView.frame.width
        let widthPerItem : CGFloat = collectionViewWidth / CGFloat(itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
        func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.zero
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
                    self.gameArray.remove(at: destinationIndexPath.row)
                    self.gameArray.insert(newImage, at: destinationIndexPath.row)
                    collectionView.reloadData()
                    if let removeIndexPath = coordinator.items.first?.dragItem.localObject as? IndexPath  {
                        self.shuffledArray.remove(at:removeIndexPath.row)
                        self.shuffledArray.insert(self.defaultImage, at: removeIndexPath.row)
                        self.shuffledCollectionView.reloadData()
                    }
                    
                    
                }
            }
        }
        
        
    }
    
    
    
    
}



//    // let sectionInsets = UIEdgeInsets()
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
