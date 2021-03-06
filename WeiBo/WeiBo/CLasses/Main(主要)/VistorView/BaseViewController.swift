//
//  BaseViewController.swift
//  Weibo
//
//  Created by YF on 16/9/30.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    //MARK - 懒加载属性
    lazy var vistorView : VistorView = VistorView.vistorView()
    //MARK: - 定义变量
    var isLogin : Bool = UserAccountTool.shareInstances.isLogin
    //MARK: - 重写loadView方法
    override func loadView() {
//        //获取本地缓存的用户信息文件
//        var accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
//        accountPath = (accountPath as NSString).stringByAppendingPathComponent("account.plist")
//        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
//        //判断是否有保存文件,
//        if let account = account {
//            //判断accessToken是否过期
//            if let expires_date = account.expires_date {
//                isLogin = expires_date.compare(NSDate()) == NSComparisonResult.OrderedDescending
//            }
//            
//        }
        isLogin ? super.loadView() : setupVistorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavUI()
    }

}

//MARK: - 加载vistorView
extension BaseViewController {
    ///设置访客视图
    private func setupVistorView () {
        view = vistorView
        vistorView.loginButton.addTarget(self, action: "loginButtonClick", forControlEvents: .TouchUpInside)
        vistorView.registerButton.addTarget(self, action: "registerButtonClick", forControlEvents: .TouchUpInside)
    }
    ///设置导航栏视图
    func setNavUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "registerButtonClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "loginButtonClick")
    }
}

////MARK: - 事件监听
extension BaseViewController {
    ///登录
    @objc private func loginButtonClick() {
        let vc = OAuthViewController()
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }
    ///注册
    @objc private func registerButtonClick() {
        
    }
}