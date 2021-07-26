//
//  UIAlertView+GAlert.m
//  GTOOL
//
//  Created by tg on 2020/12/23.
//

#import "UIAlertController+GAlert.h"
#import "ZJAnimationPopView.h"
#import "NSObject+GObject.h"
#import "WYAlertView.h"
@implementation UIAlertController (GAlert)
/** 单个按键的 alertView */
+ (void)g_AlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle handler:(void(^)(void))handler {
    

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // creat action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      
        if (handler) {
            handler();
        }
    }];
    
    // add acton
    [alert addAction:cancelAction];
    
    // present alertView on rootViewController
    [kGetCurrentVC() presentViewController:alert animated:YES completion:nil];
}

+(ZJAnimationPopView*)setPopViewWitCustomView:(UIView*)alertView{
    ZJAnimationPopView* popViewHave =(ZJAnimationPopView*)[[UIApplication sharedApplication].keyWindow  viewWithTag:@"popView".hash];
    
    if (popViewHave) {
        [popViewHave removeFromSuperview];
        popViewHave = nil;
    }
    
    // 1.初始化
    ZJAnimationPopView* popView = [[ZJAnimationPopView alloc] initWithCustomView:alertView popStyle:ZJAnimationPopStyleCardDropFromLeft dismissStyle:ZJAnimationDismissStyleCardDropToLeft];

    popView.tag =@"popView".hash;
      // 2.设置属性，可不设置使用默认值，见注解
      // 2.1 显示时点击背景是否移除弹框
      //    popView.isClickBGDismiss = YES;
      // 2.2 显示时背景的透明度d
      popView.popBGAlpha = 0.5f;
      // 2.3 显示时是否监听屏幕旋转
      //    popView.isObserverOrientationChange = YES;
      // 2.4 显示时动画时长
      //    popView.popAnimationDuration = 0.8f;
      // 2.5 移除时动画时长
      //    popView.dismissAnimationDuration = 0.8f;
    // 2.6 显示完成回调
    popView.popComplete = ^{

    };
    // 4.显示弹框
    [popView pop];
    return popView;
}
+ (void)alertAnimateViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle handler:(void(^)(void))handler{
    WYAlertView* alertView = [[WYAlertView alloc]init];
    [alertView  showAlertViewWithTitle:title message:message messageAlignment:WYAlertViewTextAlignmentCenter buttonTitle:confirmTitle buttonClickedBlock:nil];
    
    ZJAnimationPopView * popView = [self setPopViewWitCustomView:alertView];
    alertView.alertViewBtnClickedBlock = ^(NSInteger tag) {
        [popView dismiss];
    };
    // 2.7 移除完成回调
    popView.dismissComplete = ^{

        if (handler) {
            handler();
        }
    };
    

}

+ (void)alertAnimateViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancel:(void(^)(void))cancel confirm:(void (^)(void))confirm{
    
    WYAlertView* alertView = [[WYAlertView alloc]init];
    [alertView showAlertViewWithTitle:title message:message messageAlignment:WYAlertViewTextAlignmentCenter leftButtonTitle:cancelTitle rightButtonTitle:confirmTitle buttonClickedBlock:nil];
    
    ZJAnimationPopView * popView = [self setPopViewWitCustomView:alertView];
    alertView.alertViewBtnClickedBlock = ^(NSInteger tag) {

        popView.tagIndex = tag;
        [popView dismiss];
    };
    // 2.7 移除完成回调
    popView.dismissComplete = ^{

        if (popView.tagIndex == 1 && cancel) {
            cancel();
        }else if(popView.tagIndex == 2 && confirm){
            confirm();
        }
    };
    
}

/** 双按键的 alertView */
+ (void)g_AlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle distinct:(BOOL)distinct cancel:(void(^)(void))cancel confirm:(void(^)(void))confirm {
    

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (distinct) {
        // 左浅右深
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      
            if (cancel) {
                cancel();
            }
        }];
        [alert addAction:cancelAction];
    } else {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            if (cancel) {
                cancel();
            }
        }];
        [alert addAction:cancelAction];
    }
    
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        };
    }];
    
    [alert addAction:defaultAction];
    
    
    [kGetCurrentVC() presentViewController:alert animated:YES completion:nil];
}

/** Alert  任意多个按键 返回选中的 buttonIndex 和 buttonTitle */
+ (void)alertActionViewWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles  preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
        handler(0, @"取消");
    }];
    [alert addAction:cancelAction];
    
    for (int i = 0; i < actionTitles.count; i ++) {
        
        UIAlertAction *confimAction = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler((i + 1), actionTitles[i]);
        }];
        [alert addAction:confimAction];
    }
    
    
    [kGetCurrentVC() presentViewController:alert animated:YES completion:nil];


}
@end
