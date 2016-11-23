//
//  LSOAuthViewController.swift
//  LSOAuth
//
//  Created by WangBiao on 2016/10/29.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit

import YYModel
import SVProgressHUD

// MARK: - UIWebViewDelegate
extension LSOAuthViewController: UIWebViewDelegate{
    /*
     - 监听webView 将要加载的request 默认不实现 返回的是 true
     */
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // urlString
        let urlString = request.url?.absoluteString
        // 判断urlString 不为 nil 而且前缀包含我们的回调页
        if let u = urlString, u.hasPrefix(LSREDIRECTURI) {
            // 请求参数
            let query = request.url?.query
            // 判断请求参数是否为 nil
            if let q = query {
                // 截取得到 code // code=d058a3b46e390e3600df792d032cf10d
                let code = q.substring(from: "code=".endIndex)
                print("终于等到你",code)
                LSUserAccountViewModel.sharedTools.getUserAccount(code: code, finish: { (isSuccess) in
                    if !isSuccess {
                        print("请求失败")
                        SVProgressHUD.showError(withStatus: "请求失败")
                        return
                    }
                    print("请求成功")
                    SVProgressHUD.dismiss()
                    
                })
                // 是否加载回调界面
                return true
            }
        }
        return true
    }
    
    // 将要加载 webview
    func webViewDidStartLoad(_ webView: UIWebView) {
        // 开始动画
        SVProgressHUD.show()
    }
    
    // 加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // 结束动画
        SVProgressHUD.dismiss()
    }
    
    // 加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
}

class LSOAuthViewController: UIViewController {
    
    // 自动填充
    @objc private func autoFillClick(){
        print("自动填充按钮点击")
        // jsString
        let jsString = "document.getElementById('userId').value='\(LSWBNAME)',document.getElementById('passwd').value='\(LSWBPASSWD)'"
        // js注入
        webView.stringByEvaluatingJavaScript(from: jsString)
    }
    
    // MARK: - 懒加载控件
    private lazy var webView: UIWebView = {
        
        // url
        let url = URL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(LSAPPKEY)&redirect_uri=\(LSREDIRECTURI)")!
        // request
        let request = URLRequest(url: url)
        let view = UIWebView()
        view.delegate = self
        view.loadRequest(request)
        return view

    }()
    
    // MARK: - 设置导航
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(setHighlightedImgName: nil, title: "取消", target: self, action: #selector(cancelClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(setHighlightedImgName: nil, title: "自动填充", target: self, action: #selector(autoFillClick))
        navigationItem.title = "微博登录"
    }
    
    // MARK: - 监听事件
    // 取消
    @objc private func cancelClick(){
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }

    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = UIColor.white
        setupNav()
    }
}
