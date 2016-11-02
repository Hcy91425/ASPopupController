//
//  ViewController.m
//  CyAlertControllerDemo
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "DemoViewController.h"
#import "ASPopupController.h"

@interface DemoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSArray *titleArray;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"ASPopupControllerDemo";
    
    _titleArray = @[@"PresentSystem & DismissFadeOut",
                    @"PresentBounce & DismissFadeOut",
                    @"PresentFadeIn & DismissFadeOut",
                    @"PresentExpand & DismissContract(Horizontal)",
                    @"PresentExpand & DismissContract(Vertical)",
                    @"PresentSlideDown & DismissSlideDown",
                    @"PresentSlideUp & DismissSlideUp",
                    @"PresentSlideLeft & DismissSlideLeft",
                    @"PresentSlideRight & DismissSlideRight"];
    
    UITableView *demoTable = [[UITableView alloc] initWithFrame:self.view.frame];
    demoTable.delegate = self;
    demoTable.dataSource = self;
    [self.view addSubview:demoTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

/** 使用看这里！ */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ASPopupController *alert = [ASPopupController alertWithTitle:@"警告！警告！💥"
                                                         message:@"逗你玩儿呢 ~ 😜"];
    /*
    ASPopupController *alert2 = [ASPopupController alertWithTitle:@"警告！警告！💥"
                                                          message:@"逗你玩儿呢 ~ 😜"
                                                     presentStyle:ASPopupPresentStyleSystem
                                                     dismissStyle:ASPopupDismissStyleFadeOut];
     */
    
    // 可以设置 alertView 的圆角半径，默认为6
    alert.alertViewCornerRadius = 10;
    
    // 创建 action
    ASPopupAction *defaultAction = [ASPopupAction actionWithTitle:@"确定" style:ASPopupActionStyleDefault handler:^{ NSLog(@"Default"); }];
    ASPopupAction *destructiveAction = [ASPopupAction actionWithTitle:@"危险" style:ASPopupActionStyleDestructive handler:^{ NSLog(@"Destructive"); }];
    ASPopupAction *cancelAction = [ASPopupAction actionWithTitle:@"取消" style:ASPopupActionStyleCancel handler:^{ NSLog(@"Cancel"); }];
    
    
    
    // 一次性添加
    [alert addActions:@[defaultAction, destructiveAction, cancelAction]];
    
    /* 也可以一个个添加
     [alert addAction:defaultAction];
     [alert addAction:destructiveAction];
     [alert addAction:cancelAction];
     */
    
    // 设置转场方式
    switch (indexPath.row) {
        case 0:
            alert.presentStyle = ASPopupPresentStyleSystem;
            break;
        case 1:
            alert.presentStyle = ASPopupPresentStyleBounce;
            break;
        case 2:
            alert.presentStyle = ASPopupPresentStyleFadeIn;
            break;
        case 3:
            alert.presentStyle = ASPopupPresentStyleExpandHorizontal;
            alert.dismissStyle = ASPopupDismissStyleContractHorizontal;
            break;
        case 4:
            alert.presentStyle = ASPopupPresentStyleExpandVertical;
            alert.dismissStyle = ASPopupDismissStyleContractVertical;
            break;
        case 5:
            alert.presentStyle = ASPopupPresentStyleSlideDown;
            alert.dismissStyle = ASPopupDismissStyleSlideDown;
            break;
        case 6:
            alert.presentStyle = ASPopupPresentStyleSlideUp;
            alert.dismissStyle = ASPopupDismissStyleSlideUp;
            break;
        case 7:
            alert.presentStyle = ASPopupPresentStyleSlideLeft;
            alert.dismissStyle = ASPopupDismissStyleSlideLeft;
            break;
        case 8:
            alert.presentStyle = ASPopupPresentStyleSlideRight;
            alert.dismissStyle = ASPopupDismissStyleSlideRight;
            break;
        default:
            break;
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
