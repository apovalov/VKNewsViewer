//
//  GalleryCollectionView.swift
//  VKNewsFeed
//
//  Created by Macbook on 15.11.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photos = [FeedCellPhotoAttacmentViewModel]()
    
    init() {

        
        let rawLayout  = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rawLayout)
        
        delegate = self
        dataSource = self
        
        backgroundColor = UIColor.white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false

        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        
        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
    }

    func set(photos: [FeedCellPhotoAttacmentViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension GalleryCollectionView: RowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
}
