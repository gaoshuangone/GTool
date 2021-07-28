//
//  GButtonChainModel.m
//  GKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "GButtonChainModel.h"

#import <objc/runtime.h>

#define  G_CHAIN_BUTTON_IMPLEMENTATION(methodName, viewMethod, ParmaType)  G_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, GButtonChainModel * , UIButton)

#define  G_CHAIN_UIBUTTON_IMPLEMENTATION(methodType, methodName, viewMethod, ParmaType, StateType) \
- (methodType)methodName{ \
   __weak typeof(self) weakSelf = self; \
if ([self.view.class instancesRespondToSelector:@selector(viewMethod:forState:)]) { \
        return ^(ParmaType param, StateType state){ \
            [(UIButton *)weakSelf.view viewMethod:param forState:state]; \
            return weakSelf; \
        }; \
    } \
    return ^(ParmaType paramt, StateType state){ \
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__); \
        return weakSelf; \
    }; \
} \


@interface GButtonChainModel()
@property (assign, nonatomic)BOOL isCanSoonClickChain;
@end
@implementation GButtonChainModel

//G_CHAIN_BUTTON_IMPLEMENTATION(title, title, setTitle, NSString *, UIControlState);
- (GButtonChainModel * _Nullable (^)(NSString * _Nonnull, UIControlState))title{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setTitle:forState:)]) {
        return ^(NSString *title, UIControlState state ){
            [(UIButton *)weakSelf.view setTitle:title forState:state];
            return weakSelf;
        };
    }
    return ^(NSString *title,UIControlState state){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}
- (GButtonChainModel * _Nullable (^)(UIColor * _Nonnull, UIControlState))titleColor{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setTitleColor:forState:)]) {
        return ^(UIColor *titleColor, UIControlState state ){
            [(UIButton *)weakSelf.view setTitleColor:titleColor forState:state];
            return weakSelf;
        };
    }
    return ^(UIColor *title, UIControlState state ){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}
- (GButtonChainModel * _Nullable (^)(UIFont * _Nonnull))titleFont{
    __weak typeof(self) weakSelf = self;
       return ^(UIFont *titleFont){
           [((UIButton *)weakSelf.view).titleLabel setFont:titleFont];
           return weakSelf;
       };
}

-(GButtonChainModel * _Nullable (^)(BOOL))isCanSoonClick{
    
    __weak typeof(self) weakSelf = self;
       return ^(BOOL isSoonClick){
//           ((UIButton *)weakSelf.view).isCanSoonClick = isSoonClick;
           self.isCanSoonClickChain = isSoonClick;
           return weakSelf;
       };
}
- (GButtonChainModel * _Nullable (^)(NSAttributedString * _Nonnull, UIControlState))attributedTitle{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setAttributedTitle:forState:)]) {
        return ^(NSAttributedString *attributedTitle, UIControlState state ){
            [(UIButton *)weakSelf.view setAttributedTitle:attributedTitle forState:state];
            return weakSelf;
        };
    }
    return ^(NSAttributedString *attributedTitle, UIControlState state){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}

- (GButtonChainModel * _Nullable (^)(UIImage * _Nonnull, UIControlState))image{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setImage:forState:)]) {
        return ^(UIImage *image, UIControlState state){
            [(UIButton *)weakSelf.view setImage:image forState:state];
            return weakSelf;
        };
    }
    return ^(UIImage *image, UIControlState state){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}

- (GButtonChainModel * _Nullable (^)(UIImage * _Nonnull, UIControlState))backgroundImage{
    __weak typeof(self) weakSelf = self;
         if ([self.view.class instancesRespondToSelector:@selector(setBackgroundImage:forState:)]) {
             return ^(UIImage *image, UIControlState state){
                 [(UIButton *)weakSelf.view setBackgroundImage:image forState:state];
                 return weakSelf;
             };
         }
         return ^(UIImage *image, UIControlState state){
             NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
             return weakSelf;
         };
}

- (GButtonChainModel * _Nullable (^)(UIColor * _Nonnull, UIControlState))backgroundColorState{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setBackgroundImage:forState:)]) {
        return ^(UIColor *color, UIControlState state ){
            [(UIButton *)weakSelf.view setBackgroundImage:[self zj_imageWithColor:color] forState:state];
            return weakSelf;
        };
    }
    return ^(UIColor *title, UIControlState state ){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}


