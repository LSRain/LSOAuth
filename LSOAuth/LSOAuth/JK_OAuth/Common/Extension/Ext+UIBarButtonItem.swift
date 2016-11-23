//
//  Ext+UIBarButtonItem.swift
//  LSOAuth
//
//  Created by WangBiao on 2016/10/29.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /// UIBarButtonItem
    ///
    /// - parameter setHighlightedImgName: 图片名字
    /// - parameter target:                target
    /// - parameter action:                action
    ///
    /// - returns:
    convenience init(setHighlightedImgName: String? = nil, title: String? = nil, target: Any?, action: Selector) {
        self.init()
        let button = UIButton(setHighlightedImgName: setHighlightedImgName, title: title, target: target, action: action)
        self.customView = button
        
    }
}
