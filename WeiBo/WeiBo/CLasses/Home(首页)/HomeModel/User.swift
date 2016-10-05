//
//  User.swift
//  Weibo
//
//  Created by YF on 16/10/5.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class User: NSObject {
    //MARK: - 定义属性
    ///头像
    var profile_image_url : String?
    ///用户昵称
    var screen_name : String?
    ///认证类型
    var verified_type : Int = -1 
    ///会员等级
    var mbrank : Int = 0
    
    //MARK: - 自定义构造函数,一定不能忘记调用super.init()
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
