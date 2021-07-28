//
//  UIViewController+CNMSkip.h
//  YunMaiQ
//
//  Created by 高爽 on 17/3/9.
//  Copyright © 2017年 XR. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    Type_Left,
    Type_Right,
}TypeItem;
//设置button image 不能异步
@interface ButtonItemCoutum : UIButton


@property (assign, nonatomic)TypeItem type;

/** left right按钮type*/
@property (copy, nonatomic)ButtonItemCoutum *(^button_Type)(TypeItem type);

/** 按钮图片上下调整*/
@property (copy, nonatomic)ButtonItemCoutum *(^button_InsetsDis)(CGFloat insetsDis);


/** 按钮图片左右调整*/

@property (assign, nonatomic)CGFloat button_SpaceDis;
//@property (copy, nonatomic)ButtonItemCoutum *(^button_SpaceDis)(CGFloat spaceDis); ;

@end


typedef void (^HidesBottomBaBeforeBlock)(BOOL isHidesBottomBa);
typedef void (^HidesBottomBaAfterBlock)(BOOL isHidesBottomBa);

@interface PushCanvas : NSObject
/** 默认push一个页面隐藏tabbar*/
@property (copy, nonatomic)HidesBottomBaBeforeBlock BlockBefore;
/** 默认push一个页面之后不设置返回的tabbar隐藏还是显示*/
@property (copy, nonatomic)HidesBottomBaAfterBlock BlocAfter;
/** push过后的vc*/
@property (strong, nonatomic)UIViewController* controller;
@end
@interface UIViewController (CNMSkip)

/** push指定页面*/
-(void)pushCanvas:(NSString *)canvasName;
/** push指定页面*/
-(void)pushCanvas:(NSString *)canvasName withBlock:(void (^)(UIViewController* vc))block;

/** pop到上一层 */
-(void)popCanvas;

/** pop到指定页面，canvasName为nil 则返回上一个vc*/
-(void)popToCanvas:(NSString *)canvasName withComplete:(void(^)(UIViewController* vc))comPlete;
//-(void)popToCanvas:(NSString *)canvasName withComplete:(void(^)(PushCanvas* canvas))comPlete;

/** pop到根视图*/
-(void)popToRootCanvasWithArgmentWithComplete:(void(^)(UIViewController* vc))comPlete;


/**设置navigationcontroller左右按钮
 initBlock返回的ButtonItemCoutum可以自定义
 block 点击方法回调
 */
-(void)setNavigationItem:(void (^)(ButtonItemCoutum* button))initBlock withBlock:(void (^)(TypeItem type) )block;


/** 获取当前VC*/
- (UIViewController *)getCurrentVC;
@end



