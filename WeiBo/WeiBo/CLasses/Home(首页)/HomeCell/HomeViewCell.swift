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

class HomeViewCell: UITableViewCell {
    //MARK: - 控件属性
    @IBOutlet weak var iconImgv: UIImageView!
    @IBOutlet weak var verifiedTypeImgv: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var mbrankLabel: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK: - 约束的属性
    @IBOutlet weak var contentWidthConstraints: NSLayoutConstraint!
    
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
        }
    }
    
    //MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        contentWidthConstraints.constant = UIScreen.mainScreen().bounds.width - edgeMargin * 2
    }

    

}
