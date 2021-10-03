//
//  CornerCell.h
//  Doctor
//
//  Created by gaoshuang on 2021/10/3.
//  Copyright © 2021 jiaguoshang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, CornerType) {
    kCornerType_top,
    kCornerType_bottom,
    kCornerType_none,
    kCornerType_all,
};
@interface GTableViewCellCorner : UITableViewCell


/// 添加圆角背景
/// @param cellWide cell宽度
/// @param cornerValue 圆角角度
-(void)addCornerViewWithCellWide:(CGFloat)cellWide withCornerValue:(CGFloat)cornerValue;
///设置cell背景颜色
-(void)setCornerBgColor:(UIColor*)color;
//设置圆角类型
-(void)setCornerType:(CornerType)whichStyle;

@end

NS_ASSUME_NONNULL_END

/*
 -(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {

         [self addCornerViewWithCellWide:kMainScreenWide()-24 withCornerValue:20];
         [self setCornerBgColor:kColorStringHexA(@"50938A", .1f)];
         //    cell.backgroundColor =kColorStringHexA(@"50938A", .1f);

     }
     return self;
 }

 -(void)upDateView:(AuthorityDoctorModel*)model{
     [self setCornerType:kCornerType_all];
 }

 */
