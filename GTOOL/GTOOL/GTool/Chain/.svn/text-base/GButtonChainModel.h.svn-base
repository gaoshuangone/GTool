//
//  GButtonChainModel.h
//  GKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "GBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class GButtonChainModel;

@interface GButtonChainModel : GBaseChainModel<GButtonChainModel *>

G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^title)(NSString *title , UIControlState state);
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^titleColor)(UIColor *titleColor , UIControlState state);
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^titleFont)(UIFont *titleFont);
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^attributedTitle)(NSAttributedString *attributedTitle , UIControlState state);

G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^image)(UIImage *image , UIControlState state);
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^backgroundImage)(UIImage *image , UIControlState state);
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^backgroundColorState)(UIColor *color , UIControlState state);

G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^contentEdgeInsets)(UIEdgeInsets contentEdgeInsets);
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^titleEdgeInsets)(UIEdgeInsets titleEdgeInsets);
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^imageEdgeInsets)(UIEdgeInsets imageEdgeInsets);

G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^enabled)(BOOL enabled);
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^selected)(BOOL selected);
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^highlighted)(BOOL highlighted);
//是否可以快速点击 default  YES
G_CHAIN_PROPERTY GButtonChainModel *_Nullable(^isCanSoonClick)(BOOL soonClick);


@end

typedef enum : NSUInteger {
    GButtonImagePositionLeft,              // 图片在左
    GButtonImagePositionRight,             // 图片在右
    GButtonImagePositionTop,               // 图片在上
    GButtonImagePositionBottom             // 图片在下
} GButtonImagePosition;


typedef void (^ButtonTouchUpInsideBlock)(void);
@interface UIButton (GChain)
-(GButtonChainModel *)g_chain;

+(UIButton*)g_Init:(void (^)(UIButton* gs))initBlock;
+(UIButton*)g_Init:(void (^)(UIButton* gs))initBlock withSuperView:(UIView*)superView withMasonry:(void (^)(MASConstraintMaker *make,UIButton* gs))masBlock withAction:(void (^)(UIButton*gs))actionBlock;

-(UIButton*)gs_setButtonImagePosition:(GButtonImagePosition)position spacing:(CGFloat)spacing;

-(void)zj_addBtnActionHandler:(ButtonTouchUpInsideBlock)touchHandler;

//+(UIButton*)g_Init:(void (^)(UILabel* gs))block;
//+(UIButton*)g_Init:(void (^)(UILabel* gs))block withSuperView:(UIView*)sueperView withMasonry:(void (^)(MASConstraintMaker *make,UILabel* gs))block withAction:(void (^)(UIButton*gs))block;
@end

NS_ASSUME_NONNULL_END
