//
//  GCDTimer.m
//  GCD
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by XianMingYou on 15/3/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "GCDTimer.h"
#import "GCDQueue.h"
#import <UIKit/UIKit.h>
@interface GCDTimer ()

@property (strong, readwrite, nonatomic) dispatch_source_t dispatchSource;
@property (assign, nonatomic) __block NSInteger interval;
@property (assign, nonatomic)__block NSInteger times;

@property(nonatomic,strong)NSTimer *timer; // timer
//@property(nonatomic,assign)int countDown; // 倒数计时用
@property(nonatomic,strong)NSDate *beforeDate; // 上次进入后台时间
@end

@implementation GCDTimer

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
   
       
        self.dispatchSource = \
        dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    }
    
    return self;
}
-(void)addBackgroundTimer{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterFG) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBG) name:UIApplicationDidEnterBackgroundNotification object:nil];
}
- (instancetype)initInQueue:(GCDQueue *)queue {
    
    self = [super init];
    
    if (self) {
        
        self.dispatchSource = \
        dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue.dispatchQueue);
    }
    
    return self;
}
/**
 *  进入后台记录当前时间
 */
-(void)enterBG {
    NSLog(@"应用进入后台啦");
    _beforeDate = [NSDate date];
}

/**
 *  返回前台时更新倒计时值
 */
-(void)enterFG {
 
    NSDate * now = [NSDate date];
    int interval = (int)ceil([now timeIntervalSinceDate:_beforeDate]);
    NSLog(@"应用将要进入到前台");
    _times-=interval;
    
    
//    int val = _countDown - interval;
//    if(val > 1){
//        _countDown -= interval;
//    }else{
//        _countDown = 1;
//    }
}

- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
}

- (void)event:(dispatch_block_t)block cancelEvent:(dispatch_block_t)cancelEvent timeInterval:(uint64_t)interval {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
    dispatch_source_set_cancel_handler(self.dispatchSource, cancelEvent);
}

- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval delay:(uint64_t)delay {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, delay), interval, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
}

- (void)event:(dispatch_block_t)block cancelEvent:(dispatch_block_t)cancelEvent timeInterval:(uint64_t)interval delay:(uint64_t)delay {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, delay), interval, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
    dispatch_source_set_cancel_handler(self.dispatchSource, cancelEvent);
}

- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
}

- (void)event:(dispatch_block_t)block cancelEvent:(dispatch_block_t)cancelEvent timeIntervalWithSecs:(float)secs {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
    dispatch_source_set_cancel_handler(self.dispatchSource, cancelEvent);
}

- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, delaySecs * NSEC_PER_SEC), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
}

- (void)event:(dispatch_block_t)block cancelEvent:(dispatch_block_t)cancelEvent timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs {
    
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, delaySecs * NSEC_PER_SEC), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
    dispatch_source_set_cancel_handler(self.dispatchSource, cancelEvent);
}
+(GCDTimer*)timerWithAsyncEvent:(void (^) (NSInteger times))timesEvent completEvent:(dispatch_block_t)completEvent timeIntervalWithSecs:(float)secs withTimes:(NSInteger)times{
    GCDTimer * timer = [[GCDTimer alloc]init];
    [timer eventAutoTimesEvent:timesEvent completEvent:completEvent timeIntervalWithSecs:secs withTimes:times];
    return timer;
    
}
- (void)eventAutoTimesEvent:(void (^) (NSInteger times))timesEvent completEvent:(dispatch_block_t)completEvent timeIntervalWithSecs:(float)secs withTimes:(NSInteger)times{
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC), secs * NSEC_PER_SEC, 0);
    _times = times;
    _interval = secs;
    __weak typeof(self)  weakSelf = self;
    dispatch_source_set_event_handler(self.dispatchSource, ^{
        if (weakSelf.times > 0) {
            if (times) {
                timesEvent(weakSelf.times---1);
            }
        }else{
            [weakSelf cancel];
        }
    });
    dispatch_source_set_cancel_handler(self.dispatchSource, completEvent);

    [self start];
}
- (void)start {
    
    dispatch_resume(self.dispatchSource);
}

- (void)cancel {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    dispatch_source_cancel(self.dispatchSource);
}




//- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval;
//- (void)event:(dispatch_block_t)block cancelEvent:(dispatch_block_t)cancelEvent timeInterval:(uint64_t)interval;
//
//- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval delay:(uint64_t)delay;
//- (void)event:(dispatch_block_t)block cancelEvent:(dispatch_block_t)cancelEvent timeInterval:(uint64_t)interval delay:(uint64_t)delay;

//- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs;
//- (void)event:(dispatch_block_t)block cancelEvent:(dispatch_block_t)cancelEvent timeIntervalWithSecs:(float)secs;
//
//- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs;
//- (void)event:(dispatch_block_t)block cancelEvent:(dispatch_block_t)cancelEvent timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs;

//- (void)start;
@end
