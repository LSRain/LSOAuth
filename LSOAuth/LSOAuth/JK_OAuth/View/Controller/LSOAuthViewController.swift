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
        let urlString = request.url?.absoluteString
        if let u = urlString, u.hasPrefix(LSREDIRECTURI) {
            let query = request.url?.query
            if let q = query {
                /// 截取得到 code // code=d058a3b46e390e3600df792d032cf10d
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

                return true
            }
        }
        return true
    }
    
    /// 开始动画
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    /// 加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    /// 加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    }
}

class LSOAuthViewController: UIViewController {
    
    /// 自动填充
    @objc private func autoFillClick(){
        
        print("自动填充按钮点击")
        let jsString = "document.getElementById('userId').value='\(LSWBNAME)',document.getElementById('passwd').value='\(LSWBPASSWD)'"
        
        // js注入
        webView.stringByEvaluatingJavaScript(from: jsString)
    }
    
    private lazy var webView: UIWebView = {
        let url = URL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(LSAPPKEY)&redirect_uri=\(LSREDIRECTURI)")!
        let request = URLRequest(url: url)
        let view = UIWebView()
        view.delegate = self
        view.loadRequest(request)
        return view

    }()
    
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(setHighlightedImgName: nil, title: "取消", target: self, action: #selector(cancelClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(setHighlightedImgName: nil, title: "自动填充", target: self, action: #selector(autoFillClick))
        navigationItem.title = "微博登录"
    }
    
    // MARK: - 监听事件
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
