## CYAlertController
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
本项目中使用 [Masonry](https://github.com/SnapKit/Masonry) 自动布局，所以需要 Masonry 的支持，你可以从我的仓库中直接把 `CYAlertController` 和 `Masonry` 文件夹拖入你的项目，也可以通过 cocoapods 导入 Masonry（CYAlertController 目前还不支持 cocoapods😅）。然后在需要使用的地方导入头文件

```objc
#import "CYAlertController.h"
```

#### 调用

CYAlertController 提供了几乎与官方一样的API：

```objc
CYAlertController *alert = [CYAlertController alertWithTitle:@"警告！警告！💥"
                                                     message:@"逗你玩儿呢 ~ 😜"];
alert.presentStyle = CYAlertPresentStyleSystem;
alert.dismissStyle = CYAlertDismissStyleFadeOut;

// 或者直接一口气初始化

CYAlertController *alert2 = [CYAlertController alertWithTitle:@"警告！警告！💥"
                                                      message:@"逗你玩儿呢 ~ 😜"
                                                 presentStyle:CYAlertPresentStyleSystem
                                                 dismissStyle:CYAlertDismissStyleFadeOut];
```
创建 action(提供了3中与官方一样的style)，给 alert 添加 action ：

```objc
CYAlertAction *defaultAction = [CYAlertAction actionWithTitle:@"确定" style:CYAlertActionStyleDefault handler:^{ NSLog(@"Default"); }];
CYAlertAction *destructiveAction = [CYAlertAction actionWithTitle:@"危险" style:CYAlertActionStyleDestructive handler:^{ NSLog(@"Destructive"); }];
CYAlertAction *cancelAction = [CYAlertAction actionWithTitle:@"取消" style:CYAlertActionStyleCancel handler:^{ NSLog(@"Cancel"); }];

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
typedef NS_ENUM(NSInteger, CYAlertPresentStyle) {
    CYAlertPresentStyleSystem,          // 系统样式
    CYAlertPresentStyleFadeIn,          // 渐入
    CYAlertPresentStyleBounce,          // 弹出
    CYAlertPresentStyleExpandHorizontal,// 水平展开
    CYAlertPresentStyleExpandVertical,  // 垂直展开
    CYAlertPresentStyleSlideDown,       // 从上往下划入
    CYAlertPresentStyleSlideUp,         // 从下往上划入
    CYAlertPresentStyleSlideLeft,       // 从右往左划入
    CYAlertPresentStyleSlideRight,      // 从左往右划入
};

// dismiss style
typedef NS_ENUM(NSInteger, CYAlertDismissStyle) {
    CYAlertDismissStyleFadeOut,             // 渐出
    CYAlertDismissStyleContractHorizontal,  // 水平收起
    CYAlertDismissStyleContractVertical,    // 垂直收起
    CYAlertDismissStyleSlideDown,           // 向下划出
    CYAlertDismissStyleSlideUp,             // 向上划出
    CYAlertDismissStyleSlideLeft,           // 向左划出
    CYAlertDismissStyleSlideRight,          // 向右划出
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