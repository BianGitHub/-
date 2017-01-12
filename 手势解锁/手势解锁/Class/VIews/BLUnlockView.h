//
//  BLUnlockView.h
//  手势解锁
//
//  Created by 边雷 on 17/1/11.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BLUnlockView;
@protocol BLUnlockViewDelegate <NSObject>

// 解锁视图完成密码拼接时
- (void)unlockView:(BLUnlockView *)lockView didFinishPwd:(NSString *)pwd;

@end

@interface BLUnlockView : UIView

@property(nonatomic, weak) id<BLUnlockViewDelegate> delegate;

// 清除线
- (void)clearScreen;

@end
