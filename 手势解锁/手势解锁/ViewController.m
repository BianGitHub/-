//
//  ViewController.m
//  手势解锁
//
//  Created by 边雷 on 17/1/11.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "ViewController.h"
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
    
    // 设置背景
    UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
    
    [self.view addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


@end
