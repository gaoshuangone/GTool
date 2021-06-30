//
//  GCDGroup.h
//  GCD
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by XianMingYou on 15/3/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDGroup : NSObject

@property (strong, nonatomic, readonly) dispatch_group_t dispatchGroup;

#pragma 初始化
- (instancetype)init;

#pragma mark - 用法
- (void)enter;
- (void)leave;
//等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）
- (void)wait;
//等待上面的任务全部完成后，或者时间结束后，会往下继续执行 （会阻塞当前线程）
- (BOOL)wait:(float)delta;

@end
