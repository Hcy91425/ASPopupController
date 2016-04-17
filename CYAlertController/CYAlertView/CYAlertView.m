//
//  CYAlertView.m
//  CYAlertView
//
//  Created by Cyrus on 16/4/13.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "CYAlertView.h"
#import "CYAlertAction.h"
#import "NSString+Size.h"
#import "Masonry.h"

/** 间隙 */
const static CGFloat padding = 15.0;

/** 弹窗总宽度 */
const static CGFloat alertWidth = 270;

/** 内容宽度 */
const static CGFloat containerWidth = alertWidth - 2*padding;

/** 按钮高度 */
const static CGFloat buttonHeight = 40.0;

@interface CYAlertView ()

/** 保存事件的数组 */
@property (nonatomic, strong)NSMutableArray<CYAlertAction *> *actions;

/** 保存按钮的数组 */
@property (nonatomic, strong)NSMutableArray<UIButton *> *buttons;

/** scrollView 外层容器视图 */
@property (nonatomic, strong)UIView *containerView;

/** 滚动视图 */
@property (nonatomic, strong)UIScrollView *scrollView;

/** 标题 */
@property (nonatomic, strong)UILabel *titleLabel;

/** 消息 */
@property (nonatomic, strong)UILabel *messageLabel;

/** 保存alert底部的约束，添加button要改变这个约束 */
@property (nonatomic, strong)MASConstraint *bottomConstraint;

/** 按钮白色背景 */
@property (nonatomic, strong)UIImage *whiteImage;

/** 按钮灰色背景 */
@property (nonatomic, strong)UIImage *grayImage;

@end

@implementation CYAlertView

/** 懒加载 */
- (NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray<CYAlertAction *> *)actions {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (UIImage *)whiteImage {
    if (!_whiteImage) {
        // 取出button的背景图
        NSBundle *cyBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"CYAlertViewController" ofType:@"bundle"]];
        NSString *whiteImagePath = [cyBundle pathForResource:@"cy_white" ofType:@"png"];
        _whiteImage = [UIImage imageWithContentsOfFile:whiteImagePath];
    }
    return _whiteImage;
}

- (UIImage *)grayImage {
    if (!_grayImage) {
        // 取出button的背景图
        NSBundle *cyBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"CYAlertViewController" ofType:@"bundle"]];
        NSString *grayImagePath = [cyBundle pathForResource:@"cy_gray" ofType:@"png"];
        _grayImage = [UIImage imageWithContentsOfFile:grayImagePath];
    }
    return _grayImage;
}

/** 初始化方法 */
- (_Nonnull instancetype)initWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message {
    self = [super init];
    if (!self) { return nil; };
    
    self.layer.cornerRadius = 6;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    // 初始化
    _containerView = [[UIView alloc] init];
    _scrollView = [[UIScrollView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _messageLabel = [[UILabel alloc] init];
    
    // 添加到父视图
    [self addSubview:_containerView];
    [_containerView addSubview:_scrollView];
    [_scrollView addSubview:_titleLabel];
    [_scrollView addSubview:_messageLabel];
    
    // 设置 containerView
    _containerView.backgroundColor = [UIColor whiteColor];
    
    // 设置 titleLabel
    _titleLabel.text = title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    
    // 设置 messageLabel
    _messageLabel.text = message;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.numberOfLines = 0;
    _messageLabel.font = [UIFont systemFontOfSize:13.0];
    
    // 添加约束 titleLabel
    CGFloat titleHeight = [title cy_heightWithWidth:containerWidth andFont:_titleLabel.font] + 1;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(containerWidth);                     // 宽
        make.height.mas_equalTo(titleHeight);                       // 高
        make.bottom.equalTo(_messageLabel.mas_top).offset(-15);     // 底部距离message顶部 15
        make.left.top.right.equalTo(_scrollView);                   // 上，左，右距离scrollView 15
    }];
    
    // 添加约束 messageLabel
    CGFloat messageHeight = [message cy_heightWithWidth:containerWidth andFont:_messageLabel.font] + 1;
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(containerWidth);                     // 宽
        make.height.mas_equalTo(messageHeight);                     // 高
        make.left.right.bottom.equalTo(_scrollView);                // 左，右，下距离scrollView 15
    }];
    
    // 添加约束 scrollView
    CGFloat scrollViewHeight = titleHeight+messageHeight+padding;
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(containerWidth);                         // 宽度等于 containerWidth
        make.height.mas_equalTo(scrollViewHeight).priorityLow();        // 高度，因为还要小于等于450，所以设置低优先级
        UIEdgeInsets edges = UIEdgeInsetsMake(15, 15, 15, 15);
        make.edges.equalTo(_containerView).insets(edges);               // 与 containerView 的边缘距离 15
    }];
    
    // 添加约束 containerView
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
    }];
    
    // 添加约束 self
    CGFloat maxHeight = [UIScreen mainScreen].bounds.size.height - 100.0;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo(maxHeight);                       // 整个alert高度不能大于450
        _bottomConstraint = make.bottom.equalTo(_containerView.mas_bottom); // 底部暂时与scrollView对齐
    }];
    
    return self;
}

