//
//  Ext+UIButton.swift
//  LSOAuth
//
//  Created by WangBiao on 2016/10/29.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import  UIKit

extension UIButton {

    /// 创建 button 快捷方式
    ///
    /// - parameter setImgName:        图片名字
    /// - parameter backgroundImgName: 背景图片名字
    /// - parameter target:             target
    /// - parameter action:            action
    ///
    /// - returns: nil
    convenience init(setImgName: String, backgroundImgName: String, target: Any?, action: Selector) {
        self.init()
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        self.setImage(UIImage(named: setImgName), for: UIControlState.normal)
        self.setImage(UIImage(named: "\(setImgName)_highlighted"), for: UIControlState.highlighted)
        self.setBackgroundImage(UIImage(named: backgroundImgName), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named: "\(backgroundImgName)_highlighted"), for: UIControlState.highlighted)
        self.sizeToFit()
    }

    /// 设置 button
    ///
    /// - parameter setHighlightedImgName:  图片
    /// - parameter target:                target
    /// - parameter action:                action
    ///
    /// - returns: nil
    convenience init(setHighlightedImgName: String? = nil, title:  String? = nil, target: Any?, action: Selector) {
        self.init()
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        if let img = setHighlightedImgName {
            self.setImage(UIImage(named: img), for: UIControlState.normal)
            self.setImage(UIImage(named: "\(img)_highlighted"), for: UIControlState.highlighted)
        }
        
        if let tit = title {
            self.setTitle(tit, for: UIControlState.normal)
            self.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            self.setTitleColor(LSTHEMECOLOR, for: UIControlState.highlighted)
            titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        
        self.sizeToFit()
    }
    
    /// 实例化一个有背景图片和文字的 button
    ///
    /// - parameter setBackgroundImgName:
    /// - parameter title:                文字
    /// - parameter fontSize:             文字大小
    /// - parameter titleColor:           文字颜色
    /// - parameter target:
    /// - parameter action:
    ///
    /// - returns: nil
    convenience init(setBackgroundImgName: String, title:  String, fontSize: CGFloat, titleColor: UIColor,  target: Any?, action: Selector) {
        self.init()
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        self.setBackgroundImage(UIImage(named: setBackgroundImgName), for: UIControlState.normal)
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(titleColor, for: UIControlState.normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.sizeToFit()
    }
    
    
}
