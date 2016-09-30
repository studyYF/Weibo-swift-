//
//  MainViewController.swift
//  Weibo
//
//  Created by YF on 16/9/30.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    //类方法创建button
//    private lazy var composeButton = UIButton.createButton("tabbar_compose_icon_add", backImageName: "tabbar_compose_button")
    // 构造方法创建button
    private lazy var composeButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    private lazy var seletecdImageName = ["tabbar_home","tabbar_message_center","","tabbar_discover","tabbar_profile"]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComposeButton()
    }

}

//MARK: - 初始化UI
extension MainViewController {
    private func setComposeButton() {
//        composeButton.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
//        composeButton.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Selected)
//        composeButton.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
//        composeButton.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Selected)
        composeButton.sizeToFit()
        composeButton.center = CGPointMake(tabBar.center.x, tabBar.bounds.size.height * 0.5)
        tabBar .addSubview(composeButton)
    }
    
    private func setTabBarItem() {
        for i in 0..<tabBar.items!.count  {
            let item = tabBar.items![i]
            if i == 2 {
                item.enabled = false
                continue
            }
            item.selectedImage = UIImage(named: seletecdImageName[i] + "_highlighted")
        }
    }
}

//MARK: - 纯代码创建tabbar
extension MainViewController {
    //        guard let jsonPath = NSBundle.mainBundle().pathForResource("", ofType:".json") else {
    //            return
    //        }
    //        guard let data = NSData(contentsOfFile: jsonPath) else {
    //            return
    //        }
    //
    //        //某个方法后面如果有throws,则该方法会抛出异常,则要对该异常进行处理,swift中提供了三种处理异常的方式
    //        //1.try方式 程序员手动处理异常
    //        do {
    //            try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
    //        } catch {
    //            print(error)
    //        }
    //
    //        //2.try?方式,系统帮助我们处理,如果有异常,返回nil,如果没有异常则返回对象
    //        //3.try! 直接告诉系统,该方法没有异常,
    //        guard let anyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) else {
    //            return
    //        }
    //        guard let dictArray = anyObject as? [[String : AnyObject]] else {
    //            return
    //        }
    //
    //        for dic in dictArray {
    //            guard let className = dic["className"] as? String else {
    //                continue
    //            }
    //            guard let title = dic["title"] as? String else {
    //                continue
    //            }
    //
    //            guard let imageName = dic["imageName"] as? String else {
    //                continue
    //            }
    //            addChildViewController(className, title: title, image: imageName)
    //        }
    //
    //        addChildViewController(HomeViewController(), title: "首页", image: "tabbar_home")
    //        addChildViewController(MessageViewController(), title: "消息", image: "tabbar_message_center")
    //        addChildViewController(DiscoverViewController(), title: "发现", image: "tabbar_discover")
    //        addChildViewController(ProfileViewController(), title: "我", image: "tabbar_profile")
    //    }
    //
    //    //创建tabbar(private私有方法,在当前文件中可以访问,但是其他文件不能访问)
    //    private func addChildViewController(childVc: UIViewController, title : String, image : String) {
    //        //1.创建子控制器
    ////        let childVc = HomeViewController()
    //        //2.设置自控制器的属性
    //        childVc.title = title
    //        childVc.tabBarItem.image = UIImage(named: image)
    //        childVc.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
    //        //3.包装导航栏控制器
    //        let childNav = UINavigationController(rootViewController: childVc)
    //        //4.添加控制器
    //        addChildViewController(childNav)
}
