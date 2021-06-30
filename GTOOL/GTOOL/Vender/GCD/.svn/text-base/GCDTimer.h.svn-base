//
//  GCDTimer.h
//  GCD
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by XianMingYou on 15/3/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>



//@interface GCDTimerManager :NSObject
//
//
//@end
@class GCDQueue;

@interface GCDTimer : NSObject

@property (strong, readonly, nonatomic) dispatch_source_t dispatchSource;

#pragma 初始化
- (instancetype)init;
- (instancetype)initInQueue:(GCDQueue *)queue;
//performSelector 会阻塞当前线程
//performSelector:(SEL)aSelector withObject:(id)arg afterDelay 子线程中默认是没有runloop的
// 使用[[NSRunLoop currentRunLoop] run];
// 或者
// dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
//         if ([self respondsToSelector:@selector(delayMethod)]) {
//             [self performSelector:@selector(delayMethod) withObject:nil];
//         }
// });
//或者[[GCDQueue mainQueue]execute:<#^(void)block#> afterDelay:<#(int64_t)#>
//


#pragma mark - 用法

//timer执行完成会自动cancel  delloc的时候timer会停止
/// timerWithAsyncEvent
/// @param timesEvent 子线程中返回事件 times还有多少次
/// @param completEvent 完成的回调
/// @param secs 间隔多少秒
/// @param times 总共个执行多少次
+(GCDTimer*)timerWithAsyncEvent:(void (^) (NSInteger times))timesEvent completEvent:(dispatch_block_t)completEvent timeIntervalWithSecs:(float)secs withTimes:(NSInteger)times;

- (void)eventAutoTimesEvent:(void (^) (NSInteger times))timesEvent completEvent:(dispatch_block_t)completEvent timeIntervalWithSecs:(float)secs withTimes:(NSInteger)times;

//进入后台也会持续计时
-(void)addBackgroundTimer;

- (void)cancel;
@end
