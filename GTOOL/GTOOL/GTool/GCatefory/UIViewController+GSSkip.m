//
//  UIViewController+CNMSkip.m
//  YunMaiQ
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "UIViewController+GSSkip.h"
#import <objc/runtime.h>
@implementation ButtonItemCoutum
-(ButtonItemCoutum *(^)(TypeItem))button_Type{
    
    return ^ButtonItemCoutum* (TypeItem type){
        self.type = type;
        return self;
    };
}

//-(ButtonItemCoutum *(^)(CGFloat))button_SpaceDis{
//
//    return ^ButtonItemCoutum* (CGFloat spaceDis){
//
//        return self;
//    };
//
//
//}
-(ButtonItemCoutum *(^)(CGFloat))button_InsetsDis{
    
    return ^ButtonItemCoutum* (CGFloat insetsDis){
        
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, insetsDis, 0.0, 0.0) ];
        return self;
    };
}

@end

@implementation PushCanvas


@end

@implementation UIViewController (CNMSkip)

-(void)pushCanvas:(NSString *)canvasName{
    [self pushCanvas:canvasName withBlock:nil];
}
-(void)pushCanvas:(NSString *)canvasName withBlock:(void (^)(UIViewController* vc))block{
    UIViewController* vc = [self getVc:canvasName];
    if (block) {
        block(vc);
    }
    [self.navigationController pushViewController:vc animated:YES];
}
/** push指定页面*/
-(void)pushCanvas:(NSString *)canvasName withComplete:(void (^)(PushCanvas* canvas))comPlete;
{
    UIViewController* vc = [self getVc:canvasName];
    
    if (vc) {
        __block BOOL isBeforeBottomBar = YES;
        __block BOOL isAfterBottomBar = NO;
        
        PushCanvas* canvas = [[PushCanvas alloc]init];
        canvas.controller = vc;
        canvas.BlockBefore = ^(BOOL isHidesBottomBar){
            isBeforeBottomBar =isHidesBottomBar ;
        };
        canvas.BlocAfter =^(BOOL isHidesBottomBar){
            isAfterBottomBar =isHidesBottomBar;
        };
        if (comPlete) {
            comPlete(canvas);
        }
        
        vc.hidesBottomBarWhenPushed =isBeforeBottomBar;//要用vc的hidesBottomBarWhenPushed 而不是self
        [self.navigationController pushViewController:vc animated:YES];
        
        if (isAfterBottomBar) {//==NO默认不写
            vc.hidesBottomBarWhenPushed =isAfterBottomBar;
        }
        canvas = nil;
    }
}

/** pop到上一层 */
-(void)popCanvas{
    NSInteger vcCount = [self.navigationController.viewControllers count];
    
    if (vcCount >=2) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

/** pop到指定页面，canvasName为nil 则返回上一个vc*/
-(void)popToCanvas:(NSString *)canvasName withComplete:(void(^)(UIViewController* vc))comPlete{
    
    if (canvasName == nil) {
        [self popCanvas];
    }else{
        Class object = NSClassFromString(canvasName);
        
        for (UIViewController* canvasController in self.navigationController.viewControllers) {
            
            if (canvasController &&[canvasController isKindOfClass:[object class]]) {
                
                if (comPlete) {
                    
                    comPlete(canvasController);
                }
                [self.navigationController popToViewController:canvasController animated:YES];
                
                
                
            }
        }
        
    }
    
}

/** pop到根视图*/
-(void)popToRootCanvasWithArgmentWithComplete:(void(^)(UIViewController* vc))comPlete{
    
    UIViewController* canvasController =[self.navigationController.viewControllers objectAtIndex:0];
    
    if (canvasController) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        if (comPlete) {
            
            comPlete(canvasController);
        }
    }
}

-(UIViewController*)getVc:(NSString*)canvasName{
    return  [[NSClassFromString(canvasName) alloc]init];
    
}

-(void)setNavigationItem:(void (^)(ButtonItemCoutum* button))initBlock withBlock:(void (^)(TypeItem type) )block{
    
    ButtonItemCoutum* button = [ButtonItemCoutum buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, 44, 44);//类型太多，需要改变的话单独去控制
    if (initBlock) {
        initBlock(button);
    }
    __weak ButtonItemCoutum* buttonWeak = button;
    [button g_addBtnActionHandler:^{
        if (block) {
            block(buttonWeak.type);
        }
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *itemSpacer = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                   target:nil action:nil];
    
    itemSpacer.width = button.button_SpaceDis;
    
    if (button.type == Type_Left) {
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:itemSpacer ,item, nil];
    }else{
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:item,itemSpacer ,nil];
    }
    
    
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}


@end
