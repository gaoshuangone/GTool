//
//  GUIImageViewChainModel.h
//  GKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "GBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class GUIImageViewChainModel;

@interface GUIImageViewChainModel : GBaseChainModel<GUIImageViewChainModel *>

G_CHAIN_PROPERTY  GUIImageViewChainModel *_Nullable(^image)(UIImage *image);
G_CHAIN_PROPERTY GUIImageViewChainModel *_Nullable(^highlightedImage)(UIImage *image);
G_CHAIN_PROPERTY GUIImageViewChainModel *_Nullable(^highlighted)(BOOL highlighted);

@end

@interface UIImageView (GChain)

-(GUIImageViewChainModel *)g_chain;

+(UIImageView*)g_Init:(void (^)(UIImageView* gs))initBlock;

+(UIImageView*)g_Init:(void (^)(UIImageView* gs))initBlock withSuperView:(UIView*)superView withMasonry:(void (^)(MASConstraintMaker *make,UIImageView* gs))masBlock;

@end
NS_ASSUME_NONNULL_END
