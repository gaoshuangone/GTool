//
//  GViewChainModel.h
//  GKitTool
//
//  Created by 邓志坚 on 2020/3/23.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "GBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN

#define G_CHAIN_PROPERTY  @property (nonatomic, copy, readonly)

@class GViewChainModel;

@interface GViewChainModel : GBaseChainModel <GViewChainModel *>


@end

typedef void(^TapBlock)(void);

@interface UIView (GChain)

-(GViewChainModel *)g_chain;

-(void)gs_addTapAction:(TapBlock)block;
@end
NS_ASSUME_NONNULL_END
