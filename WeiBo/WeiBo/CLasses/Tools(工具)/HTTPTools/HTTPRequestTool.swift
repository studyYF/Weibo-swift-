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
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
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


//MARK: - 请求accessToken
extension HTTPRequestTool {
    func loadAccessToken(code : String, finished : (result : [String : AnyObject]?, error : NSError?) -> ()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let param = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_url, "code" : code]
        request(.POST, urlString: urlString, parameters: param) { (result, error) -> () in
            finished(result: result as? [String : AnyObject], error: error)
        }
    }
}

//MARK: - 请求用户信息
extension HTTPRequestTool {
    func requestUserInfo(access_token : String, uid : String , finished : (result : [String : AnyObject]?, error : NSError?) -> ()) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        // 2.获取请求的参数
        let parameters = ["access_token" : access_token, "uid" : uid]
        
        // 3.发送网络请求
        request(.GET, urlString: urlString, parameters: parameters) { (result, error) -> () in
            finished(result: result as? [String : AnyObject] , error: error)
        }
    }
}

//MARK: - 请求首页数据
extension HTTPRequestTool {
    func loadStatuses(finished : (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let param = ["access_token" : (UserAccountTool.shareInstances.account?.access_token)!]
        request(.GET, urlString: urlString, parameters: param) { (result, error) -> () in
            //根据返回的数据,将得到的数据转成字典
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            //将字典中statuses字段对应的数组提取出来,用于回调
            finished(result: resultDict["statuses"] as? [[String : AnyObject]], error: error)
        }
    }
}
