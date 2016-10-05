//
//  StatusModel.swift
//  Weibo
//
//  Created by YF on 16/10/4.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class StatusModel: NSObject {
    //MARK: -  属性
    ///微博创建时间
    var created_at : String? 
    ///微博来源
    var source : String?
    ///微博正文
    var text : String?
    ///微博id
    var mid : Int?
    ///用户属性
    var user : User?
    ///配图属性
    var pic_urls : [[String : String]]?
    
    //MARK: - 自定义函数
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
         if let userDict = dict["user"] as? [String : AnyObject] {
            user = User(dict: userDict)
        }
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
