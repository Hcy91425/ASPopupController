#### 2016.11.02 更新
更换了所有类名前缀为 AS， 修改了项目名称为 ASPopupController。
理由：CY 长的不好看，逼格不高😬
#### 2016.10.30 更新
1. 修复了在屏幕旋转时灰色半透明背景没有约束的bug。
2. 最近工作比较忙，自己也升入大四了，还要准备毕设和毕业的事情，太久没有更新自己的Github了。目前只能简单的修复一下小bug，有空的时候准备一波大更新，敬请期待🤔

## ASPopupController
***
一个初学者的第一次尝试。喜欢的，支持的，欢迎 star⭐️，fork。没有很多经验，很多东西都是自己的思路，如果有不对的地方希望大家能够指出。

高仿官方 Alert 外观，提供多种自定义的转场动画，以及相似的 API。

### 外观&动画
***

#### 支持多个button，自适应高度

<div align="center"><img src="http://7xrpns.com1.z0.glb.clouddn.com/AlertView_Preview.png"></div>

#### 部分动画

<img src="http://7xrpns.com1.z0.glb.clouddn.com/alert4.gif" width = 375>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alert5.gif" width = 375>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alert6.gif" width = 375>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alert7.gif" width = 375>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alert8.gif" width = 375>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alert9.gif" width = 375>

### 使用
***

#### 导入

```
pod 'ASPopupController'
```

也可以直接往项目中拖入 `ASPopupController` 文件夹到你的项目中

然后在需要使用的地方导入头文件

```objc
#import "ASPopupController.h"
```

#### 调用

ASPopupController 提供了几乎与官方一样的API：

```objc
ASPopupController *alert = [ASPopupController alertWithTitle:@"警告！警告！💥"
                                                     message:@"逗你玩儿呢 ~ 😜"];
alert.presentStyle = ASPopupPresentStyleSystem;
alert.dismissStyle = ASPopupDismissStyleFadeOut;

// 或者直接一口气初始化
ASPopupController *alert2 = [ASPopupController alertWithTitle:@"警告！警告！💥"
                                                      message:@"逗你玩儿呢 ~ 😜"
                                                 presentStyle:ASPopupPresentStyleSystem
                                                 dismissStyle:ASPopupDismissStyleFadeOut];
                                                 
// 还可以设置 alertView 的圆角半径，默认为6
alert.alertViewCornerRadius = 10;

```
创建 action(提供了3中与官方一样的style)，给 alert 添加 action ：

```objc
ASPopupAction *defaultAction = [ASPopupAction actionWithTitle:@"确定" style:ASPopupActionStyleDefault handler:^{ NSLog(@"Default"); }];
ASPopupAction *destructiveAction = [ASPopupAction actionWithTitle:@"危险" style:ASPopupActionStyleDestructive handler:^{ NSLog(@"Destructive"); }];
ASPopupAction *cancelAction = [ASPopupAction actionWithTitle:@"取消" style:ASPopupActionStyleCancel handler:^{ NSLog(@"Cancel"); }];

// 一次性添加
[alert addActions:@[defaultAction, destructiveAction, cancelAction]];
    
// 也可以一个个添加
[alert addAction:defaultAction];
[alert addAction:destructiveAction];
[alert addAction:cancelAction];

```

最后就直接 present：

```objc
[self presentViewController:alert animated:YES completion:nil];
```



#### 转场的动画  
目前提供了9种present动画，7种dismiss动画

```objc
// present style
typedef NS_ENUM(NSInteger, ASPopupPresentStyle) {
    ASPopupPresentStyleSystem,          // 系统样式
    ASPopupPresentStyleFadeIn,          // 渐入
    ASPopupPresentStyleBounce,          // 弹出
    ASPopupPresentStyleExpandHorizontal,// 水平展开
    ASPopupPresentStyleExpandVertical,  // 垂直展开
    ASPopupPresentStyleSlideDown,       // 从上往下划入
    ASPopupPresentStyleSlideUp,         // 从下往上划入
    ASPopupPresentStyleSlideLeft,       // 从右往左划入
    ASPopupPresentStyleSlideRight,      // 从左往右划入
};

// dismiss style
typedef NS_ENUM(NSInteger, ASPopupDismissStyle) {
    ASPopupDismissStyleFadeOut,             // 渐出
    ASPopupDismissStyleContractHorizontal,  // 水平收起
    ASPopupDismissStyleContractVertical,    // 垂直收起
    ASPopupDismissStyleSlideDown,           // 向下划出
    ASPopupDismissStyleSlideUp,             // 向上划出
    ASPopupDismissStyleSlideLeft,           // 向左划出
    ASPopupDismissStyleSlideRight,          // 向右划出
};
```

更多细节可以直接看demo~

### 计划
***
 - 加入更多的转场动画
 - 支持自定义动画
 - 提供更多种类的alert，如 ActionSheet

### 联系我
***

微博 [@Cyrus_dev](http://weibo.com/u/5822241060)

