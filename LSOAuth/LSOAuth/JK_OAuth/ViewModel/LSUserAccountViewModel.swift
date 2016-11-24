//
//  LSUserAccountViewModel.swift
//  LSOAuth
//
//  Created by WangBiao on 2016/10/29.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit

/*
 accessToken 后期我们会频繁使用它 但是他是有过期的时间(开发者用户 过期时间5年 普通用户是三天)
 - 01 如果用户第一次登陆 -> 没有保存过个人信息数据 accessToken == nil
 - 02 如果用户登陆过 但是 例如他是普通用户 20170101 -> 20170104 -> 如果你在20170105 代表他已经过期了 -> 他还会使用accessToken -> 程序员accessToken == nil   -> 告知用户重新登陆
 - 03 accessToken==nil 要不没有登录 要不就是过期了\
 
 - 分析他accessToken 是存储型属性 还是计算型属性
 - 每次使用之前 都需要判断 实时判断 才能真正的保证他是否过期
 */

/// 判断用户是否登录
/*
 - 如果用户登录 (用户登录了 而且没有过期)
 - 如果用户没有登录(真的没有登录过 , 用户登录过 但是过期了)
 - 需要每次使用均需要判断下 所以使用计算型属性
 */

// MARK: - ViewModel帮助控制器请求token&用户信息
extension LSUserAccountViewModel {
    
    // 请求 token
    func getUserAccount(code: String, finish:@escaping (Bool)->()){

        LSNetworkTools.sharedTools.oauthLoadUserAccount(code: code, success: { (response) in
            
            guard let res = response as?[String: Any] else{
                finish(false)
                return
            }
            
            let userAccountModel = LSUserAccountModel.yy_model(withJSON: res)
            guard let model = userAccountModel else {
                finish(false)
                return
            }
            self.getUserInfo(model: model, finish: finish)
            }) { (error) in
                finish(false)
                print("请求失败",error)
        }
    }
    
    // 请求用户信息
    func getUserInfo(model: LSUserAccountModel, finish:@escaping (Bool)->()){
        LSNetworkTools.sharedTools.oauthLoadUserInfo(model: model, success: { (response) in
            guard let res = response as?[String: Any] else{
                finish(false)
                return
            }
            
            model.screen_name = res["screen_name"] as? String
            model.avatar_large = res["avatar_large"] as? String
            self.saveUserAccountModel(model: model)

            finish(true)
            }) { (error) in
                finish(false)
                print("请求失败",error)
        }
    }
}

// MARK: - 归档解档
extension LSUserAccountViewModel {
    
    // 保存用户信息对象
    func saveUserAccountModel(model: LSUserAccountModel){
        userAccountModel = model
        NSKeyedArchiver.archiveRootObject(model, toFile: file)
    }

    fileprivate func getUserAccountModel() ->LSUserAccountModel?{
        let result = NSKeyedUnarchiver.unarchiveObject(withFile: file) as? LSUserAccountModel
        return result
    }
}

// 自定义类 没有继承
class LSUserAccountViewModel {
    
    var accessToken:String?{
        if userAccountModel?.expires_Date?.compare(Date()) == ComparisonResult.orderedDescending {
            return userAccountModel?.access_token
        }else {
            return nil
        }
    }
    
    static let sharedTools: LSUserAccountViewModel = LSUserAccountViewModel()
    var userAccountModel: LSUserAccountModel?
    let file = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent("userAccount.archiver")
    
    var isLogin:Bool{
        return accessToken != nil
    }
    
    init() {
        userAccountModel = getUserAccountModel()
    }
    
}
