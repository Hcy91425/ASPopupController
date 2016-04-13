//
//  ViewController.m
//  CyAlertControllerDemo
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "DemoViewController.h"
#import "CYAlertController.h"

@interface DemoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSArray *titleArray;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
    self.title = @"CYAlertControllerDemo";
    
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
    
    CYAlertController *alert = [CYAlertController alertWithTitle:@"警告！警告！💥"
                                                         message:@"逗你玩儿呢 ~ 😜"];
    // 可以设置 alertView 的圆角半径，默认为6
    alert.alertViewCornerRadius = 10;
    
    // 创建 action
    CYAlertAction *defaultAction = [CYAlertAction actionWithTitle:@"确定" style:CYAlertActionStyleDefault handler:^{ NSLog(@"Default"); }];
    CYAlertAction *destructiveAction = [CYAlertAction actionWithTitle:@"危险" style:CYAlertActionStyleDestructive handler:^{ NSLog(@"Destructive"); }];
    CYAlertAction *cancelAction = [CYAlertAction actionWithTitle:@"取消" style:CYAlertActionStyleCancel handler:^{ NSLog(@"Cancel"); }];
    
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
            alert.presentStyle = CYAlertPresentStyleSystem;
            break;
        case 1:
            alert.presentStyle = CYAlertPresentStyleBounce;
            break;
        case 2:
            alert.presentStyle = CYAlertPresentStyleFadeIn;
            break;
        case 3:
            alert.presentStyle = CYAlertPresentStyleExpandHorizontal;
            alert.dismissStyle = CYAlertDismissStyleContractHorizontal;
            break;
        case 4:
            alert.presentStyle = CYAlertPresentStyleExpandVertical;
            alert.dismissStyle = CYAlertDismissStyleContractVertical;
            break;
        case 5:
            alert.presentStyle = CYAlertPresentStyleSlideDown;
            alert.dismissStyle = CYAlertDismissStyleSlideDown;
            break;
        case 6:
            alert.presentStyle = CYAlertPresentStyleSlideUp;
            alert.dismissStyle = CYAlertDismissStyleSlideUp;
            break;
        case 7:
            alert.presentStyle = CYAlertPresentStyleSlideLeft;
            alert.dismissStyle = CYAlertDismissStyleSlideLeft;
            break;
        case 8:
            alert.presentStyle = CYAlertPresentStyleSlideRight;
            alert.dismissStyle = CYAlertDismissStyleSlideRight;
            break;
        default:
            break;
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
