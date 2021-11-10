//
//  HWProgressView.m
//  Doctor
//
//  Created by gaoshuang on 2021/10/30.
//  Copyright © 2021 jiaguoshang. All rights reserved.
//

#import "HWProgressView.h"

#define KProgressPadding 1.0f
@interface HWProgressView ()

@property (nonatomic, weak) UIView *tView;
@property (nonatomic, weak) UIView *borderView;

@end

@implementation HWProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //边框
        UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
        borderView.layer.cornerRadius = self.bounds.size.height * 0.5;
        borderView.layer.masksToBounds = YES;
        borderView.backgroundColor = [UIColor whiteColor];
        borderView.layer.borderColor = [[UIColor blueColor] CGColor];
        borderView.layer.borderWidth = 2.0f;
        self.borderView=borderView;
        [self addSubview:borderView];
        
        //进度
        UIView *tView = [[UIView alloc] init];
        tView.backgroundColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1];
        tView.layer.cornerRadius = (self.bounds.size.height - (2.0f + 1.0f) * 2) * 0.5;
        tView.layer.masksToBounds = YES;
        [self addSubview:tView];
        self.tView = tView;
    }
    
    return self;
}

-(void)setProgerssColor:(UIColor *)progerssColor{
    _progerssColor=progerssColor;
    _tView.backgroundColor=progerssColor;
}

-(void)setProgerStokeWidth:(CGFloat)progerStokeWidth{
    _progerStokeWidth=progerStokeWidth;
    _borderView.layer.borderWidth = progerStokeWidth;
    
}
-(void)setProgerssStokeBackgroundColor:(UIColor *)progerssStokeBackgroundColor{
    _progerssStokeBackgroundColor=progerssStokeBackgroundColor;
     _borderView.layer.borderColor = [progerssStokeBackgroundColor CGColor];
}
-(void)setProgerssBackgroundColor:(UIColor *)progerssBackgroundColor{
    _progerssBackgroundColor = progerssBackgroundColor;
    _borderView.backgroundColor=progerssBackgroundColor;
}

//更新进度
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat margin = self.progerStokeWidth + KProgressPadding;
    CGFloat maxWidth = self.bounds.size.width - margin * 2;
    CGFloat heigth = self.bounds.size.height - margin * 2;
    
    _tView.frame = CGRectMake(margin, margin, maxWidth * progress, heigth);
}

@end
