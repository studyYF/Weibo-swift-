//
//  StatusViewModel.swift
//  Weibo
//
//  Created by YF on 16/10/5.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

//MARK: - 把所有的要显示的属性都放在这里处理
class StatusViewModel: NSObject {
    //MARK: - 定义属性
    var status : StatusModel?
    
    ///来源text
    var sourceText : String?
    ///创建时间text
    var createAtText : String?
    ///用户类型图片
    var verified_image : UIImage?
    ///会员等级图片
    var mbrank_image : UIImage?
    ///用户头像地址
    var profileURL : NSURL?
    ///微博配图的url数组
    var pictureURLs : [NSURL] = [NSURL]()
    
    //MARK: - 自定义构造函数
    init(status : StatusModel) {
        super.init()
        self.status = status
        handleViewModel(status)
    }
}
//MARK: - 处理模型数据
extension StatusViewModel {
    private func handleViewModel(status : StatusModel) {
        //1.处理微博创建时间
        if let create_at = status.created_at  {
            createAtText = NSDate.createDateString(create_at)
        }
        
        //2.处理微博来源
        //where 表示两个条件都需要满足
        if let source = status.source where source != ""  {
            let startIndex = (source as NSString).rangeOfString(">").location + 1
            let length = (source as NSString).rangeOfString("</").location - startIndex
            sourceText = (source as NSString).substringWithRange(NSRange(location: startIndex, length: length))
        }
        
        //3.处理认证图标
        let verified_type = status.user?.verified_type ?? -1
        switch verified_type {
        case 0 :
            verified_image = UIImage(named: "avatar_vip")
        case 2,3,5 :
            verified_image = UIImage(named: "avatar_enterprise_vip")
        case 220 :
            verified_image = UIImage(named: "avatar_grassroot")
        default :
            verified_image = nil
        }
        //4.处理用户等级图标
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            mbrank_image = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        //5.处理用户头像url
        let profile_image_url = status.user?.profile_image_url ?? ""
        profileURL = NSURL(string: profile_image_url)
        //6.处理微博配图url
        let picURls = status.pic_urls!.count != 0 ? status.pic_urls : status.retweeted_status?.pic_urls
        if let pic_urls = picURls {
            for picDict in pic_urls {
                guard let urlString = picDict["thumbnail_pic"] else {
                    continue
                }
                pictureURLs.append((NSURL(string: urlString))!)
            }
        }
    }
}

