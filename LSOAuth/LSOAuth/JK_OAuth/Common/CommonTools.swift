//
//  CommonTools.swift
//  LSOAuth
//
//  Created by WangBiao on 2016/10/29.
//  Copyright © 2016年 lsrain. All rights reserved.
//

/*
    - 等同于 OC中的 pch 文件   全局共享
 */
import UIKit

/*************************************************************************
 *
 *	手动配置信息
 *
 *************************************************************************/

/* 微博API相关信息 */
/// 配置信息不应该包含有空格
let LSAPPKEY = " "
let LSAPPSECRET = " "
let LSREDIRECTURI = " " //回调页: 如`http://www.baidu.com`

/* 微博账号和密码 */
let LSWBNAME = " "
let LSWBPASSWD = " "

/*************************************************************************
 *
 *	全局宏
 *
 *************************************************************************/
/* 通知 */
let LSSWITCHROOTVCNOTI = "LSSWITCHROOTVCNOTI"

/* 屏幕的宽度和高度 */
let LSSCREENW = UIScreen.main.bounds.width
let LSSCREENH = UIScreen.main.bounds.height

/* 微博的主题颜色 */
let LSTHEMECOLOR = UIColor.orange

/* 随机颜色 */
func LSRandomColor() -> UIColor{
    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
}

/* 常用字体大小 */
let LSBigFontSize: CGFloat = 18
let LSNormalFontSize: CGFloat = 14
let LSSmallFontSize: CGFloat = 10

