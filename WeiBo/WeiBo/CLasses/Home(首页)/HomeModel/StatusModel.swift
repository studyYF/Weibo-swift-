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
    var created_at : String? {
        didSet {
            guard let create_at = created_at else {
                return
            }
            createAtText = NSDate.createDateString(create_at)
        }
    }
    ///微博来源
    var source : String? {
        didSet{
            //where 表示两个条件都需要满足
            guard let source = source where source != "" else {
                return
            }
            let startIndex = (source as NSString).rangeOfString(">").location + 1
            let length = (source as NSString).rangeOfString("</").location - startIndex
            sourceText = (source as NSString).substringWithRange(NSRange(location: startIndex, length: length))
        }
    }
    ///微博正文
    var text : String?
    ///微博id
    var mid : Int?
    
    //MARK: - 对数据处理的属性
    ///来源text
    var sourceText : String?
    ///创建时间text
    var createAtText : String?
    //MARK: - 自定义函数
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
