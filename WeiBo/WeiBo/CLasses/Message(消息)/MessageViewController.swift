//
//  MessageViewController.swift
//  Weibo
//
//  Created by YF on 16/9/30.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        vistorView.setupVistorViewInfo("visitordiscover_image_message", title: "登录后别人评论你的微博,给你发消息,都会在这里收到通知")
    }

    
}
