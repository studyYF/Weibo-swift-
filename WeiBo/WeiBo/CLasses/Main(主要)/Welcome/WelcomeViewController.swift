//
//  WelcomeViewController.swift
//  Weibo
//
//  Created by YF on 16/10/4.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit
import SDWebImage
class WelcomeViewController: UIViewController {
    //MARK: - 控件属性
    @IBOutlet weak var iconViewConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak var iconImgv: UIImageView!
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        let account = UserAccountTool.shareInstances.account
        let url = NSURL(string: account?.avatar_large ?? "")
        iconImgv.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar_default"))
        iconViewConstraintBottom.constant = UIScreen.mainScreen().bounds.height - 200
        UIView.animateWithDuration(2.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4.0, options: [], animations: { () -> Void in
                self.view.layoutIfNeeded()//闭包内需要使用self
            }) { (_) -> Void in
                UIApplication.sharedApplication().keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
    
}
