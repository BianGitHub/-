//
//  BLUnlockView.m
//  手势解锁
//
//  Created by 边雷 on 17/1/11.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLUnlockView.h"

@implementation BLUnlockView

// 代码创建视图时调用
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 搭建界面
- (void)setupUI
{
    for (NSInteger i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 普通状态
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        // 选中状态
        [btn setImage:[UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
        // 错误状态
        [btn setImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
        [self addSubview:btn];
    }
}

#pragma mark - 布局子控件按钮
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 九宫格算法
    // 1.按钮的宽高  -> 根据图片素材确定
    CGFloat btnW = 74;
    CGFloat btnH = btnW;
    
    //2.确定列数
    NSInteger colums = 3;
    
    // 3.计算间距
    CGFloat margin = (self.bounds.size.width - colums * btnW) / (colums - 1);
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 4.确定行号,列号
        NSInteger row = idx / colums;
        NSInteger col = idx % colums;
        
        CGFloat btnX = col * (btnW + margin);
        CGFloat btnY = row * (btnH + margin);
        
        obj.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }];
}

@end
