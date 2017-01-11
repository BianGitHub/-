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

@interface ViewController ()

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
    unlockV.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:unlockV];
    
    [unlockV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
}


@end
