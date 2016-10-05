//
//  HomeViewCell.swift
//  Weibo
//
//  Created by YF on 16/10/5.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

//MARK: - 距离左右边界的距离
private let edgeMargin : CGFloat = 15
private let itemMargin : CGFloat = 10

class HomeViewCell: UITableViewCell {
    //MARK: - 控件属性
    @IBOutlet weak var iconImgv: UIImageView!
    @IBOutlet weak var verifiedTypeImgv: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var mbrankLabel: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var picCollectionView: PictureCollectionView!
    
    //MARK: - 约束的属性
    @IBOutlet weak var contentWidthConstraints: NSLayoutConstraint!
    @IBOutlet weak var picCollectionViewWidthCons: NSLayoutConstraint!
    @IBOutlet weak var picCollectionVieHeightCons: NSLayoutConstraint!
    
    //MARK: - 定义model属性
    var viewModel : StatusViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            iconImgv.sd_setImageWithURL(viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default_small"))
            verifiedTypeImgv.image = viewModel.verified_image
            screenNameLabel.text = viewModel.status?.user?.screen_name
            mbrankLabel.image = viewModel.mbrank_image
            createdAtLabel.text = viewModel.createAtText
            sourceLabel.text = viewModel.sourceText
            contentLabel.text = viewModel.status?.text
            screenNameLabel.textColor = viewModel.mbrank_image == nil ? UIColor.blackColor() : UIColor.orangeColor()
            let picCollectionViewSize = calculatePicCollectionViewSize(viewModel.pictureURLs.count)
            picCollectionViewWidthCons.constant = picCollectionViewSize.width
            picCollectionVieHeightCons.constant = picCollectionViewSize.height
            picCollectionView.pictureURLs = viewModel.pictureURLs
        }
    }
    
    //MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        contentWidthConstraints.constant = UIScreen.mainScreen().bounds.width - edgeMargin * 2
        let flowLayout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let imageViewWH = (UIScreen.mainScreen().bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        flowLayout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
    }
}

//MARK: - 计算
extension HomeViewCell {
    private func calculatePicCollectionViewSize(count : Int) -> CGSize {
        // 1.没有配图
        if count == 0 {
            return CGSizeZero
        }
        
        // 2.计算出来imageViewWH
        let imageViewWH = (UIScreen.mainScreen().bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        
        // 3.四张配图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        // 4.其他张配图
        // 4.1.计算行数
        let rows = CGFloat((count - 1) / 3 + 1)
        
        // 4.2.计算picView的高度
        let picViewH = rows * imageViewWH + (rows - 1) * itemMargin
        
        // 4.3.计算picView的宽度
        let picViewW = UIScreen.mainScreen().bounds.width - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
    }
}
