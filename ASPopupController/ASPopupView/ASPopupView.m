//
//  ASPopupView.m
//  ASPopupView
//
//  Created by Cyrus on 16/4/13.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "ASPopupView.h"
#import "ASPopupAction.h"

/** 间隙 */
const static CGFloat padding = 15.0;

/** 弹窗总宽度 */
const static CGFloat alertWidth = 270;

/** 内容宽度 */
const static CGFloat containerWidth = alertWidth - 2*padding;

/** 按钮高度 */
const static CGFloat buttonHeight = 40.0;

@interface ASPopupView ()

/** 保存事件的数组 */
@property (nonatomic, strong)NSMutableArray<ASPopupAction *> *actions;

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

/** 按钮白色背景 */
@property (nonatomic, strong)UIImage *whiteImage;

/** 按钮灰色背景 */
@property (nonatomic, strong)UIImage *grayImage;

@end

@implementation ASPopupView

/** 懒加载 */
- (NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray<ASPopupAction *> *)actions {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (UIImage *)whiteImage {
    if (!_whiteImage) {
        // 取出button的背景图
        NSBundle *asBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"ASPopupController" ofType:@"bundle"]];
        NSString *whiteImagePath = [asBundle pathForResource:@"as_white" ofType:@"png"];
        _whiteImage = [UIImage imageWithContentsOfFile:whiteImagePath];
    }
    return _whiteImage;
}

- (UIImage *)grayImage {
    if (!_grayImage) {
        // 取出button的背景图
        NSBundle *asBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"ASPopupController" ofType:@"bundle"]];
        NSString *grayImagePath = [asBundle pathForResource:@"as_gray" ofType:@"png"];
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
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:containerWidth].active = YES;
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_messageLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:-padding].active = YES;
    [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_scrollView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_scrollView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_scrollView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    // 添加约束 messageLabel
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:_messageLabel
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:containerWidth].active = YES;
    [NSLayoutConstraint constraintWithItem:_messageLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_scrollView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_messageLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_scrollView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_messageLabel
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_scrollView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    // 添加约束 scrollView
//    CGFloat scrollViewHeight = titleHeight+messageHeight+padding;
    CGFloat scrollViewHeight = [_titleLabel sizeThatFits:CGSizeMake(containerWidth, 0)].height+[_messageLabel sizeThatFits:CGSizeMake(containerWidth, 0)].height+padding;
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:_scrollView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:containerWidth].active = YES;
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_scrollView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:scrollViewHeight];
    heightConstraint.priority = UILayoutPriorityDefaultLow;
    heightConstraint.active = YES;
    [NSLayoutConstraint constraintWithItem:_scrollView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_containerView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:15.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_scrollView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_containerView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:15.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_scrollView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_containerView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-15.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_scrollView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_containerView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-15.0].active = YES;

    
    // 添加约束 containerView
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:_containerView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_containerView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_containerView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    // 添加约束 self
    CGFloat maxHeight = [UIScreen mainScreen].bounds.size.height - 100.0;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:maxHeight].active = YES;
    
    return self;
}

/** 添加 action */
- (void)addAction:(ASPopupAction * _Nonnull)action {

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
    if (action.style == ASPopupActionStyleDestructive) {
        [actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else if (action.style == ASPopupActionStyleCancel) {
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

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

/** 两个 button 时的水平布局 */
- (void)layoutButtonsHorizontal {
    
    UIButton *leftButton = self.buttons[0];
    UIButton *rightButton = self.buttons[1];
    
    // 左边按钮
    leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:leftButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:buttonHeight].active = YES;
    [NSLayoutConstraint constraintWithItem:leftButton
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:leftButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_containerView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.5].active = YES;
    
    // 右边按钮
    rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:buttonHeight].active = YES;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_containerView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.5].active = YES;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:leftButton
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0 constant:0.5].active = YES;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:leftButton
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    // 设置 alert 底部约束
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:rightButton
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.0].active = YES;

    
}

/** 垂直布局 */
- (void)layoutButtonsVertical {
    
    // 记录最下面的一个view
    UIView *lastView;
    
    // 遍历在数组中的button，添加到alert上
    for(UIButton *button in self.buttons) {
        
        if(!lastView) {
            lastView = _containerView;
        }
        
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint constraintWithItem:button
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        [NSLayoutConstraint constraintWithItem:button
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        [NSLayoutConstraint constraintWithItem:button
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:buttonHeight].active = YES;
        [NSLayoutConstraint constraintWithItem:button
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                         toItem:lastView
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1.0
                                     constant:0.5].active = YES;
        
        lastView = button;

    }
    
    // 设置 alert 底部约束
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:lastView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.0].active = YES;
}

@end
