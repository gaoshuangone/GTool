//
//  GLabelChainModel.h
//  GKitTool
//
//  Created by 邓志坚 on 2020/3/27.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class GLabelChainModel;

@interface GLabelChainModel : GBaseChainModel<GLabelChainModel *>

G_CHAIN_PROPERTY GLabelChainModel *(^ text)(NSString *text);
G_CHAIN_PROPERTY GLabelChainModel *(^ font)(UIFont *font);
G_CHAIN_PROPERTY GLabelChainModel *(^ textColor)(UIColor *textColor);
G_CHAIN_PROPERTY GLabelChainModel *(^ attributedText)(NSAttributedString *attributedText);

G_CHAIN_PROPERTY GLabelChainModel *(^ textAlignment)(NSTextAlignment textAlignment);
G_CHAIN_PROPERTY GLabelChainModel *(^ numberOfLines)(NSInteger numberOfLines);
G_CHAIN_PROPERTY GLabelChainModel *(^ lineBreakMode)(NSLineBreakMode lineBreakMode);
G_CHAIN_PROPERTY GLabelChainModel *(^ adjustsFontSizeToFitWidth)(BOOL adjustsFontSizeToFitWidth);

@end

@interface UILabel (GChain)

-(GLabelChainModel *)g_chain;

+(UILabel*)g_Init:(void (^)(UILabel* gs))initBlock;
+(UILabel*)g_Init:(void (^)(UILabel* gs))initBlock withSuperView:(UIView*)superView withMasonry:(void (^)(MASConstraintMaker *make,UILabel* gs))masBlock;

@end
NS_ASSUME_NONNULL_END
