//
//  UIAlertView+GAlert.h
//  GTOOL
//
//  Created by tg on 2020/12/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (GAlert)
/**
 *  单个按键的 alertView
 *
 *  @param title         标题
 *  @param message      内容信息
 *  @param confirmTitle 按键标题
 */
+ (void)alertAnimateViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle handler:(void(^)(void))handler;

/**
 *  双按键的 alertView
 *
 *  @param title         标题
 *  @param message      内容信息
 *  @param cancelTitle  左标题
 *  @param confirmTitle 右标题
 *  @param cancel       左按键回调
 *  @param confirm      右按键回调
 */

+ (void)alertAnimateViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancel:(void(^)(void))cancel confirm:(void (^)(void))confirm;


/**
 *  任意多按键的 alert (alertView or ActionSheet)
 *
 *  @param title          标题
 *  @param message        内容
 *  @param actionTitles   按键标题数组
 *  @param preferredStyle  弹窗类型 alertView or ActionSheet
 *  @param handler        按键回调
 内置"取消"按键, buttonIndex 为0
 */
+ (void)alertActionViewWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles  preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler;


@end

NS_ASSUME_NONNULL_END
