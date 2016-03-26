//
//  CYAlertView.m
//  CYAlertController
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "CYAlertView.h"
#import "NSString+Size.h"

@interface CYAlertView ()
@property (nonatomic, copy)EmptyBlock leftButtonBlock;
@property (nonatomic, copy)EmptyBlock rightButtonBlock;
@end


@implementation CYAlertView{
    CGFloat _totalHeight;
    CGFloat _buttonHeight;
}

- (nonnull instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    CGFloat titleHeight = [title cy_heightWithWidth:230 andFont:[UIFont systemFontOfSize:17]];
    CGFloat messageHeight = [message cy_heightWithWidth:230 andFont:[UIFont systemFontOfSize:13]];
    CGFloat edge = 20;                      // 边缘距离
    CGFloat betweenTAndM = 10;              // 标题和信息
    _buttonHeight = 50.0;                   // 按钮高度
    _totalHeight = titleHeight+messageHeight+_buttonHeight+2*edge+betweenTAndM;// 总体高度
    if (_totalHeight < 450) {
        self = [super initWithFrame:CGRectMake(0, 0, 270, _totalHeight)];
    } else {
        self = [super initWithFrame:CGRectMake(0, 0, 270, 450)];
    }
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 6;
        self.clipsToBounds = YES;
        
        // scroll view 总高度不超过450
        UIScrollView *mainScrollView = [[UIScrollView alloc] init];
        mainScrollView.showsVerticalScrollIndicator = NO;
        if (_totalHeight < 450) {
            mainScrollView.frame = CGRectMake(edge, edge, 270-2*edge, titleHeight+betweenTAndM+messageHeight);
        }else {
            mainScrollView.frame = CGRectMake(edge, edge, 270-2*edge, 450-_buttonHeight-2*edge);
            mainScrollView.contentSize = CGSizeMake(0, titleHeight+edge+messageHeight);
        }
        
        // title
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270-2*edge, titleHeight)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:17];
        
        // message
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, betweenTAndM+titleHeight, 270-2*edge, messageHeight)];
        messageLabel.text = message;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont systemFontOfSize:13];
        
        // add s
        [mainScrollView addSubview:titleLabel];
        [mainScrollView addSubview:messageLabel];
        [self addSubview:mainScrollView];
        
        // 横线
        CGFloat y = _totalHeight < 450 ? _totalHeight-_buttonHeight : 450-_buttonHeight;
        UIView *horizontalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, 0.4)];
        horizontalLineView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        [self addSubview:horizontalLineView];
    }
    return self;
}

- (nonnull instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message leftButtonTitle:(nullable NSString *)leftButtonTitle leftButtonAction:(nullable EmptyBlock)leftButtonAction rightButtonTitle:(nullable NSString *)rightButtonTitle rightButtonAction:(nullable EmptyBlock)rightButtonAction {
    
    self = [self initWithTitle:title message:message];
    // 保存两个block
    _leftButtonBlock = leftButtonAction;
    _rightButtonBlock = rightButtonAction;

    // 计算y坐标
    CGFloat y = _totalHeight < 450 ? _totalHeight-_buttonHeight : 450-_buttonHeight;

    // 如果两个按钮都有值添加竖线
    if (leftButtonTitle && rightButtonTitle ) {
        
        // 初始化leftButton
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        leftButton.frame = CGRectMake(0, y, self.frame.size.width/2.0, _buttonHeight);
        [leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(didClickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        
        // 初始化rightButton
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        rightButton.frame = CGRectMake(self.frame.size.width/2.0, y, self.frame.size.width/2.0, _buttonHeight);
        [rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(didClickRightButton) forControlEvents:UIControlEventTouchUpInside];
        
        // 初始化竖线
        UIView *vertalLineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, y, 0.4, _buttonHeight)];
        vertalLineView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        
        [self addSubview:leftButton];
        [self addSubview:rightButton];
        [self addSubview:vertalLineView];
        
    } else if (leftButtonTitle && !rightButtonTitle) {  // 如果左边的buttonTitle不为空
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        leftButton.frame = CGRectMake(0, y, self.frame.size.width, _buttonHeight);
        [leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(didClickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftButton];
        
    } else if (!leftButtonTitle && rightButtonTitle) {  // 如果右边的buttonTitle不为空
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        rightButton.frame = CGRectMake(0, y, self.frame.size.width, _buttonHeight);
        [rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(didClickRightButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
        
    } else {
        // 默认一个button
        UIButton *defaultButton = [UIButton buttonWithType:UIButtonTypeSystem];
        defaultButton.frame = CGRectMake(0, y, self.frame.size.width, _buttonHeight);
        [defaultButton setTitle:@"Done" forState:UIControlStateNormal];
        [defaultButton addTarget:self action:@selector(defaultAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:defaultButton];
        
    }
    
    return self;
}

- (void)didClickLeftButton {
    if (_leftButtonBlock) {
        _leftButtonBlock();
    }
}

- (void)didClickRightButton {
    if (_rightButtonBlock) {
        _rightButtonBlock();
    }
}

- (void)defaultAction {
    
}

@end
