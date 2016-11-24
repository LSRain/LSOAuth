//
//  LSNetworkTools.swift
//  LSOAuth
//
//  Created by WangBiao on 2016/10/29.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit

import AFNetworking

// get post 请求方式枚举(Swift 枚举写法)
enum LSNetworkToolsMethod: String {
    case get = "get"
    case post = "post"
}

class LSNetworkTools: AFHTTPSessionManager {
    static let sharedTools: LSNetworkTools = {
        let tools = LSNetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
    
    /// 网络请求公共方法
    ///
    /// - parameter method:     请求方式
    /// - parameter urlString:   url 地址
    /// - parameter parameters: 请求参数
    /// - parameter success:    成功
    /// - parameter failure:    失败
    func requet(method: LSNetworkToolsMethod, urlString: String, parameters: Any?, success:@escaping (Any?)->(), failure:@escaping (Error)->()){
        // 如果是 get 请求
        if method == .get {
            get(urlString, parameters: parameters, progress: nil, success: { (_, responseObject) in
                success(responseObject)
                }, failure: { (_, error) in
                    failure(error)
            })
        }else {
            post(urlString, parameters: parameters, progress: nil, success: { (_, responseObject) in
                success(responseObject)
                }, failure: { (_, error) in
                    failure(error)
            })
        }
    }
}

// MARK: - OAuth 授权相关接口
extension LSNetworkTools {
    
    /// 获取 userAccount
    func oauthLoadUserAccount(code: String, success:@escaping (Any?)->(), failure:@escaping (Error)->()){
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = [
            "client_id": LSAPPKEY,
            "client_secret": LSAPPSECRET,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": LSREDIRECTURI
        ]

        requet(method: LSNetworkToolsMethod.post, urlString: urlString, parameters: params, success: success, failure: failure)
    }
    
    /// 请求用户信息
    func oauthLoadUserInfo(model: LSUserAccountModel, success:@escaping (Any?)->(), failure:@escaping (Error)->()){
        let urlString = "https://api.weibo.com/2/users/show.json"
        let params = [
            "access_token":model.access_token!,
            "uid":model.uid!
        ]

        requet(method: LSNetworkToolsMethod.get, urlString: urlString, parameters: params, success: success, failure: failure)
    }
}
