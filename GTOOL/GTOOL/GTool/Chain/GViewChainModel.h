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

/// 第三方
@interface UIView (GChain)

-(GViewChainModel *)g_chain;

///添加响应事件
-(void)g_addTapAction:(TapBlock)block;

//复制一个view
+(__kindof UIView*)g_copyView:(UIView*)view;

@end



NS_ASSUME_NONNULL_END
