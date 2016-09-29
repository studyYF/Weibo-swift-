//
//  MainViewController.swift
//  Weibo
//
//  Created by YF on 16/9/30.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.orangeColor()
        
        addChildViewController(HomeViewController(), title: "首页", image: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", image: "tabbar_message_center")
        addChildViewController(DiscoverViewController(), title: "发现", image: "tabbar_discover")
        addChildViewController(ProfileViewController(), title: "我", image: "tabbar_profile")
    }

    //创建tabbar(private私有方法,在当前文件中可以访问,但是其他文件不能访问)
    private func addChildViewController(childVc: UIViewController, title : String, image : String) {
        //1.创建子控制器
//        let childVc = HomeViewController()
        //2.设置自控制器的属性
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: image)
        childVc.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
        //3.包装导航栏控制器
        let childNav = UINavigationController(rootViewController: childVc)
        //4.添加控制器
        addChildViewController(childNav)
    }
    


}
