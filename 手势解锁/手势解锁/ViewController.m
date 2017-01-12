//
//  ViewController.m
//  手势解锁
//
//  Created by 边雷 on 17/1/11.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "ViewController.h"
#import "BLUnlockView.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

@interface ViewController ()<BLUnlockViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    // 1.设置背景
    UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
    
    [self.view addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 2.添加解锁视图
    BLUnlockView *unlockV = [[BLUnlockView alloc]init];
    unlockV.delegate = self;
    unlockV.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:unlockV];
    
    [unlockV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
}

#pragma mark -BLUnlockViewDelegate
- (void)unlockView:(BLUnlockView *)lockView didFinishPwd:(NSString *)pwd
{
    // 判断是否是第一次
    // 1.读取密码 - 如果有值, 不是第一次, 如果没有值, 是第一次
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 读取密码
    NSString *savePWD = [defaults objectForKey:@"pwd"];
    
    //设置消失的时间
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    if (savePWD.length == 0) {
        // 存储
        [defaults setObject:pwd forKey:@"pwd"];
        NSLog(@"保存成功");
        [SVProgressHUD showSuccessWithStatus:@"存储成功"];
        return;
    }
    // 2.比较
    if ([savePWD isEqualToString:pwd]) {
        NSLog(@"正确");
        [SVProgressHUD showSuccessWithStatus:@"欢迎归来"];
    } else{
        NSLog(@"输入错误, 请重新输入");
        [SVProgressHUD showInfoWithStatus:@"输入错误, 请重新输入"];
        
        // 清除线
        [lockView clearScreen];
    }
}

@end
