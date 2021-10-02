//
//  GGridView.h
//  LiveTool
//
//  Created by tg on 2021/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGridView : UIView
/// 初始化
/// @param frame 所在位置的bounds
/// @param count 需要展示总数据量
/// @param insets 距离边界上左下右
/// @param fixedSpacingX 横向间距
/// @param fixedSpacingY 纵向间距
/// @param countMax 单行最大数量
/// @param blockView 返回的view中自动添加内容 已设置tag
-(id)initWithFrame:(CGRect)frame withItemCount:(NSInteger)count withMaxItemCount:(NSInteger)countMax withSuperEdgeInsets:(UIEdgeInsets)insets withFixedSpacingX:(CGFloat)fixedSpacingX withFixedSpacingY:(CGFloat)fixedSpacingY  withBlock:(void (^)(UIView*view))blockView;

@end

NS_ASSUME_NONNULL_END
/*
 GGridView* view = [[GGridView alloc]initWithFrame:CGRectMake(0, 73, viewEffectView.frameWidth, 55+8+18) withItemCount:1 withMaxItemCount:4 withSuperEdgeInsets:UIEdgeInsetsMake(0, 27/2, 0,27/2) withFixedSpacingX:2 withFixedSpacingY:0  withBlock:^(UIView * _Nonnull view) {
     NSDictionary* dict = self->_arrayData[0];
     UIButton* button= [UIButton g_Init:^(UIButton * _Nonnull gs) {
         gs.g_chain.image(kImageName(@"logoTemp"), 0).title(@"111", 0).titleFont(kFontRegular(13)).titleColor(kColorHexString(@"686868"), 0);
         gs.tag = view.tag;
     } withSuperView:view withMasonry:^(MASConstraintMaker * _Nonnull make, UIButton * _Nonnull gs) {
         make.edges.equalTo(view);
     } withAction:^(UIButton * _Nonnull gs) {
         [self pushCanvas:@"LoginErrorViewController" withBlock:^(UIViewController *vc) {
             [vc setValue:dict forKey:@"dict"];
         }];
     }];
     [button g_setButtonImagePosition:GButtonImagePositionTop spacing:8];
     
 }];

 [viewEffectView addSubview:view];
 */
