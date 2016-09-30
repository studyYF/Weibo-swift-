//
//  UIButton-Extension.swift
//  Weibo
//
//  Created by YF on 16/9/30.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

extension UIButton {
    //在swift中,类方法以class开头的方法是类方法与OC中+一样
    class func  createButton(imageName : String, backImageName : String) ->UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: imageName + "highlighted"), forState: .Selected)
        button.setBackgroundImage(UIImage(named: backImageName), forState: .Normal)
        button.setBackgroundImage(UIImage(named: backImageName + "highlighted"), forState: .Selected)
        button.sizeToFit()
        return button
    }
    
    //convenience 便利,使用convenience修饰的构造函数,叫便利构造函数
    //convenience 通常是对系统的类定义构造函数的时候使用
    //特点
    //1.便利构造函数都是写在extension里面
    //2.便利构造函数在init前面加"convenience"
    //3.便利构造函数里面调用 self.init()
    convenience init (imageName : String,bgImageName : String) {
        self.init()
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "highlighted"), forState: .Selected)
        setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: bgImageName + "highlighted"), forState: .Selected)
        sizeToFit()
    }
    
}
