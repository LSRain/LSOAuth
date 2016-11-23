//
//  ViewController.swift
//  LSOAuth
//
//  Created by WangBiao on 2016/11/24.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        oAuthTest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /* JK_OAuth测试 */
    /*--------------------开始-----------------*/
    func oAuthTest() -> Void {
        
        func setNav() -> Void {
            navigationItem.leftBarButtonItem = UIBarButtonItem(setHighlightedImgName: nil, title: "注册", target: self, action: #selector(loginClick))
            navigationItem.rightBarButtonItem = UIBarButtonItem(setHighlightedImgName: nil, title: "登录", target: self, action: #selector(loginClick))
        }
        setNav()
    }
    
    func loginClick(){
        
        let oauthVc = LSOAuthViewController()
        let oauthNavC = UINavigationController(rootViewController: oauthVc)
        present(oauthNavC, animated: true, completion: nil)
    }
    /*--------------------结束-----------------*/


}

