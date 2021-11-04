//
//  GViewChainModel.m
//  GKitTool
//
//  Created by 邓志坚 on 2020/3/23.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "GViewChainModel.h"
#import <objc/runtime.h>

#define weak_self(value)     __weak typeof(value) weakSelf = value

#pragma mark - Masonry
#define  G_CHAIN_MASONRY_IMPLEMENTATION(methodType, methodName, masonryMethod, view) \
- (methodType)methodName{  \
    __weak typeof(self) weakSelf = self; \
    return ^GViewChainModel * ( void (^constraints)(__kindof UIView *, MASConstraintMaker *) ) { \
        if (weakSelf.chainView.superview) { \
            [view  masonryMethod:^(MASConstraintMaker *make){ \
                constraints(view, make); \
            }]; \
        } \
        return weakSelf; \
    }; \
} \


#define  G_CHAIN_MASONRY_IMPLEMENTATION_NULL(methodType, methodName, masonryMethod) \
- (methodType)methodName{ \
    __weak typeof(self) weakSelf = self; \
    return ^id ( void (^constraints)(__kindof UIView *, MASConstraintMaker *) ) { \
        return weakSelf; \
    }; \
}\

#pragma mark - Shadow
#define  G_CHAIN_SHADOW_IMPLEMENTATION(methodType, methodName, layerMethod, view, ParmaType) \
- (methodType)methodName{ \
    weak_self(self); \
    return ^(ParmaType parma){ \
        [view.layer layerMethod:parma]; \
        return weakSelf; \
    }; \
} \

#define  G_CHAIN_VIEW_IMPLEMENTATION(className, methodType, methodName, viewMethod, ParmaType) \
- (methodType)methodName{ \
   __weak typeof(self) weakSelf = self; \
    if ([self.chainView.class instancesRespondToSelector:@selector(viewMethod:)]) { \
        return ^(ParmaType param){ \
            [(className *)weakSelf.chainView viewMethod:param]; \
            return weakSelf; \
        }; \
    } \
    return ^(ParmaType paramt){ \
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.chainView.class),__func__); \
        return weakSelf; \
    }; \
} \



@implementation GViewChainModel

@end

@implementation UIView (GChain)



- (GViewChainModel *)g_chain{
    
    GViewChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[GViewChainModel class]], @"类型错误");

        model = [GViewChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}
-(void)g_addTapAction:(TapBlock)bloc{
    
    if(bloc){
        
        objc_setAssociatedObject(self, @selector(tapAction:), bloc, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [self addGestureRecognizer:tap];
    
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    TapBlock bloc = objc_getAssociatedObject(self, _cmd);
    
    if (bloc) {
        
        bloc();
    }
    
}
+(__kindof UIView*)g_copyView:(UIView*)view{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
+(UIView*)g_Init:(void (^)(UIView* gs))initBlock{
    UIView* view = [[UIView alloc]init];
    if (initBlock) {
        initBlock(view);
    }
    return view;
}
+(UIView*)g_Init:(void (^)(UIView* gs))initBlock withSuperView:(UIView*)superView withMasonry:(void (^)(MASConstraintMaker *make,UIView* gs))masBlock{
    UIView* view = [UIView g_Init:initBlock];
    [superView addSubview:view];
    if (masBlock) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            masBlock(make,view);
        }];
    }
//    view.showVisual();
    return view;
}
@end



