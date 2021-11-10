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
/*约束最大宽度

 // 1  preferredMaxLayoutWidth 需要配合numberOfLines=0使用
 label.preferredMaxLayoutWidth = 100.f
 label.numberOfLines=0
 
 // 2 推荐使用
     make.width.lessThanOrEqualTo(@100);//支持单行


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

/* YYText
NSString* str = @"点击注册/登录表示同意用户协议";
NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
text.yy_font = [UIFont systemFontOfSize:16];
text.yy_color = [UIColor blueColor];
[text yy_setUnderlineStyle:NSUnderlineStyleSingle range:[str rangeOfString:@"用户协议"]];
[text yy_setTextHighlightRange:[str rangeOfString:@"用户协议"] color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000] backgroundColor:[UIColor redColor] userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
} longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
}];
YYLabel *label = [YYLabel new];
label.attributedText = text;
label.textAlignment = NSTextAlignmentCenter;
label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
label.numberOfLines = 0;
label.backgroundColor = kClearColor;
label.displaysAsynchronously = YES;   //比较耗时的渲染操作在后台运行
label.clearContentsBeforeAsynchronouslyDisplay = NO;  //在进行后台渲染前是否清除掉之前的内容，如果YES就会先清除之前的内容，可能会出现空白
YYTextContainer  *titleContarer = [YYTextContainer new];
titleContarer.size = CGSizeMake(SCREEN_WIDTH,CGFLOAT_MAX);
label.textLayout = [YYTextLayout layoutWithContainer:titleContarer text:text];
//    CGFloat titleLabelHeight = label.textLayout.textBoundingSize.height;
// YYLabel要想自动换行，必须设置最大换行的宽度
// label.preferredMaxLayoutWidth = SCREEN_WIDTH-40;
[_viewLogin addSubview:label];
[label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(label.textLayout.textBoundingSize);
    make.centerX.equalTo(_viewLogin);
    make.bottom.equalTo(_viewLogin).offset(-20);
}];
 */
