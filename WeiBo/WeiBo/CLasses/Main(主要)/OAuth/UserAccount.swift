//
//  UserAccount.swift
//  Weibo
//
//  Created by YF on 16/10/3.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    //MARK: - 属性
    ///accessToken
    var access_token : String?
    ///用户id
    var uid : String?
    ///token过期时间
    var expires_in : NSTimeInterval = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow:expires_in)
        }
    }
    ///token过期时间
    var expires_date : NSDate?
    ///用户头像
    var avatar_large : String?
    ///用户昵称
    var screen_name : String?
    
    init (dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //重写下面方法,防止字典中有字段没有储存而报错 
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description : String {
        return dictionaryWithValuesForKeys(["access_token","uid","expires_date","avatar_large","screen_name"]).description
    }
}
