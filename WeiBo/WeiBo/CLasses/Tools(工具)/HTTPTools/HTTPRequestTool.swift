//
//  HTTPRequestTool.swift
//  Weibo
//
//  Created by YF on 16/10/3.
//  Copyright © 2016年 YF. All rights reserved.
//

import AFNetworking

//MARK: - 定义请求类型的枚举
enum RequestType {
    case GET
    case POST
}

class HTTPRequestTool: AFHTTPSessionManager {
    ///创建单例,
    static let shareInstance : HTTPRequestTool  = {
        let tool = HTTPRequestTool()
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tool
    }()
}

//MARK: - 网络请求
extension HTTPRequestTool {
    func request(type : RequestType , urlString : String, parameters : [String : AnyObject],finished : (result : AnyObject?, error : NSError?) -> ()) {
        //定义请求成功的闭包
        let successCallback = { (task : NSURLSessionDataTask , result : AnyObject?) -> Void in
            finished(result : result ,error : nil)
        }
        //定义请求失败的闭包
        let failureCallback = { (task : NSURLSessionDataTask? , error : NSError) -> Void in
            finished(result: nil, error: error)
        }
        //GET请求
        if type == .GET {
            GET(urlString, parameters: parameters, progress: nil, success: successCallback, failure: failureCallback)
        }
        //POST请求
        else {
            POST(urlString, parameters: parameters, progress: nil, success: successCallback, failure: failureCallback)
        }
    }
}