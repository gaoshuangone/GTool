//
//  UIView+GradualLayer.h
//  DRLive
//
//  Created by tg on 2020/9/14.
//  Copyright © 2020 DRLive. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface UIView (GradualLayer)


-(void)addGradualLayerWithColors:(NSArray *)colors;
-(void)addGradualLayerWithColors:(NSArray *)colors withEndPoint:(CGPoint)endpoint withFrame:(CGRect)frame;


-(void)addBlurEffect;//UIBlurEffectStyleDark
-(void)addBlurEffectWithAppha:(CGFloat)alpha;//UIBlurEffectStyleDark
-(void)addBlurEffectWIthstyle:(UIBlurEffectStyle)style WithAppha:(CGFloat)alpha;

@end

//NS_ASSUME_NONNULL_END
