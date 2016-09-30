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
}
