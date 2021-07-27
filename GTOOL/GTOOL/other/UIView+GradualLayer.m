//
//  UIView+GradualLayer.m
//  DRLive
//
//  Created by tg on 2020/9/14.
//  Copyright © 2020 DRLive. All rights reserved.
//

#import "UIView+GradualLayer.h"

@implementation UIView (GradualLayer)

-(void)addGradualLayerWithColors:(NSArray *)colors {

    [self addGradualLayerWithColors:colors withEndPoint:CGPointMake(1, 0) withFrame:self.bounds];
}
-(void)addGradualLayerWithColors:(NSArray *)colors withEndPoint:(CGPoint)endpoint withFrame:(CGRect)frame{
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    CAGradientLayer *_gradientLayer = [CAGradientLayer layer];
    _gradientLayer.startPoint = CGPointMake(0, 0);//第一个颜色开始渐变的位置
    _gradientLayer.endPoint = endpoint;//最后一个颜色结束的位置
    _gradientLayer.frame = frame;//设置渐变图层的大小
    if (colors == nil) {
        //颜色为空时预置的颜色
        _gradientLayer.colors = @[(__bridge id)kColorHexString(@"#F18030").CGColor,(__bridge id)kColorHexString(@"#F7B46A").CGColor];
    }else {
        _gradientLayer.colors = colors;
    }
    
    [self.layer insertSublayer:_gradientLayer atIndex:0];
}
-(void)addBlurEffectWithAppha:(CGFloat)alpha
{
    [self addBlurEffectWIthstyle:UIBlurEffectStyleDark WithAppha:alpha];
}
-(void)addBlurEffect{
    
    [self addBlurEffectWIthstyle:UIBlurEffectStyleDark WithAppha:.4f];
}
-(void)addBlurEffectWIthstyle:(UIBlurEffectStyle)style WithAppha:(CGFloat)alpha{
    UIView* view = [self viewWithTag:@"UIBlurEffect".hash];
    if (view) {
        [view removeFromSuperview];
    }
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
      UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
      effectView.frame = self.bounds;
    effectView.tag = @"UIBlurEffect".hash;
    effectView.alpha = alpha;
    [self addSubview:effectView];
    //    [self.layer insertSublayer:effectView.layer atIndex:0];

    //    [self.layer addSubview:effectView.layer];
}
@end
