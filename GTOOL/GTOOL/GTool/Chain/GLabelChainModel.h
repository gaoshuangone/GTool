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
//G_CHAIN_PROPERTY GLabelChainModel *(^ textLanguage)(NSString *textLanguage);
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
/*达到最大行时候折行
 preferredMaxLayoutWidth
 // 1
 label.preferredMaxLayoutWidth = 100.f;//等价
 // 2
 [label mas_makeConstraints:^(MASConstraintMaker *make) {
     make.width.lessThanOrEqualTo(@100);//等价
 */

/*抗压缩
 [rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(self.view.mas_top).offset(100);
     make.right.equalTo(self.view.mas_right).offset(-10);
     make.width.mas_greaterThanOrEqualTo(100);   // 这是最小宽度
 }];
 [leftlbl mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(self.view.mas_left).offset(10);
     make.top.equalTo(self.view.mas_top).offset(100);
     make.right.equalTo(rightLbl.mas_left).offset(-10);
     make.width.mas_greaterThanOrEqualTo(100);   // 这是最小宽度
 }];
 // 设置抗压缩优先级
 
 //setContentHuggingPriority: 优先级越高，代表压缩越厉害，越晚被拉伸
// setContentCompressionResistancePriority:： 优先级越高，代表拉伸越厉害，越晚被压缩
 [leftlbl setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
 [rightLbl setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
 */
/*极限约束
 [orangeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(self.view.mas_left).offset(10);
     make.top.equalTo(self.view.mas_top).offset(200);
     make.width.mas_greaterThanOrEqualTo(self.view.frame.size.width * 0.5 - 10); // 设置最小宽度
     make.right.mas_lessThanOrEqualTo(self.view.mas_right).offset(-10);  // 设置距离右边最小距离
 }];
 */
