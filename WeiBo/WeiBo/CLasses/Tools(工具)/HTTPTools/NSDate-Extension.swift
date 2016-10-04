//
//  NSDate-Extension.swift
//  Weibo
//
//  Created by YF on 16/10/4.
//  Copyright © 2016年 YF. All rights reserved.
//

import Foundation

extension NSDate {
    class func createDateString(createAtStr : String) -> String {
        ///创建时间格式化对象
        let format = NSDateFormatter()
        ///设置格式化类型
        format.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        format.locale = NSLocale(localeIdentifier: "en")
        ///将字符串时间转成NSDate类型
        guard let createDate = format.dateFromString(createAtStr) else {
            return ""
        }
        ///获取当前时间
        let nowDate = NSDate()
        ///获取两个时间的时间差
        let interval = Int(nowDate.timeIntervalSinceDate(createDate))
        ///将当前时间与创建时间进行比较,确定createAtText属性的内容
        // 5.对时间间隔处理
        // 5.1.显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        // 5.2.59分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        // 5.3.11小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 5.4.创建日历对象
        let calendar = NSCalendar.currentCalendar()
        
        // 5.5.处理昨天数据: 昨天 12:23
        if calendar.isDateInYesterday(createDate) {
            format.dateFormat = "昨天 HH:mm"
            let timeStr = format.stringFromDate(createDate)
            return timeStr
        }
        
        // 5.6.处理一年之内: 02-22 12:22
        let cmps = calendar.components(.Year, fromDate: createDate, toDate: nowDate, options: [])
        if cmps.year < 1 {
            format.dateFormat = "MM-dd HH:mm"
            let timeStr = format.stringFromDate(createDate)
            return timeStr
        }
        
        // 5.7.超过一年: 2014-02-12 13:22
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = format.stringFromDate(createDate)
        return timeStr
    }
}
