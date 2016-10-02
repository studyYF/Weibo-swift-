//
//  UIBarButtonItem-Extension.swift
//  Weibo
//
//  Created by YF on 16/10/2.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit
//MARK: - 自定义构造函数
extension UIBarButtonItem {
    
    convenience init(imageName : String) {
        //方法一
//        self.init()
//        let button = UIButton()
//        button.setImage(UIImage(named: imageName), forState: .Normal)
//        button.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
//        button.sizeToFit()
//        self.customView = button
        //方法二
        let button = UIButton()
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        button.sizeToFit()
        self.init(customView : button)
    }
}




