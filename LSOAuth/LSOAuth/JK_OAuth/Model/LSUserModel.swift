//
//  LSUserModel.swift
//  LSOAuth
//
//  Created by WangBiao on 2016/10/29.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit

/**
    用户信息模型
     示例
     Optional({
     "allow_all_act_msg" = 0;
     "allow_all_comment" = 1;
     "avatar_hd" = "http://tva1.sinaimg.cn/crop.0.0.750.750.1024/006xL13rjw8f6j93zgrgjj30ku0kugmb.jpg";
     "avatar_large" = "http://tva1.sinaimg.cn/crop.0.0.750.750.180/006xL13rjw8f6j93zgrgjj30ku0kugmb.jpg";
     "bi_followers_count" = 0;
     "block_app" = 0;
     "block_word" = 0;
     city = 1;
     class = 1;
     "created_at" = "Thu Aug 04 04:05:48 +0800 2016";
     "credit_score" = 80;
     description = "";
     domain = "";
     "favourites_count" = 0;
     "follow_me" = 0;
     "followers_count" = 16;
     ...
     })
 */
class LSUserModel: NSObject {
    /// 用户UID
    var id: Int = 0
    /// 友好显示名称
    var name: String?
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    /// 认证类型 -1：没有认证，1，认证用户，2,3,5: 企业认证，220: 达人
    var verified: Int = -1
    /// 会员等级 1-6
    var mbrank: Int = 0
}
