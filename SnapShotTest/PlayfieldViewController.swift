//
//  PlayfieldViewController.swift
//  SnapShotTest
//
//  Created by Eva Madarasz on 26.10.20.
//  Copyright © 2020 Eva Madarasz. All rights reserved.
//

import UIKit
import Social




class PlayfieldViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate,UICollectionViewDropDelegate {
    
    @IBOutlet var shuffledCollectionView: UICollectionView!    
    @IBOutlet var gameCollectionView: UICollectionView!
    @IBOutlet var lookUpButton: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    
    
    var imageArray : [UIImage] = []
    var originalImage = UIImage()
    let defaultImage : UIImage = UIImage(named: "placeHolder")!
    var shuffledArray : [UIImage] = []
    var gameArray : [UIImage] = []
    let itemsPerRow: CGFloat = 4
    let collectionViewIdentifier = "PlayfieldCell"
    let gameCollectionViewIdentifier = "GameCell"
    var gameTimer: Timer?
    var score = 0
    var hintImage = UIImageView()
    
    
    @objc func showHintImage() {
        hintImage.image = originalImage
        hintImage.contentMode = .scaleToFill
        hintImage.frame = gameCollectionView.frame
        self.view.addSubview(hintImage)
        self.gameCollectionView.isHidden = true
        self.view.bringSubviewToFront(hintImage)
        gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(removeHintImage), userInfo: nil, repeats: false)
    }
    @objc func removeHintImage() {
        self.view.sendSubviewToBack(hintImage)
        self.hintImage.removeFromSuperview()
        self.gameCollectionView.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageArray = originalImage.splitImage(row: Int(itemsPerRow), column: Int(itemsPerRow))
        scoreLabel.text = "Score: \(score)"
        gameArray = Array(repeating: defaultImage, count: 16)
        shuffledArray = imageArray
        
        self.navigationController?.isNavigationBarHidden = true
        shuffledCollectionView.isScrollEnabled = false
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
        shuffledCollectionView.layoutSubviews()
        self.navigationController?.isNavigationBarHidden = true
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_gesture:)))
        tapGesture.numberOfTapsRequired = 2
        shuffledCollectionView.addGestureRecognizer(tapGesture)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        shuffledCollectionView.reloadData()
    }
    
    func restartGame() {
        self.gameArray.removeAll()
        self.score = 0
        self.scoreLabel.text = "Score \(score)"
        self.shuffledCollectionView.reloadData()
    }
    
    func increaseScore(n: Int = 1) {
        score += n
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc private func didDoubleTap(_gesture: UITapGestureRecognizer) {
        gameArray = Array(repeating: defaultImage, count: 16)
        shuffledArray = imageArray.shuffled()
        self.shuffledCollectionView.reloadData()
        self.gameCollectionView.reloadData()
        increaseScore(n: 5)
    }
    
    
    func solvedPuzzle() {
        if self.gameArray == self.imageArray {
            let alert = UIAlertController(title: "You Won!", message: "Congratulations✌️", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let shareMyText = "My score on Gridy is \(score)"
            let activityVc = UIActivityViewController(activityItems: [shareMyText], applicationActivities: nil)
            present(activityVc, animated: true, completion: nil)
            if let popOver = activityVc.popoverPresentationController {
                popOver.sourceView = view
                popOver.sourceView?.center = view.center
            }
            alert.addAction(okAction)
            self.present(alert,animated: true, completion: nil)
        }
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
    
    @IBAction func lookUpButtonTapped(_ sender: UIButton) {
        showHintImage()
        increaseScore()
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        
    navigationController?.popToRootViewController(animated: true)
      restartGame()
        //self.dismiss(animated: false, completion: nil)
    
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
        cell.layoutIfNeeded()
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth : CGFloat = collectionView.frame.width
        let widthPerItem : CGFloat = collectionViewWidth / CGFloat(itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == shuffledCollectionView {
                  return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
              } else {
              return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
          }
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == shuffledCollectionView {
            return 1
        } else {
        return 0
    }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == shuffledCollectionView {
            return 1
        } else {
        return 0
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if shuffledArray[indexPath.row] == defaultImage {
            return [UIDragItem]()
        }
        let item = self.shuffledArray[indexPath.row]
        let itemProvider = NSItemProvider(object: item)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = indexPath   // attaching a sticker to it
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {  //unwrapping
            destinationIndexPath = indexPath
        } else {
            let itemCount = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(row: itemCount, section: 0)
            
        }
        
        coordinator.session.loadObjects(ofClass: UIImage.self) { (NSItemProviderReadingItems) in
            if let imagesDropped = NSItemProviderReadingItems as? [UIImage] {
                if imagesDropped.count > 0 {
                    if let removeIndexPath = coordinator.items.first?.dragItem.localObject as? IndexPath  {  // reading  the sticker info
                        self.gameArray.remove(at: destinationIndexPath.row)
                        self.gameArray.insert(self.shuffledArray[removeIndexPath.row], at: destinationIndexPath.row)
                        collectionView.reloadData()
                        
                        self.shuffledArray.remove(at:removeIndexPath.row)
                        self.shuffledArray.insert(self.defaultImage, at: removeIndexPath.row)
                        self.shuffledCollectionView.reloadData()
                        self.increaseScore()
                        self.solvedPuzzle()
                    }
                    
                    
                }
            }
            
            
            
            
            
        }
        
        
    }
    
}









