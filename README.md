# LSOAuth
## LSOAuth
### 说明
**github**根据项目中文件`数目`最多的文件类型,识别`整个项目类型`，`LSOAuth`使用的是`swift3.0`，但是项目中桥接了其他多数的OC文件，以致整个项目识别为OC项目，因此使用`LSOAuth`时，请使用`swift`语法。

## 使用前配置
1> 使用前，请确保控制器拥有一个导航控制器

2> 出于账号安全，在此没有给出测试账号。请您在使用LSOAuth前先拥有一个微博开发者账号，并在通用工具类`CommonTools`中设置好APPKEY、回调页、微博账号密码等信息。

3> 手动配置信息：
在CommonTools中手动配置相关信息

1> 微博API请求相关信息

```
* let LSAPPKEY = " "
* let LSAPPSECRET = " "
* let LSREDIRECTURI = " "
```

2> 微博账号和密码

```
* let LSWBNAME = " "
* let LSWBPASSWD = " "
```

###第三方框架依赖

```
use_frameworks!
# 网络框架
pod 'AFNetworking'
# 加载指示器
pod 'SVProgressHUD'
# 网络图片加载
pod 'SDWebImage'
# YYModel
pod 'YYModel'
```

## 架构
### 结构
使用MVVM的设计逻辑viewModel主要请求网络数据

1. webView作为主控制器的根式图
2. 发送request请求
3. 通过webView的代理方法监听webView将要加载的request
    - 得到code
4. 发送含有code等参数的请求获取token
    - 得到token等信息
    - 转为模型
5. 发送含有token&uid参数的请求获取公共微博接口数据
    - 转换成模型
    - NSKeyedArchiver归档入沙盒缓存模型
    
### 逻辑
跳转到主控制即可完成OAuth授权

主控制器：LSOAuthViewController

1. 使用Modal或者push跳转到主控制器
2. 使用ib或者代码的方式加上导航控制器，可以使用下面的方法

```
将控制器作为导航控制器的根控制器
let oauthVc = LSOAuthViewController()
let oauthNavC = UINavigationController(rootViewController: oauthVc)

func setNav() -> Void {
        navigationItem.leftBarButtonItem = UIBarButtonItem(setHighlightedImgName: nil, title: "注册", target: self, action: #selector(loginClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(setHighlightedImgName: nil, title: "登录", target: self, action: #selector(loginClick))
    }
```

### 其他
OAuth授权登录

- 没有token 就没办法访问微博的公共接口
- 使用微博登录  微博用户名 和 密码
- 登录 -> 授权
- 会给我们 app 一个 用户对应的 code(授权码)
- 新浪微博 特殊提供一个接口 只要你传入`code` 我就会给你对应这个人的 token
- 通过新浪微博给你的token 拼接对应微博请求个人信息的数据接口就可以拿到用户对应的用户信息(name img age sex...)

## 效果
![LSOAuth.gif](http://upload-images.jianshu.io/upload_images/2329629-00a3099048c22291.gif?imageMogr2/auto-orient/strip)