/** 添加 action */
- (void)addAction:(CYAlertAction * _Nonnull)action {

    // 添加到 action 数组
    [self.actions addObject:action];
    
    // 创建 button，设置它的属性
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setTag:[self.actions indexOfObject:action]];
    [actionButton setTitle:action.title forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    [actionButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [actionButton setBackgroundImage:self.whiteImage forState:UIControlStateNormal];
    [actionButton setBackgroundImage:self.grayImage forState:UIControlStateHighlighted];
    if (action.style == CYAlertActionStyleDestructive) {
        [actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else if (action.style == CYAlertActionStyleCancel) {
        actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    [actionButton addTarget:self action:@selector(actionButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到父视图
    [self addSubview:actionButton];
    
    // 添加到 button数组
    [self.buttons addObject:actionButton];
    
    // 因为可能添加多个 button，所以只要标记为需要更新，这样即使添加了多次也只会更新一次
    [self setNeedsUpdateConstraints];
    
}

/** 点击按钮事件 */
- (void)actionButtonDidClicked:(UIButton *)sender {
    
    // 根据 tag 取到 handler
    void (^handler) () = self.actions[sender.tag].handler;
    if (handler) {
        handler();
    }
    
    // 点击button后自动dismiss
    if (_controller) {
        [_controller dismissViewControllerAnimated:YES completion:nil];
    }
    
}

/** 更新约束 */
- (void)updateConstraints {
    
    // 根据当前button的数量来布局
    switch (self.buttons.count) {
        case 2:
            [self layoutButtonsHorizontal];
            break;
        default:
            [self layoutButtonsVertical];
            break;
    }
    [super updateConstraints];
    
}

/** 两个 button 时的水平布局 */
- (void)layoutButtonsHorizontal {
    
    UIButton *leftButton = self.buttons[0];
    UIButton *rightButton = self.buttons[1];
    
    // 左边按钮
    [leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(buttonHeight);
        make.left.equalTo(self);
        make.top.equalTo(_containerView.mas_bottom).offset(0.5);
    }];
    
    // 右边按钮
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(buttonHeight);
        make.right.equalTo(self);
        make.top.equalTo(_containerView.mas_bottom).offset(0.5);
        make.left.equalTo(leftButton.mas_right).offset(0.5);
        make.width.equalTo(leftButton);
    }];
    
}

/** 垂直布局 */
- (void)layoutButtonsVertical {
    
    // 记录最下面的一个view
    __block UIView *lastView;
    
    // 遍历在数组中的button，添加到alert上
    for(UIButton *button in self.buttons) {
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            // lastView 为空也就是第一个 button 的时候
            if(!lastView) {
                lastView = _containerView;
            }
            make.left.right.equalTo(self);
            make.height.mas_equalTo(buttonHeight);
            make.top.equalTo(lastView.mas_bottom).offset(0.5);
            
            lastView = button;
        }];
    }
    
    // 更新 alert 底部约束
    [_bottomConstraint uninstall];  // 删除旧的底部约束
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        _bottomConstraint = make.bottom.equalTo(lastView);
    }];
}

@end
