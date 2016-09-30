//
//  BaseViewController.swift
//  Weibo
//
//  Created by YF on 16/9/30.
//  Copyright © 2016年 YF. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    //MARK - 懒加载属性
    private lazy var vistorView : VistorView = VistorView.vistorView()
    //MARK: - 定义变量
    var isLogin : Bool = false
    //MARK: - 重写loadView方法
    override func loadView() {
        isLogin ? super.loadView() : setupVistorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//MARK: - 加载vistorView
extension BaseViewController {
    private func setupVistorView () {
        view = vistorView
    }
}
