//
//  HintImage.m
//  SnapShotTest
//
//  Created by Eva Madarasz on 08.01.21.
//  Copyright © 2021 Eva Madarasz. All rights reserved.
//

#import <Foundation/Foundation.h>


@objc func showHintImage() {
//UIImage.splitImage(on: self)
                           // hintImage.image = UIImage(named: imageArray)
                      hintImage.backgroundColor = .white
                      hintImage.contentMode = .scaleAspectFit
                      hintImage.frame = self.view.frame
                      self.view.addSubview(hintImage)
                      self.gameCollectionView.isHidden = true
                      self.view.bringSubviewToFront(hintImage)
                      gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(removeHintImage), userInfo: nil, repeats: false)
                       }
@objc func removeHintImage() {
                             self.view.sendSubviewToBack(hintImage)
                             self.gameCollectionView.isHidden = false

                          }

