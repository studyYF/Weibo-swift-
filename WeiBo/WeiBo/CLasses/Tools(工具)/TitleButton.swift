//
//  TitleButton.swift
//  Weibo
//
//  Created by YF on 16/10/2.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    override init(frame: CGRect) {
        //必须调用父类的init方法
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        sizeToFit()
    }

    //swift中重写控件的init(frame:CGRect)方法 和 init() 方法,必须重写init(coder aDecoder: NSCoder)方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }
}
