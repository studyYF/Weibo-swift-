//
//  HomeViewController.swift
//  Weibo
//
//  Created by YF on 16/9/30.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    //MARK: - 懒加载属性
    private lazy var titleButton : TitleButton = TitleButton()
    //这里的闭包会造成循环引用,所以需要进行处理[weak self],处理后,self变成了可选类型,所以要对self解包
    private lazy var popoverAnimation : PopoverViewAnimation = PopoverViewAnimation { [weak self] (isPresented) -> () in
         self!.titleButton.selected = isPresented
    }
    //MARK: - 系统会掉函数
    override func viewDidLoad() {
        super.viewDidLoad()
        vistorView.setAnimation()
        ///如果没有登录,直接返回
        if !isLogin {
            return
        }
        ///设置导航栏内容
        setUpNavigationBar()
    }


}

//MARK: - 设置UI界面
extension HomeViewController {
    private func setUpNavigationBar() {
        //设置左侧item(将下面的方法抽取出来,在UIBarButtonItem里面)
//        let leftButton = UIButton()
//        leftButton.setImage(UIImage(named: "navigationbar_friendattention"), forState: .Normal)
//        leftButton.setImage(UIImage(named: "navigationbar_friendattention_highlighted"), forState: .Highlighted)
//        leftButton.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        //设置右侧的item
//        let rightButton = UIButton()
//        rightButton.setImage(UIImage(named: "navigationbar_pop"), forState: .Normal)
//        rightButton.setImage(UIImage(named: "navigationbar_pop_highlighted"), forState: .Highlighted)
//        rightButton.sizeToFit()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        //设置中间的titleView(将自定义创建button方法抽取到TitleButton类里面)
//        titleButton.setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
//        titleButton.setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
//        titleButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleButton.setTitle("我的微博", forState: .Normal)
        titleButton.addTarget(self, action: "titleButtonClick", forControlEvents: .TouchUpInside)
//        titleButton.sizeToFit()
        navigationItem.titleView = titleButton
    }
}
//MARK: - 事件监听函数
extension HomeViewController {
    @objc private func titleButtonClick() {
        
        //弹出自定义控制器
        let popVC = PopoverViewController()
        popVC.modalPresentationStyle = .Custom
        //自定义转场
        popVC.transitioningDelegate = popoverAnimation
        popoverAnimation.presentFrame = CGRectMake(UIScreen.mainScreen().bounds.width * 0.5 - 90, 55, 180, 250)
        presentViewController(popVC, animated: true, completion: nil)
    }
}


