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
    ///转发微博
    var retweeted_status : StatusModel?
    
    //MARK: - 自定义函数
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        ///将用户字典转成用户模型对象
         if let userDict = dict["user"] as? [String : AnyObject] {
            user = User(dict: userDict)
        }
        ///将转发微博字典转成转发微博模型
        if let retweetedDict = dict["retweeted_status"] as? [String : AnyObject] {
            retweeted_status = StatusModel(dict: retweetedDict)
        }
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
