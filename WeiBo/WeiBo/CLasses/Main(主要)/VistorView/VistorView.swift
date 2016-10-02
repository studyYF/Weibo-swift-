//
//  VistorView.swift
//  Weibo
//
//  Created by YF on 16/9/30.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class VistorView: UIView {
    //MARK: -提供快速创建xib的类方法
    class func vistorView() ->VistorView {
        return NSBundle.mainBundle().loadNibNamed("VistorView", owner: nil, options: nil).first as! VistorView
    }
    
    //MARK: - 控件的属性
    
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!


    //MARK: - 自定义函数
    func setupVistorViewInfo(iconName : String , title : String ) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.hidden = true
    }
    
    func setAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = M_PI * 2
        rotationAnimation.repeatCount = MAXFLOAT
        rotationAnimation.duration = 5
        rotationAnimation.removedOnCompletion = false
        rotationView.layer .addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }
}




















