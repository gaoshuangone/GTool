//
//  CornerCell.m
//  Doctor
//
//  Created by gaoshuang on 2021/10/3.
//  Copyright © 2021 jiaguoshang. All rights reserved.
//

#import "GTableViewCellCorner.h"
@interface GTableViewCellCorner()
@property (strong, nonatomic)UIImageView* topCornerView;
@property (strong, nonatomic)UIImageView* bottomCornerView;
@property (strong, nonatomic)UIView* midCornerView;

@property (assign, nonatomic)CGFloat cellWide;
@property (assign, nonatomic)CGFloat cellHight;

@property (assign, nonatomic)CGFloat cornerValue;
@end
@implementation GTableViewCellCorner

-(void)addCornerViewWithCellWide:(CGFloat)cellWide withCornerValue:(CGFloat)cornerValue{
    self.cellWide =cellWide;
    self.cornerValue = cornerValue;
    self.cellHight = cornerValue*2;

    [self setCornerView];
}
-(void)setCornerBgColor:(UIColor*)color{
    _midCornerView.backgroundColor = color;
    _bottomCornerView.backgroundColor= color;
    _topCornerView.backgroundColor= color;
}
-(void)setCornerView{
    
    UIImageView *imageViewTop = [[UIImageView alloc] init];
    [self.contentView addSubview:imageViewTop];
    [imageViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.cellHight);
        make.top.mas_equalTo(0);
    }];
    
    UIImageView *imageViewBot = [[UIImageView alloc] init];
    [self.contentView addSubview:imageViewBot];
    [imageViewBot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.cellHight);
    }];
    
    
    UIBezierPath *maskPath;
    CGRect cellSize = CGRectMake(0, 0, self.cellWide, self.cellHight);
    maskPath = [UIBezierPath bezierPathWithRoundedRect:cellSize byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(self.cornerValue*2, self.cornerValue*2)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cellSize;
    maskLayer.path = maskPath.CGPath;
    imageViewTop.layer.mask = maskLayer;
    imageViewTop.clipsToBounds = YES;
    
    UIBezierPath *maskPath1;
    maskPath1 = [UIBezierPath bezierPathWithRoundedRect:cellSize byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(self.cornerValue*2, self.cornerValue*2)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = cellSize;
    maskLayer1.path = maskPath1.CGPath;
    imageViewBot.layer.mask = maskLayer1;
    imageViewBot.clipsToBounds = YES;
    
    UIView *backkkk = [[UIView alloc] init];
    [self.contentView addSubview:backkkk];
    [backkkk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(imageViewBot.mas_top);
        make.top.equalTo(imageViewTop.mas_bottom);
    }];

    self.midCornerView = backkkk;
    self.topCornerView = imageViewTop;
    self.bottomCornerView = imageViewBot;
   
}
#pragma mark---显示圆角 /** 设置圆角 0顶部圆角，1底部圆角，2没有圆角，3同时圆角*/
-(void)setCornerType:(CornerType)whichStyle{
    CGFloat maxHeight = self.cellHight;
    CGFloat minHeight = 0;
    switch (whichStyle) {
        case kCornerType_top:
            [self.topCornerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(maxHeight);
            }];
            [self.bottomCornerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(minHeight);
            }];
            
            break;
        case kCornerType_bottom:
            [self.bottomCornerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(maxHeight);
            }];
            [self.topCornerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(minHeight);
            }];
            
            break;
        case kCornerType_none:
            [self.topCornerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(minHeight);
            }];
            [self.bottomCornerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(minHeight);
            }];
            
            break;
        case kCornerType_all:
            [self.topCornerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(maxHeight);
            }];
            [self.bottomCornerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(maxHeight);
            }];
            
            break;
        default:
            break;
    }
}
@end
