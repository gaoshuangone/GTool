//
//  AppDelegate+XYAppService.m
//  ProjectUkitSet
//
//  Created by xiaoye on 2018/7/4.
//  Copyright © 2018年 xiaoye. All rights reserved.
//

#import "AppDelegate+GLaunce.h"
#import "NSObject+swizzle.h"
#import "UIView+GView.h"
#if __has_include("SceneDelegate.h")
#import "SceneDelegate.h"
#endif

//线上环境打开使用
#if __has_include("AvoidCrash.h") && !DEBUG
#import "AvoidCrash.h"
#endif

//测试环境打开使用
#if  __has_include("LLDebugTool.h") && DEBUG
#import "LLDebugTool.h"
#endif

//线上环境打开配置
#if __has_include(<Bugly.h>)
#import <Bugly.h>
#endif
#if __has_include("Bugly.h")
#import "Bugly.h"
#endif


#if __has_include(<SVProgressHUD.h>)
#import <SVProgressHUD.h>
#endif
#if __has_include("SVProgressHUD.h")
#import "SVProgressHUD.h"
#endif


@interface UIView (ExchangeView)
- (NSArray *)mas_makeConstraints_lastView:(id)block;

@end
@implementation UIView (ExchangeView)
- (NSArray *)mas_makeConstraints_lastView:(id)block {
    id maker =    [self mas_makeConstraints_lastView:block];
    [GSharedClass shared].masViewLast = self;
    return maker;
}
@end





@interface ExchangeObject : NSObject

+(void)swizzingLaunchMothod;
@end
@implementation ExchangeObject

+(void)swizzingLaunchMothod{
    
    
#if __has_include("AvoidCrash.h") && !DEBUG
    
    //全局启动防止崩溃功能
    [AvoidCrash makeAllEffective];
    //配置方法异常异常集合
    NSArray *noneSelClassStrings = @[
        @"NSNull",
        @"NSNumber",
        @"NSString",
        @"NSDictionary",
        @"NSArray"
    ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    //防止某个前缀的类的方法异常
    NSArray *noneSelClassPrefix = @[
        @"AvoidCrash"
    ];
    [AvoidCrash setupNoneSelClassStringPrefixsArr:noneSelClassPrefix];
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
#endif
    
    
    
#if __has_include(<SVProgressHUD.h>) || __has_include("SVProgressHUD.h")
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundLayerColor:[[UIColor blackColor] colorWithAlphaComponent:0.03f]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setFont:kFontMedium(14)];
    
#endif
    
    
#if  __has_include("LLDebugTool.h") && DEBUG
    [[LLDebugTool sharedTool] startWorkingWithConfigBlock:^(LLConfig * _Nonnull config) {
        
        config.colorStyle = LLConfigColorStyleSimple;
        [config configPrimaryColor:[UIColor orangeColor] backgroundColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
        config.hideWhenInstall = YES;
        config.showDebugToolLog = NO;
        config.inactiveAlpha =.5f;
        config.shakeToHide = YES;
    }];
#endif
}

@end






@implementation AppDelegate (GLaunce)

- (BOOL)applicationExchangeMethod:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self applicationExchangeMethod:application didFinishLaunchingWithOptions:launchOptions];
    [ExchangeObject swizzingLaunchMothod];
    return  YES;
}

#if __has_include("AvoidCrash.h")
// 异常错误处理
- (void)dealwithCrashMessage:(NSNotification *)note {
    //注意:所有的信息都在userInfo中
    NSLog(@"******************* 空指针异常 %@", note.userInfo);
    NSDictionary *dict = note.userInfo;
    if(dict) {
#if __has_include(<Bugly.h>) || __has_include("Bugly.h")
        NSString *name = [NSString stringWithFormat:@"空指针异常:%@", dict[@"errorPlace"]];
        NSString *reason = dict[@"errorReason"];
        NSException *ex = [[NSException alloc] initWithName:name reason:reason userInfo:dict];
        [Bugly reportException:ex];
#endif
        
    }
}
#else

#endif
+ (void)load {
    //SceneDelegate暂时用不到
#if __has_include("SceneDelegate.h")
    [[SceneDelegate class] swizzingMethod:@selector(scene:willConnectToSession:options:) withMethod:@selector(sceneExchangeMethod:willConnectToSession:options:)];
#endif
    
   
    [UIView  swizzingMethod:@selector(mas_makeConstraints:) withMethod:@selector(mas_makeConstraints_lastView:)];

    [self swizzingMethod:@selector(application:didFinishLaunchingWithOptions:) withMethod:@selector(applicationExchangeMethod:didFinishLaunchingWithOptions:)];
}

@end







//SceneDelegate暂时用不到
#if __has_include("SceneDelegate.h")
@interface SceneDelegate (SceneDelegateService)

@end
@implementation SceneDelegate (SceneDelegateService)
- (void)sceneExchangeMethod:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions{
    
    [self sceneExchangeMethod:scene willConnectToSession:session options:connectionOptions];
    //willConnectToSession window 创建的比较慢
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        [ExchangeObject swizzingLaunchMothod];
    });
    dispatch_resume(timer);
    
}

@end
#endif



