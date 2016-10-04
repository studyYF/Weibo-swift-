//
//  OAuthViewController.swift
//  Weibo
//
//  Created by YF on 16/10/3.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {

    //MARK: - 控件属性
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        loadWebView()
    }
}

//MARK: - 设置UI相关
extension OAuthViewController {
    private func setupNavigation() {
        //1.设置导航栏左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "cancelButtonClick")
        //2.设置标题
        title = "登录页面"
        //3.设置导航栏右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .Plain, target: self, action: "fillButtonClick")
    }
    
    private func loadWebView() {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_url)"
        guard let url = NSURL(string: urlString) else {
            return
        }
        webView.loadRequest(NSURLRequest(URL: url))
    }
}
//MARK: - 事件的监听
extension OAuthViewController {
    @objc private func cancelButtonClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    //填充账号和密码,需要js代码
    @objc private func fillButtonClick() {
        let jsString = "document.getElementById('userId').value='1606020376@qq.com';document.getElementById('passwd').value='haomage';"
        webView.stringByEvaluatingJavaScriptFromString(jsString)
    }
}
//MARK: - WebViewDelegate
extension OAuthViewController : UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
         SVProgressHUD.dismiss()
    }
    //当准备加载某个页面的时候会执行这个方法
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.URL else {
            return true
        }
        let urlString = url.absoluteString
        
        guard urlString.containsString("code=") else {
            return true
        }
        let code = urlString.componentsSeparatedByString("code=").last!
        loadAccessToken(code)
        
        return false
    }
}
//MARK: - 请求accessToken和用户信息
extension OAuthViewController {
    private func loadAccessToken(code : String) {
        HTTPRequestTool.shareInstance.loadAccessToken(code) { (result, error) -> () in
            if error != nil {
                print(error)
                return
            }
            else {
                guard let accountDict = result else {
                    return
                }
                let account = UserAccount(dict: accountDict)
                //MARK: - 在闭包中调用方法,必须使用self
                self.requestUserInfo(account)
            }
        }
    }
    ///请求用户信息方法
    private func requestUserInfo(account : UserAccount) {
        guard let accessToken = account.access_token else {
            return
        }
        guard let uid = account.uid else {
            return
        }
        HTTPRequestTool.shareInstance.requestUserInfo(accessToken, uid: uid) { (result, error) -> () in
            if error != nil {
                print(error) 
                return
            }
            else {
                guard let userInfoDict = result else {
                    return
                }
                account.screen_name = userInfoDict["screen_name"] as? String
                account.avatar_large = userInfoDict["avatar_large"] as? String
                //归档
//                var accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
//                accountPath = (accountPath as NSString).stringByAppendingPathComponent("account.plist")
                NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountTool.shareInstances.accountPath)
                UserAccountTool.shareInstances.account = account
                
                ///退出当前控制器,弹出欢迎页面
                self.dismissViewControllerAnimated(false, completion: { () -> Void in
                     UIApplication.sharedApplication().keyWindow?.rootViewController = WelcomeViewController()
                })
                
            }
        }
    }
}





