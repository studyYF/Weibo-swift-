//
//  UserAccountTool.swift
//  Weibo
//
//  Created by YF on 16/10/4.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

///不需要kvc,不继承NSObject,更轻量级
class UserAccountTool {
    
    //MARK: - 将该类定义成单例,当不同模块访问的时候只会创建一次
    static let shareInstances : UserAccountTool = UserAccountTool()
    //MARK: - 定义account属性
    var account : UserAccount?
    //MARK: - 定义accountPath计算属性
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        return (accountPath as NSString).stringByAppendingPathComponent("account.plist")
    }
    
    //MARK: - 定义是否登录的属性
    var isLogin : Bool {
        if account == nil {
            return false
        }
        guard let expries_date = account?.expires_date else {
            return false
        }
        return expries_date.compare(NSDate()) == NSComparisonResult.OrderedDescending
    }
    
    init () {
        //初始化的时候就获取存在本地的account类
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
    }
    
    
    
}
