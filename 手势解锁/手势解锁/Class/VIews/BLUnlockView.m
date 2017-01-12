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
        
        // 关闭按钮的用户交互
        btn.userInteractionEnabled = NO;
        // 普通状态
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        // 选中状态
        [btn setImage:[UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
        // 错误状态
        [btn setImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
        [self addSubview:btn];
    }
    
    // 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    // 设置长按手势的出发时间
    longPress.minimumPressDuration = 0.1;
    
    [self addGestureRecognizer:longPress];
}

#pragma mark - 长安手势监听方法
- (void)longPressAction: (UILongPressGestureRecognizer *)recognizer
{
    // 1.获取用户的触摸点
    CGPoint loc = [recognizer locationInView:self];
    
    // 2.根据状态执行不同的操作
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            // 开始触摸 -> 记录当前触摸点
            [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                // 判断触摸点是否在按钮身上
                BOOL isContain = CGRectContainsPoint(obj.frame, loc);
                
                // obj.selected == NO -> 防止重复设置按钮
                if (isContain && obj.selected == NO) {
                    obj.selected = YES;
                    NSLog(@"%@", @(idx));
                }
                
            }];
        }
            break;
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            
            break;
            
        default:
            break;
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
