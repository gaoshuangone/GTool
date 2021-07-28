//
//  GBaseChainModel.h
//  GKitTool
//
//  Created by 邓志坚 on 2020/3/22.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Masonry.h"
NS_ASSUME_NONNULL_BEGIN

#define G_CHAIN_PROPERTY  @property (nonatomic, copy, readonly)


#define  G_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, GViewChainModelType, GViewClass) \
- (GViewChainModelType (^)(ParmaType param))methodName{ \
    __weak typeof(self) weakSelf = self; \
    if ([self.view.class instancesRespondToSelector:@selector(viewMethod:)]) {\
        return ^(ParmaType param){ \
            [(GViewClass *)weakSelf.view viewMethod:param];   \
            return weakSelf; \
        };  \
    }else{  \
        return ^(ParmaType param){ \
            return weakSelf; \
        }; \
    } \
} \


@class MASConstraintMaker;

@interface GBaseChainModel <ObjcType>  : NSObject
/// 视图的唯一标示

@property (nonatomic, strong) __kindof UIView *view;

G_CHAIN_PROPERTY ObjcType (^ superView)(UIView *superView);


#pragma mark - AutoLayout
G_CHAIN_PROPERTY ObjcType (^ makeMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );
G_CHAIN_PROPERTY ObjcType (^ updateMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );
G_CHAIN_PROPERTY ObjcType (^ remakeMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );

#pragma mark - # Frame
G_CHAIN_PROPERTY ObjcType (^ frame)(CGRect frame);

G_CHAIN_PROPERTY ObjcType (^ origin)(CGPoint origin);
G_CHAIN_PROPERTY ObjcType (^backgroundColor)(UIColor *backgroundColor);


G_CHAIN_PROPERTY ObjcType (^ contentMode)(UIViewContentMode contentMode);
G_CHAIN_PROPERTY ObjcType (^ opaque)(BOOL opaque);
G_CHAIN_PROPERTY ObjcType (^ hidden)(BOOL hidden);

#pragma mark - # Layer
G_CHAIN_PROPERTY ObjcType (^cornerRadius)(CGFloat cornerRadius);
G_CHAIN_PROPERTY ObjcType (^borderColor)(CGColorRef borderColor);
G_CHAIN_PROPERTY ObjcType (^borderWidth)(CGFloat borderWidth);
G_CHAIN_PROPERTY ObjcType (^userInteractionEnabled)(BOOL userInteractionEnabled);
G_CHAIN_PROPERTY ObjcType (^clipsToBounds)(BOOL clipsToBounds);

#pragma mark - Shadow
G_CHAIN_PROPERTY ObjcType (^shadowColor)(CGColorRef shadowColor);
G_CHAIN_PROPERTY ObjcType (^shadowOffset)(CGSize shadowOffset);
G_CHAIN_PROPERTY ObjcType (^shadowRadius)(CGFloat shadowRadius);
G_CHAIN_PROPERTY ObjcType (^shadowOpacity)(float shadowOpacity);
G_CHAIN_PROPERTY ObjcType (^shadowPath)(CGRect roundedRect, CGFloat cornerRadius);
G_CHAIN_PROPERTY ObjcType (^masksToBounds)(BOOL masksToBounds);
G_CHAIN_PROPERTY ObjcType (^setShadow)(CGColorRef shadowColor,CGSize shadowOffset,CGFloat shadowRadius,float shadowOpacity);

@end

NS_ASSUME_NONNULL_END