G_CHAIN_BUTTON_IMPLEMENTATION(contentEdgeInsets,setContentEdgeInsets,UIEdgeInsets);
G_CHAIN_BUTTON_IMPLEMENTATION(titleEdgeInsets,setTitleEdgeInsets,UIEdgeInsets);
G_CHAIN_BUTTON_IMPLEMENTATION(imageEdgeInsets,setImageEdgeInsets,UIEdgeInsets);

G_CHAIN_BUTTON_IMPLEMENTATION(enabled,setEnabled,BOOL);
G_CHAIN_BUTTON_IMPLEMENTATION(selected,setSelected,BOOL);
G_CHAIN_BUTTON_IMPLEMENTATION(highlighted,setHighlighted,BOOL);

- (UIImage *)zj_imageWithColor:(UIColor *)color{
    if (!color) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

//static char const* const isCanSoonClickConst = "isCanSoonClickConst";
@implementation UIButton (GChain)

- (GButtonChainModel *)g_chain{
    
    GButtonChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[GButtonChainModel class]], @"类型错误");

        model = [GButtonChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}

+(UIButton*)g_Init:(void (^)(UIButton* gs))initBlock{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.g_chain.isCanSoonClickChain = NO;
    if (initBlock) {
        initBlock(button);
    }
    return button;
}
+(UIButton*)g_Init:(void (^)(UIButton* gs))initBlock withSuperView:(UIView*)superView withMasonry:(void (^)(MASConstraintMaker *make,UIButton* gs))masBlock withAction:(void (^)(UIButton*gs))actionBlock{
    UIButton* button = [UIButton g_Init:initBlock];
    [superView addSubview:button];
    if (masBlock) {
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            masBlock(make,button);
        }];
    }
    [button zj_addBtnActionHandler:^{
        if (button.g_chain.isCanSoonClickChain) {
            button.userInteractionEnabled = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                button.userInteractionEnabled = YES;
            });
        }
      
       
        actionBlock(button);
    }];
   
    return button;
    
}

//-(BOOL)isCanSoonClick{
//
//    return [objc_getAssociatedObject(self, isCanSoonClickConst) boolValue];
//}
//
//-(void)setIsCanSoonClick:(BOOL)isCanSoonClick{
//        objc_setAssociatedObject(self, isCanSoonClickConst, [NSNumber numberWithBool:isCanSoonClick], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
#pragma mark - 点击事件
-(void)zj_addBtnActionHandler:(ButtonTouchUpInsideBlock)touchHandler{
    objc_setAssociatedObject(self, @selector(zj_addBtnActionHandler:), touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(blockActionTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(blockActionTouchUp:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)blockActionTouchUp:(UIButton *)sender{
    ButtonTouchUpInsideBlock block = objc_getAssociatedObject(self, @selector(zj_addBtnActionHandler:));
    if (block) {
        block();
    }
}
#pragma mark - 设置图片位置
-(UIButton*)gs_setButtonImagePosition:(GButtonImagePosition)position spacing:(CGFloat)spacing
{
    
   // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    NSAssert(imageWith != 0 && imageHeight !=0, @"frame=zero,checkFrame,image");

  
       CGFloat labelWidth = 0.0;
       CGFloat labelHeight = 0.0;
       if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
           // 由于iOS8中titleLabel的size为0，用下面的这种设置
           labelWidth = self.titleLabel.intrinsicContentSize.width;
           labelHeight = self.titleLabel.intrinsicContentSize.height;
       } else {
           labelWidth = self.titleLabel.frame.size.width;
           labelHeight = self.titleLabel.frame.size.height;
       }
    
       // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
       UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
       UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
   // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (position) {
        case GButtonImagePositionTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-spacing/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-spacing/2.0, 0);
        }
            break;
        case GButtonImagePositionLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2.0, 0, spacing/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, spacing/2.0, 0, -spacing/2.0);
        }
            break;
        case GButtonImagePositionBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-spacing/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-spacing/2.0, -imageWith, 0, 0);
        }
            break;
        case GButtonImagePositionRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+spacing/2.0, 0, -labelWidth-spacing/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-spacing/2.0, 0, imageWith+spacing/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋
    
    self.titleEdgeInsets = labelEdgeInsets;
    
    self.imageEdgeInsets = imageEdgeInsets;
    return self;
}

@end
