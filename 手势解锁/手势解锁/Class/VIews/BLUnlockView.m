//
//  BLUnlockView.m
//  手势解锁
//
//  Created by 边雷 on 17/1/11.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLUnlockView.h"

@implementation BLUnlockView
{
    // 保存所有触碰的按钮集合
    NSMutableArray<UIButton *> *_btnArrM;
    
    // 记录当前点
    CGPoint _currentP;
}

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
    
    // 实例化
    _btnArrM = [NSMutableArray array];
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
            // 记录当前点
            _currentP = loc;
            
            // 开始触摸 -> 记录当前触摸点
            [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                // 判断触摸点是否在按钮身上
                BOOL isContain = CGRectContainsPoint(obj.frame, loc);
                
                // obj.selected == NO -> 防止重复设置按钮******
                if (isContain && obj.selected == NO) {
                    obj.selected = YES;
                    NSLog(@"%@", @(idx));
                    
                    // 将被选中的按钮放入集合
                    [_btnArrM addObject:obj];
                }
                
            }];
            
            // 重绘   -> 让视图执行drawRext方法
            [self setNeedsDisplay];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"松手 判断是否正确");
            // 拼接密码
            NSMutableString *pwd = [NSMutableString string];
            
            [_btnArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                // 获取obj按钮在当前视图的子控件数组中的索引
                NSInteger btnIdx = [self.subviews indexOfObject:obj];
                [pwd appendFormat:@"%@",@(btnIdx)];
            }];
            
            NSLog(@"%@", pwd);
            
            // 判断密码是否正确, 并提示
            if ([_delegate respondsToSelector:@selector(unlockView:didFinishPwd:)]) {
                [_delegate unlockView:self didFinishPwd:pwd];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 绘图
- (void)drawRect:(CGRect)rect
{
    // 将集合中所有的按钮连线
    //  1.创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 2.遍历
    [_btnArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 设置起点
        if(idx == 0)
        {
            [path moveToPoint:obj.center];
        }
        [path addLineToPoint:obj.center];
    }];
    
    // 添加最后一根线
    if (_btnArrM.count > 0) {
        [path addLineToPoint:_currentP];
    }
    
    //设置线宽和颜色
    path.lineWidth = 10;
    
    //设置 线头 和 接头 样式
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [[UIColor whiteColor] setStroke];
    
    //3. 渲染
    [path stroke];
}

#pragma mark - 清除线
- (void)clearScreen
{
    // 把集合中的按钮移除, 然后重绘, 移除之前恢复按钮状态
    [_btnArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.selected = NO;
        
    }];
    
    [_btnArrM removeAllObjects];
    
    // 重绘制
    [self setNeedsDisplay];
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
