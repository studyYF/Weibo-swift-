//
//  WBPresentationController.swift
//  Weibo
//
//  Created by YF on 16/10/2.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class WBPresentationController: UIPresentationController {
    
    //MARK: - 懒加载属性
    lazy var coverView = UIView()
    var presentFrame = CGRectZero

    //MARK: - 系统回调函数
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        //设置弹出视图的位置
        presentedView()?.frame = presentFrame
        setCoverView()
    }
}

//MARK: - 设置UI
extension WBPresentationController {
    ///设置UI控件
    func setCoverView() {
//        containerView?.addSubview(coverView)
        containerView?.insertSubview(coverView, atIndex: 0)
        coverView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        coverView.frame = containerView!.bounds
        let tap = UITapGestureRecognizer(target: self, action: "coverViewClick")
        coverView.addGestureRecognizer(tap)
    }
}


//MARK: - 事件监听
extension WBPresentationController {
    @objc private func coverViewClick() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}