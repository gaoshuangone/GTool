//
//  UIView+CNMPosition.h
//  Example
//
//  Created by 高爽 on 2017/11/2.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GView)
@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize frameSize;

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat frameRight;
@property (nonatomic) CGFloat frameBottom;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

@property (nonatomic) CGFloat boundsWide;
@property (nonatomic) CGFloat boundsHeight;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

-(BOOL) containsSubView:(UIView *)subView;

- (UIViewController*)viewController;
///重新方法标记lastView
///    [ UIView overrideMethod:@selector(mas_makeConstraints:) withMethod:@selector(mas_makeConstraints_lastView)];

- (NSArray *)mas_makeConstraints_lastView:(void(^)(MASConstraintMaker *))block;

@end
