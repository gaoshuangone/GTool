//
//  GCDQueue.h
//  GCD
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by XianMingYou on 15/3/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <Foundation/Foundation.h>
//GCD和NSThread是不同的，GCD会维护一个线程池。根据线程池中的线程实际消耗情况来决定是否新开线程。简单的说，你虽然创建了三个异步任务，但是在执行第三个任务之前已经有一个任务执行完了，所以空出来了一个线程，此时就直接拿来使用，而不需要新开子线程。
@class GCDGroup;

@interface GCDQueue : NSObject

@property (strong, readonly, nonatomic) dispatch_queue_t dispatchQueue;

+ (GCDQueue *)mainQueue;
+ (GCDQueue *)globalQueue;
+ (GCDQueue *)highPriorityGlobalQueue;
+ (GCDQueue *)lowPriorityGlobalQueue;
+ (GCDQueue *)backgroundPriorityGlobalQueue;


#pragma mark - 便利的构造方法
//主线程的串行的queue队列
+ (void)executeInMainQueue:(dispatch_block_t)block;
//全局的并行的queue。HighPriority，LowPriority，只能保证哪个线程先执行，不能保证哪个先执行完
+ (void)executeInGlobalQueue:(dispatch_block_t)block;
+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block;
+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block;
+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block;

+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;

//自定义的queue队列
#pragma 初始化
//自定义的串行queue
- (instancetype)init;
- (instancetype)initSerial;
- (instancetype)initSerialWithLabel:(NSString *)label;
//自定义的并行queue
- (instancetype)initConcurrent;
- (instancetype)initConcurrentWithLabel:(NSString *)label;

#pragma mark - 用法
//串行队列中，不会阻塞当前队列， 一个一个执行
- (void)execute:(dispatch_block_t)block;
- (void)execute:(dispatch_block_t)block afterDelay:(int64_t)delta;
- (void)execute:(dispatch_block_t)block afterDelaySecs:(float)delta;
//并行队列中,会阻塞当前队列, 包括同步线程之前的线程并行执行，等到同步线程返回后并行执行下方任务
- (void)waitExecute:(dispatch_block_t)block;

//使用栅栏函数时.使用自定义队列才有意义,如果用的是串行队列或者系统提供的全局并发队列,这个栅栏函数的作用等同于一个同步函数的作用
//自定义队列，栅栏前队列执行完成后才会执行栅栏后的队列
//异步栅栏不会阻塞队列中线程，会立马返回
- (void)barrierExecute:(dispatch_block_t)block;
//同步栅栏会阻塞队列线程，会等待栅栏函数执行完
- (void)waitBarrierExecute:(dispatch_block_t)block;

//多用到串行队列中
//队列挂起
- (void)suspend;
//开启队列
- (void)resume;

#pragma mark - 与GCDGroup相关

//多个异步线程的同步执行中，同样也可以使用信号量实现GCDSemaphore
- (void)execute:(dispatch_block_t)block inGroup:(GCDGroup *)group;
//notify在group下的并行队列中，异步执行异步任务会直接回调，可用enter leave组合使用，异步执行同步任务会等全部执行完成后回调
- (void)notify:(dispatch_block_t)block inGroup:(GCDGroup *)group;
+ (void)executeInGlobalQueue:(dispatch_block_t)block inGroup:(GCDGroup *)group;

@end


/*******************************************异步调用主线程刷新*******************************************/
 /*
 [GCDQueue executeInGlobalQueue:^{
     [GCDQueue executeInMainQueue:^{
         
     }];
 }];
 */



/*******************************************多个异步线程的同步执行中*******************************************/
/*
 GCDGroup* group = [[GCDGroup alloc]init];
 
 [GCDQueue executeInGlobalQueue:^{
     for (int i=0; i<=5; i++) {
     NSLog(@"%d______1",i);
     }

 } inGroup:group];
 
 [GCDQueue executeInGlobalQueue:^{
     NSLog(@"________2");
     [group enter];
     [GCDQueue executeInGlobalQueue:^{
         sleep(3);
         for (int i=0; i<=5; i++) {
         NSLog(@"%d______2",i);
         }
         [group leave];
     }];
     
 } inGroup:group];
 
 [GCDQueue executeInGlobalQueue:^{
     
     [group enter];
     [GCDQueue executeInGlobalQueue:^{
         sleep(6);
         for (int i=0; i<=5; i++) {
         NSLog(@"%d______4",i);
         }
         [group leave];
     }];
  

 } inGroup:group];

 //阻塞线程
 [group wait:10];
 //超时后执行
 
 [[GCDQueue globalQueue] notify:^{
 //同步执行，等待 leave完成后执行
 for (int i=0; i<=5; i++) {
 NSLog(@"%d______5",i);
 }

 } inGroup:group];
 */



/********************************************栅栏函数*******************************************/
/*
 GCDQueue * queue = [[GCDQueue alloc]initConcurrent];
 NSLog(@"began");
 [queue execute:^{
     NSLog(@"start task 1");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"end task 1");
 }];
 [queue waitExecute:^{

 }];

 NSLog(@"end");

 [queue execute:^{
     NSLog(@"start task 3");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"end task 3");
 }];
 [queue execute:^{
     NSLog(@"start task 4");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"end task 4");
 }];
 */


