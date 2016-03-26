## CYAlertController
***
我的第一个轮子，自定义 AlertController，提供多种转场动画。先看Demo：

<img src="http://7xrpns.com1.z0.glb.clouddn.com/alertdemo1.gif" width = 250>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alertdemo2.gif" width = 250>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alertdemo3.gif" width = 250>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alertdemo4.gif" width = 250>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alertdemo5.gif" width = 250>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alertdemo6.gif" width = 250>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alertdemo7.gif" width = 250>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alertdemo8.gif" width = 250>
<img src="http://7xrpns.com1.z0.glb.clouddn.com/alertdemo9.gif" width = 250>


***
### 使用
在项目中拖入 CYAlertController 文件夹，然后

```objc
#import "CYAlertController.h"
```

#### 目前提供了5个初始化方法，全部声明在 `CYAlertController.h` 文件中

 - 最简洁的方法

 ```objc
 CYAlertController *alert = [CYAlertController alertWithTitle:@"AlertDemo"// 标题
                                                         message:@"Hello CYAlertController 😜"// 信息
                                                     buttonTitle:@"Done"// 按钮标题
                                                    buttonAction:^{// 按钮事件
                                                        NSLog(@"done button clicked");
                                                    }];
[self presentViewController:alert animated:YES completion:nil];

 ```
 这种方式使用默认的转场方式，也可以选择其他的转场，通过设置 `presentStyle` 和 `dismissStyle`
 
 ```objc
alert.presentStyle = CYAlertPresentStyleSlideDown;
alert.dismissStyle = CYAlertDismissStyleSlideDown;
 ```
 
 - 自定义程度最高的方法

 ```objc
 CYAlertController *alert = [CYAlertController alertWithTitle:@"Alert"
                                                          message:@"Hello CYAlertController 😜"
                                                  leftButtonTitle:@"Cancel"
                                                 leftButtonAction:nil
                                                 rightButtonTitle:@"Done"
                                                rightButtonAction:nil
                                                     presentStyle:CYAlertPresentStyleBounce
                                                     dismissStyle:CYAlertDismissStyleSlideUp];
[self presentViewController:alert animated:YES completion:nil];
 ```
 
 这里最多可以设置两个 button，如果有一个button的按钮设置为 nil 那么只会显示一个button，如果两个都为nil则显示默认的 “Done” 。button的action在最后会自动执行 dismiss ，所以如果在action处也填了 nil，那么点击button就只会有消失alert的动作。
 
- 自定义 alertView 的方法 如果你不喜欢我的alertView，你可以传入一个自己的view

 ```objc
UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 400)];
customView.backgroundColor = [UIColor brownColor];    
alert = [CYAlertController alertWithCustomView:customView 
								  presentStyle:CYAlertPresentStyleBounce 
								  dismissStyle:CYAlertDismissStyleFadeOut];
[self presentViewController:alert animated:YES completion:nil];

 ```

#### 转场的动画  目前提供了9中present动画，7中dismiss动画

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

项目中有 Demo 如果看不懂文字说明可以看 Demo