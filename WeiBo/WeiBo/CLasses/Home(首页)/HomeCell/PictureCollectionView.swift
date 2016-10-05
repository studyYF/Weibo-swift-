//
//  PictureCollectionView.swift
//  Weibo
//
//  Created by YF on 16/10/5.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class PictureCollectionView: UICollectionView {
    //MARK: - 定义属性
    var pictureURLs : [NSURL] = [NSURL]() {
        didSet {
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
         dataSource = self
    }
}


//MARK: - collectionView的数据源
extension PictureCollectionView : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return pictureURLs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PictureCell", forIndexPath: indexPath) as! PictureCollectionViewCell
        cell.picUrl = pictureURLs[indexPath.item]
        return cell
    }
}


class PictureCollectionViewCell : UICollectionViewCell {
    //MARK: - 定义属性
    var picUrl : NSURL? {
        didSet {
            guard let picUrl = picUrl else {
                return
            }
            picImgv.sd_setImageWithURL(picUrl, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    
    //MARK: - 控件属性
    @IBOutlet weak var picImgv: UIImageView!
    
}


